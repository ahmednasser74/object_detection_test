import 'package:an_core_ui/an_core_ui.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:object_detection_test/core/src/index.dart';

import '../provider/index.dart';
import '../widgets/detection_bounding_boxes_widget.dart';

class CameraDetectionScreen extends BaseStatefulWidget {
  final ({String? objectName, List<CameraDescription> cameras}) arg;

  const CameraDetectionScreen({super.key, required this.arg});

  @override
  BaseState<CameraDetectionScreen> createState() => _CameraDetectionScreenState();
}

class _CameraDetectionScreenState extends BaseState<CameraDetectionScreen> {
  late final CameraStreamProvider provider;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<CameraStreamProvider>(context, listen: false);
    provider.loadModel();
    provider.initializeCamera(widget.arg.cameras, widget.arg.objectName);
  }

  @override
  String? get appBarTitle {
    return widget.arg.objectName != null ? '${widget.arg.objectName} Detection'.toCamelCase : 'Object Detection';
  }

  @override
  Widget getBody(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) disposeControllers();
      },
      child: Consumer<CameraStreamProvider>(
        builder: (context, provider, child) {
          if (!provider.controller!.value.isInitialized) {
            return Container();
          }

          return Stack(
            children: [
              CameraPreview(provider.controller!),
              if (provider.recognitions != null && !provider.isDetectingWrongObject)
                Positioned.fill(
                  child: DetectionBoundingBoxes(
                    recognitions: provider.recognitions!,
                    previewH: provider.imageHeight.toDouble(),
                    previewW: provider.imageWidth.toDouble(),
                    screenH: MediaQuery.of(context).size.height,
                    screenW: MediaQuery.of(context).size.width,
                    captureCallback: (String? label) async {
                      // Future.delayed(const Duration(milliseconds: 500), () {
                      final image = await provider.controller!.takePicture();
                      await Future.delayed(const Duration(milliseconds: 500));
                      if (mounted) {
                        disposeControllers();
                        context.pushReplacementNamed(
                          Routes.resultScreen,
                          arguments: (imagePath: image.path, objectName: widget.arg.objectName ?? label),
                        );
                      }
                      // });
                    },
                  ),
                ),
              _wrongObjectDetection(provider),
            ],
          );
        },
      ),
    );
  }

  Widget _wrongObjectDetection(CameraStreamProvider provider) {
    if (!provider.isDetectingWrongObject) return const SizedBox.shrink();
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.red,
        child: ListTile(
          leading: const Icon(Icons.info, color: Colors.white),
          title: const AppText('You are showing wrong object', color: Colors.white),
          subtitle: AppText('Please show ${widget.arg.objectName} object', size: 12.sp, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void disposeControllers() {
    final provider = Provider.of<CameraStreamProvider>(context, listen: false);
    provider.disposeControllers();
    // provider.dispose();
  }
}
