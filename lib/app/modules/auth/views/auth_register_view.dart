import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/text_input_field.dart';
import '../controllers/auth_register_controller.dart';

class AuthRegisterView extends GetView<AuthRegisterController> {
  const AuthRegisterView({super.key});
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
                            'Sign up',
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
                          controller: controller.firstNameController,
                          labelText: 'First name',
                          hintText: 'Enter first name...'
                        ),
                        const SizedBox(height: 24),
                        TextInputField(
                          controller: controller.lastNameController,
                          labelText: 'Last name',
                          hintText: 'Enter last name...'
                        ),
                        const SizedBox(height: 24),
                        TextInputField(
                            controller: controller.emailController,
                            labelText: 'Email',
                            hintText: 'Enter Email...'
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
                          onPressed: () => controller.registerPatient(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_box),
                              SizedBox(width: 6,),
                              Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800
                                ),
                              ),
                            ],
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