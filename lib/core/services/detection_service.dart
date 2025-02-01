import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:object_detection_test/core/src/index.dart';
import 'package:tflite_v2/tflite_v2.dart';

class DetectionService {
  DetectionService._privateConstructor();
  static final DetectionService _instance = DetectionService._privateConstructor();
  static DetectionService get instance => _instance;

  List<String> labels = [];

  Future<String?> initModels() async {
    try {
      String? res = await Tflite.loadModel(model: Assets.models.detect);
      if (res != null) {
        return res;
      }
      return null;
    } catch (e) {
      print("Error loading model: $e");
      return null;
    }
  }

  Future<List<String>?> getLabels() async {
    try {
      final labelsFiles = await rootBundle.loadString(Assets.models.labelmap);
      labels = labelsFiles.split('\n').map((label) => label.trim()).toList();
      if (labels.isNotEmpty) {
        labels.removeWhere((element) => element.isEmpty || element == '' || element.contains('?'));
        return labels;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>?> detectObject(CameraImage image) async {
    try {
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

      return recognitions;
    } catch (e) {
      return null;
    }
  }

  void dispose() {
    Tflite.close();
  }
}
