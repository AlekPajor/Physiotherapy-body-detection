class Patient {
  String id;
  String firstName;
  String lastName;
  String email;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
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
