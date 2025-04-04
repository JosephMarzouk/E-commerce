
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSearchbar extends StatelessWidget {
  const CustomSearchbar({
    super.key,   this.onPressed,
  });
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        
        decoration: InputDecoration(
         labelText: "Search in the Market",
        // suffixIcon: ElevatedButton.icon(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: AppColors.kPrimaryColor,
        //     foregroundColor: AppColors.kWhiteColor,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //   ),
        //   onPressed: onPressed,
        //   label: const Icon(
        //     (Icons.search),
        //   ),
        // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.6)),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.kPrimaryColor),
          ),
          prefixIcon: const Icon(Icons.search),
          
          labelStyle: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.4)),
        ),
      ),
    );
  }
}
