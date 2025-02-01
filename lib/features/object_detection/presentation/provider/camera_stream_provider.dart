import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:object_detection_test/core/src/assets.gen.dart';
import 'package:tflite_v2/tflite_v2.dart';

class CameraStreamProvider with ChangeNotifier {
  CameraController? _controller;
  bool _isModelLoaded = false;
  bool _isProcessing = false;
  bool _isDetectingWrongObject = false;
  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  bool get isModelLoaded => _isModelLoaded;
  bool get isProcessing => _isProcessing;
  bool get isDetectingWrongObject => _isDetectingWrongObject;
  List<dynamic>? get recognitions => _recognitions;
  int get imageHeight => _imageHeight;
  int get imageWidth => _imageWidth;
  CameraController? get controller => _controller;

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: Assets.models.detect,
      labels: Assets.models.labelmap,
    );
    _isModelLoaded = res != null;
    notifyListeners();
  }

  Future<void> initializeCamera(List<CameraDescription> cameras, String? objectName) async {
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();

    _controller!.startImageStream((CameraImage image) {
      if (_isModelLoaded && !_isProcessing) {
        startDetection(image, objectName);
      }
    });

    notifyListeners();
  }

  Future<void> startDetection(CameraImage image, String? objectName) async {
    if (_isProcessing) return; // Prevent concurrent execution
    _isProcessing = true;

    if (image.planes.isEmpty) {
      _isProcessing = false;
      return;
    }

    try {
      _controller!.stopImageStream(); // Pause the camera stream

      var recognitions = await Tflite.detectObjectOnFrame(
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        model: 'SSDMobileNet',
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResultsPerClass: 1,
        threshold: 0.4,
      );

      if (recognitions == null || recognitions.isEmpty) return;
      if (objectName != null && recognitions[0]['detectedClass'] != objectName) {
        _isDetectingWrongObject = true;
        notifyListeners();
        return;
      }
      _isDetectingWrongObject = false;
      _recognitions = recognitions;
      _imageHeight = image.height;
      _imageWidth = image.width;

      notifyListeners();
    } catch (error, stackTrace) {
      print('Error running model: $error');
      print('Stack trace: $stackTrace');
    } finally {
      _isProcessing = false;
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!_controller!.value.isStreamingImages) {
          _controller!.startImageStream((CameraImage img) => startDetection(img, objectName));
        }
      });
    }
  }

  void reset() {
    _isModelLoaded = false;
    _isProcessing = false;
    _isDetectingWrongObject = false;
    _recognitions = null;
    _imageHeight = 0;
    _imageWidth = 0;
    notifyListeners();
  }

  void disposeControllers() {
    if (_controller != null && _controller!.value.isInitialized) {
      _controller!.stopImageStream(); // Stop the image stream
      _controller!.dispose(); // Dispose of the controller
      _controller = null; // Clear the reference
    }
    Tflite.close(); // Close TensorFlow Lite
    reset(); // Reset all state variables
  }
}
