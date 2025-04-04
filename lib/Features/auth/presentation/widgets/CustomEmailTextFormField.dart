
import 'package:flutter/material.dart';

class CustomEmailTextFormField extends StatelessWidget {
  const CustomEmailTextFormField({
    super.key,
    required this.emailController,
    required this.emailBorderColor,
  });

  final TextEditingController emailController;
  final Color emailBorderColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
      // ignore: duplicate_ignore
      // ignore: body_might_complete_normally_nullable
      validator: (data) {
        if (data!.isEmpty) {
          return 'this field is required';
        } else if (!data.contains('@')) {
          return ' wrong format';
        }
      },
      controller: emailController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: emailBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: emailBorderColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 23, horizontal: 15),
        hintText: 'E-mail@any.com',
        prefixIcon: const Icon(Icons.email_rounded),
        label: Text(
          'E-mail@any.com',
          style: TextStyle(color: Colors.grey.withOpacity(0.8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: emailBorderColor),
        ),
      ),
    );
  }
}
