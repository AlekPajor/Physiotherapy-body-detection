class Activity {
  String id;
  String name;
  String duration;
  String startingTime;
  String period;
  List<String>? snapshots;

  Activity({
    required this.id,
    required this.name,
    required this.duration,
    required this.startingTime,
    required this.period,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      startingTime: json['startingTime'],
      period: json['period'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'startingTime': startingTime,
      'period': period,
    };
  }

  @override
  String toString() {
    return 'Activity(id: $id, name: $name, duration: $duration, startingTime: $startingTime, period:$period)';
  }
}
