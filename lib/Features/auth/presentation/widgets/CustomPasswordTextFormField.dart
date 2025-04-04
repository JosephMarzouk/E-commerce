
import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatelessWidget {
  const CustomPasswordTextFormField({
    super.key,
    required bool obscureText,
    required this.passwordController,
    required this.emailBorderColor,
    required this.passwordBorderColor,
  }) : _obscureText = obscureText;

  final bool _obscureText;
  final TextEditingController passwordController;
  final Color emailBorderColor;
  final Color passwordBorderColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      onChanged: (value) {
        // BlocProvider.of<LoginCubit>(context).updatePassword(value);
      },
      validator: (data) {
        if (data!.isEmpty) {
          return 'this field is required';
        }
      },
      controller: passwordController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: emailBorderColor),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 23, horizontal: 15),
        hintText: '********',
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(_obscureText
                ? Icons.visibility_off_outlined
                : Icons.remove_red_eye_outlined)),
        label: Text(
          'Enter password',
          style: TextStyle(color: Colors.grey.withOpacity(0.8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: passwordBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: passwordBorderColor),
        ),
      ),
    );
  }
}
