import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

  
class CustomButton extends StatelessWidget {
  const CustomButton({required this.customButtonText, required this.onPressed});
  final String customButtonText;

  
 final void Function()?onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          child:  Center(
              child: Text(
            customButtonText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
          width: 310,
          height: 51,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(72), color: AppColors.kPrimaryColor)),
        );
    
  }
}
