import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({super.key, required this.controller, required this.labelText, required this.hintText});

  final TextEditingController controller;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(50.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.grey[300],
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange[900]!,
              width: 2,
            ), // Border color when the TextField is not focused
            borderRadius: BorderRadius.circular(50.0),
            gapPadding: 5,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.orange[900]!,
                width: 2
            ), // Border color when the TextField is focused
            borderRadius: BorderRadius.circular(50.0),
            gapPadding: 5,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[600]
          ),
          floatingLabelStyle: TextStyle(
              fontSize: 16,
              color: Colors.orange[900]
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[400]
          ),
        ),
      ),
    );
  }
}