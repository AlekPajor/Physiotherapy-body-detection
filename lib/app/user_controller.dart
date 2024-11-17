import 'dart:convert';

import 'package:get/get.dart';
import 'package:physiotherapy_body_detection/app/routes/app_pages.dart';
import '../app/data/models/user.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var user = Rxn<User>();
  var baseUrl = "http://192.168.0.13:8080/api";
  // var baseUrl = "http://192.168.100.39:8080/api";

  bool get isLoggedIn => user.value != null;

  void setUser(User newUser) {
    user.value = newUser;
  }

  void clearUser() {
    user.value = null;
  }

  void logout() {
    clearUser();
    Get.offAllNamed(AppPages.INITIAL);
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final responseUser = User.fromJson(data);
      user.value = responseUser;
    } else {
      print('${response.statusCode}: ${response.body}');
      throw Exception('${response.statusCode}: ${response.body}');
    }
  }

  Future<void> register(
      String email,
      String password,
      String firstName,
      String lastName,
      String role
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role
      }),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      print('${response.statusCode}: ${response.body}');
      throw Exception('${response.statusCode}: ${response.body}');
    }
  }
}
