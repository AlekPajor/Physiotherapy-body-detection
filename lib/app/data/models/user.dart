import 'activity.dart';

class User {
  int? id;
  String firstName;
  String lastName;
  String email;
  String password;
  int? doctorId;
  String? role;
  Activity? currentActivity;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.currentActivity,
    this.doctorId,
    this.role
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      doctorId: json['doctorId'],
      role: json['role'],
      currentActivity: json['currentActivity']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email)';
  }
}
