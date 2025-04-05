import 'package:e__commerce/Shared/CustomRowButton.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        height: screenHight * .65,
        child: const Card(
          color: AppColors.kWhiteColor,
          margin: const EdgeInsets.all(24),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.kPrimaryColor,
                  foregroundColor: AppColors.kWhiteColor,
                  child: Icon(
                    Icons.person,
                    size: 45,
                  ),
                ),
                const Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "User__E-mail.com",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomRowBtn(icon: Icons.person, text: "Edit Name"),
                const SizedBox(
                  height: 10,
                ),
                CustomRowBtn(
                    icon: Icons.shopping_basket_outlined, text: "My Orders"),
                const SizedBox(
                  height: 10,
                ),
                CustomRowBtn(icon: Icons.logout, text: "Logout"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
