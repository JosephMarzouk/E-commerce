import 'package:e__commerce/Features/Profile/presentation/widgets/CustomTextField.dart';
import 'package:e__commerce/Shared/CustomSmallButton.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Edit Name',style: TextStyle(color: AppColors.kWhiteColor),),
            backgroundColor: AppColors.kPrimaryColor,
          ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const CustomTextFormField(
                labelText: "Enter Name",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomEBtn(text: "Update", onTap: () {}),
          ],
        ),
       
      ),
    );
  }
}
