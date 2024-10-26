import 'package:physiotherapy_body_detection/app/data/models/exercise.dart';

class Report {
  String id;
  Exercise exercise;
  String date;
  String time;
  String correctness;

  Report({
    required this.id,
    required this.exercise,
    required this.date,
    required this.time,
    required this.correctness,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      exercise: json['exercise'],
      date: json['date'],
      time: json['time'],
      correctness: json['correctness'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise': exercise,
      'date': date,
      'time': time,
      'correctness': correctness,
    };
  }

  @override
  String toString() {
    return 'Report(id: $id, exercise: $exercise, date: $date, time: $time, correctness:$correctness)';
  }
}
