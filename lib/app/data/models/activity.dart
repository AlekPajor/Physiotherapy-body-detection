import 'package:physiotherapy_body_detection/app/data/models/exercise.dart';

class Activity {
  int? id;
  Exercise exercise;
  String duration;
  String startingTime;
  String period;

  Activity({
    this.id,
    required this.exercise,
    required this.duration,
    required this.startingTime,
    required this.period,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      exercise: json['exercise'],
      duration: json['duration'],
      startingTime: json['startingTime'],
      period: json['period'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise': exercise,
      'duration': duration,
      'startingTime': startingTime,
      'period': period,
    };
  }

  @override
  String toString() {
    return 'Activity(id: $id, exercise: $exercise, duration: $duration, startingTime: $startingTime, period:$period)';
  }
}
