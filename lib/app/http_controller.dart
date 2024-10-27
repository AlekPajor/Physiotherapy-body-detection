import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:physiotherapy_body_detection/app/data/models/exercise.dart';
import 'package:physiotherapy_body_detection/app/data/models/patient.dart';
import 'package:physiotherapy_body_detection/app/data/models/report.dart';

class HttpController extends GetxController {
  var baseUrl = "http://192.168.0.13:8080/api";

  Future<List<Report>> fetchReportsByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/report/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Report.fromJson(json)).toList();

    } else {
      throw Exception('${response.statusCode}: ${response.body}');
    }
  }

  Future<List<Patient>> fetchPatientsByDoctorId(int doctorId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/patients/$doctorId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Patient.fromJson(json)).toList();

    } else {
      throw Exception('${response.statusCode}: ${response.body}');
    }
  }

  Future<void> assignPatientToDoctor(String patientEmail, int doctorId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/assign'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'patientEmail': patientEmail, 'doctorId': doctorId}),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('${response.statusCode}: ${response.body}');
    }
  }

  Future<Patient> fetchPatientDetails(int patientId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/details/$patientId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Patient.fromJson(data);
    } else {
      throw Exception('${response.statusCode}: ${response.body}');
    }
  }

  Future<List<Exercise>> fetchAllExercises() async {
    final response = await http.get(
      Uri.parse('$baseUrl/exercise'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('${response.statusCode}: ${response.body}');
    }
  }

  Future<void> assignNewExercise(
      int patientId,
      int exerciseId,
      String duration,
      String startingTime,
      String period
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/activity/assign'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'patientId': patientId,
        'exerciseId': exerciseId,
        'duration': duration,
        'startingTime': startingTime,
        'period': period
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('${response.statusCode}: ${response.body}');
    }
  }

}