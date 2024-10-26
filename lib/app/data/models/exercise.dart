import 'snapshot.dart';

class Exercise {
  int? id;
  String name;
  List<Snapshot> snapshots;

  Exercise({
    this.id,
    required this.name,
    required this.snapshots,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    var snapshotList = json['snapshots'] as List;
    List<Snapshot> snapshots = snapshotList.map((snapshot) => Snapshot.fromJson(snapshot)).toList();

    return Exercise(
      id: json['id'],
      name: json['name'],
      snapshots: snapshots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'snapshots': snapshots.map((snapshot) => snapshot.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, snapshots: $snapshots)';
  }
}
