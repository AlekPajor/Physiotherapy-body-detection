import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:physiotherapy_body_detection/app/components/text_input_field.dart';

import '../controllers/auth_login_controller.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 8,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 40, 12, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Welcome back!',
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900]
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextInputField(
                          controller: controller.emailController,
                          labelText: 'Email',
                          hintText: 'Enter email...'
                        ),
                        const SizedBox(height: 24),
                        TextInputField(
                            controller: controller.passwordController,
                            labelText: 'Password',
                            hintText: 'Enter password...'
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.orange[900]),
                            foregroundColor: WidgetStatePropertyAll(Colors.grey[200]),
                            elevation: const WidgetStatePropertyAll(4)
                          ),
                          onPressed: () => controller.login(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.login_rounded),
                              SizedBox(width: 6,),
                              Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[900]
                              ),
                              children: [
                                TextSpan(
                                  text: 'Register',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orange[900],
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed('/register');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    )
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
