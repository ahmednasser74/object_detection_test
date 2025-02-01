import 'package:an_core_ui/an_core_ui.dart';
import 'package:flutter/material.dart';

import '../../data/models/recognized_object_model.dart';
import 'detection_corners_customer_painter.dart';

class DetectionBoundingBoxes extends StatefulWidget {
  final List<dynamic> recognitions;
  final double previewH;
  final double previewW;
  final double screenH;
  final double screenW;
  final Function(String? label) captureCallback;

  const DetectionBoundingBoxes({
    super.key,
    required this.recognitions,
    required this.previewH,
    required this.previewW,
    required this.screenH,
    required this.screenW,
    required this.captureCallback,
  });

  @override
  _DetectionBoundingBoxesState createState() => _DetectionBoundingBoxesState();
}

class _DetectionBoundingBoxesState extends State<DetectionBoundingBoxes> {
  bool _callbackExecuted = false;

  @override
  Widget build(BuildContext context) {
    var rec = widget.recognitions.isNotEmpty ? RecognizedObjectModel.fromObject(widget.recognitions[0]) : null;
    if (rec == null) {
      return Container();
    }
    final calc = detectionResponse(rec);
    final accuracy = (rec.confidence * 100).toStringAsFixed(0);
    final isObjectDetected = double.parse(accuracy) > 60;

    if (isObjectDetected && calc.feedback.isEmpty && !_callbackExecuted) {
      widget.captureCallback(rec.label);
      _callbackExecuted = true;
    }

    return Stack(
      children: [
        Positioned(
          left: calc.x,
          top: calc.y,
          width: calc.w,
          height: calc.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  "${rec.label} $accuracy%",
                  color: isObjectDetected ? Colors.green : Colors.red,
                  size: 15,
                  backgroundColor: Colors.black,
                ),
                if (calc.feedback.isNotEmpty)
                  AppText(
                    'ⓘ ${calc.feedback}',
                    color: Colors.red,
                    size: 15,
                    backgroundColor: Colors.black,
                  ),
              ],
            ),
          ),
        ),
        // **Properly oriented corner elements**
        _buildCorner(top: calc.y, left: calc.x, isObjectDetected: isObjectDetected), // Top Left
        _buildCorner(top: calc.y, right: widget.screenW - calc.x - calc.w, mirrorX: true, isObjectDetected: isObjectDetected), // Top Right
        _buildCorner(bottom: widget.screenH - calc.y - calc.h, left: calc.x, mirrorY: true, isObjectDetected: isObjectDetected), // Bottom Left
        _buildCorner(bottom: widget.screenH - calc.y - calc.h, right: widget.screenW - calc.x - calc.w, mirrorX: true, mirrorY: true, isObjectDetected: isObjectDetected), // Bottom Right
      ],
    );
  }

  /// **Generic method to create a properly mirrored corner border**
  Widget _buildCorner({
    double? top,
    double? left,
    double? right,
    double? bottom,
    bool mirrorX = false,
    bool mirrorY = false,
    bool isObjectDetected = false,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          mirrorX ? -1.0 : 1.0,
          mirrorY ? -1.0 : 1.0,
          1.0,
        ),
        child: SizedBox(
          width: 50, // Increased size for a more pronounced corner
          height: 50,
          child: CustomPaint(
            painter: RoundedCornerBorderPainter(
              color: isObjectDetected ? Colors.green : Colors.red,
              thickness: 6, // Increased thickness
              radius: 12, // Added rounded corners
            ),
          ),
        ),
      ),
    );
  }

  /// **Calculate detection box position and feedback**
  ({double x, double y, double w, double h, String feedback}) detectionResponse(RecognizedObjectModel rec) {
    var x = rec.x * widget.screenW;
    var y = rec.y * widget.screenH;
    double w = rec.w * widget.screenW;
    double h = rec.h * widget.screenH;
    double centerX = x + w / 2;
    double centerY = y + h / 2;

    String horizontalFeedback = centerX < widget.screenW * 0.4
        ? "Move left"
        : centerX > widget.screenW * 0.6
            ? "Move right"
            : "";

    String verticalFeedback = centerY < widget.screenH * 0.4
        ? "Move up"
        : centerY > widget.screenH * 0.6
            ? "Move down"
            : "";

    String distanceFeedback = (w * h) > (widget.screenW * widget.screenH * 0.3)
        ? "Move farther"
        : (w * h) < (widget.screenW * widget.screenH * 0.1)
            ? "Move closer"
            : "";

    String feedback = "$horizontalFeedback\n$verticalFeedback\n$distanceFeedback".trim();

    return (x: x, y: y, w: w, h: h, feedback: feedback);
  }
}
