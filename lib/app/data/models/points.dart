class Points {
  int leftElbow;
  int rightElbow;
  int leftKnee;
  int rightKnee;

  Points({
    required this.leftElbow,
    required this.rightElbow,
    required this.leftKnee,
    required this.rightKnee,
  });

  factory Points.fromJson(Map<String, dynamic> json) {
    return Points(
      leftElbow: json['leftElbow'],
      rightElbow: json['rightElbow'],
      leftKnee: json['leftKnee'],
      rightKnee: json['rightKnee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'leftElbow': leftElbow,
      'rightElbow': rightElbow,
      'leftKnee': leftKnee,
      'rightKnee': rightKnee,
    };
  }

  @override
  String toString() {
    return 'Points(leftElbow: $leftElbow, rightElbow: $rightElbow, leftKnee: $leftKnee, rightKnee: $rightKnee)';
  }
}
