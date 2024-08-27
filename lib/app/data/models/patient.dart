class Patient {
  String firstName;
  String lastName;
  String email;

  Patient({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  // Factory constructor for creating a new Patient instance from a map.
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  // Method to convert Patient instance to a map.
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'Patient(firstName: $firstName, lastName: $lastName, email: $email)';
  }
}
