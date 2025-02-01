class RecognizedObjectModel {
  final String label;
  final double confidence;
  final double x;
  final double y;
  final double w;
  final double h;

  RecognizedObjectModel({
    required this.label,
    required this.confidence,
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });

  factory RecognizedObjectModel.fromObject(dynamic object) {
    return RecognizedObjectModel(
      label: object['detectedClass'],
      confidence: object['confidenceInClass'],
      x: object['rect']['x'],
      y: object['rect']['y'],
      w: object['rect']['w'],
      h: object['rect']['h'],
    );
  }
}
