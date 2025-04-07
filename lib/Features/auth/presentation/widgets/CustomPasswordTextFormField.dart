
import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatefulWidget {
   CustomPasswordTextFormField({
    super.key,
    required bool obscureText,
    required this.passwordController,
    required this.emailBorderColor,
    required this.passwordBorderColor,
  }) : _obscureText = obscureText;

   bool _obscureText;
  final TextEditingController passwordController;
  final Color emailBorderColor;
  final Color passwordBorderColor;

  @override
  State<CustomPasswordTextFormField> createState() => _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState extends State<CustomPasswordTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget._obscureText,
      
      validator: (data) {
        if (data!.isEmpty) {
          return 'this field is required';
        }
      },
      controller: widget.passwordController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: widget.emailBorderColor),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 23, horizontal: 15),
        hintText: '********',
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
            onPressed: () {setState(() {
              widget._obscureText = !widget._obscureText;
            });},
            icon: Icon(widget._obscureText
                ? Icons.visibility_off_outlined
                : Icons.remove_red_eye_outlined)),
        label: Text(
          'Enter password',
          style: TextStyle(color: Colors.grey.withOpacity(0.8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: widget.passwordBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: widget.passwordBorderColor),
        ),
      ),
    );
  }
}
