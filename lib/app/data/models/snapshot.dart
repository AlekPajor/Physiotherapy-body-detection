import 'package:physiotherapy_body_detection/app/data/models/points.dart';

class Snapshot {
  int? id;
  String time;
  Points points;

  Snapshot({
    this.id,
    required this.time,
    required this.points,
  });

  factory Snapshot.fromJson(Map<String, dynamic> json) {
    return Snapshot(
      id: json['id'],
      time: json['time'],
      points: Points.fromJson(json['points']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'points': points.toJson(),
    };
  }

  @override
  String toString() {
    return 'Snapshot(id: $id, time: $time, points: $points)';
  }
}
