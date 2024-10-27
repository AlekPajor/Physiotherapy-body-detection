import 'package:physiotherapy_body_detection/app/data/models/activity.dart';
import 'package:physiotherapy_body_detection/app/data/models/exercise.dart';

class Report {
  int? id;
  Activity activity;
  String date;
  String time;
  int correctness;

  Report({
    required this.id,
    required this.activity,
    required this.date,
    required this.time,
    required this.correctness,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      activity: Activity.fromJson(json['activity']),
      date: json['date'],
      time: json['time'],
      correctness: json['correctness'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise': activity,
      'date': date,
      'time': time,
      'correctness': correctness,
    };
  }

  @override
  String toString() {
    return 'Report(id: $id, activity: $activity, date: $date, time: $time, correctness:$correctness)';
  }
}
