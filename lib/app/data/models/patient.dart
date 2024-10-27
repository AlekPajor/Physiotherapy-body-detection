import 'activity.dart';

class Patient {
  int? id;
  String firstName;
  String lastName;
  String email;
  String password;
  int? doctorId;
  String role = "PATIENT";
  Activity? currentActivity;

  Patient({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.currentActivity,
    this.doctorId,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        doctorId: json['doctorId'],
        currentActivity: json['currentActivity'] != null
            ? Activity.fromJson(json['currentActivity'])
            : null,
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
    return 'Patient(id: $id, firstName: $firstName, lastName: $lastName, email: $email)';
  }
}
