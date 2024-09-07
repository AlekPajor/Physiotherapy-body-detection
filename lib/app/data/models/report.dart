class Report {
  String id;
  String activityName;
  String date;
  String time;
  String correctness;

  Report({
    required this.id,
    required this.activityName,
    required this.date,
    required this.time,
    required this.correctness,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      activityName: json['activityName'],
      date: json['date'],
      time: json['time'],
      correctness: json['correctness'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activityName': activityName,
      'date': date,
      'time': time,
      'correctness': correctness,
    };
  }

  @override
  String toString() {
    return 'Report(id: $id, activityName: $activityName, date: $date, time: $time, correctness:$correctness)';
  }
}
