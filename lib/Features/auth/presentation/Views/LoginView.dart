import 'package:e__commerce/Features/auth/presentation/widgets/CustomEmailTextFormField.dart';
import 'package:e__commerce/Features/auth/presentation/widgets/CustomPasswordTextFormField.dart';
import 'package:e__commerce/Features/auth/presentation/widgets/SignUpWith.dart';
import 'package:e__commerce/Shared/customButton.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Color emailBorderColor = Colors.grey;
  Color passwordBorderColor = Colors.grey;
  String emailErrorMessage = '';
  String passwordErrorMessage = '';
  bool _obscureText = true;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final double screenHieght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Welcome back !",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                shadowColor: AppColors.kPrimaryColor,
                color: AppColors.kWhiteColor,
                margin: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                height: 40,
              ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: CustomEmailTextFormField(emailController: emailController, emailBorderColor: emailBorderColor),
                    ),
                    const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: CustomPasswordTextFormField(obscureText: _obscureText, passwordController: passwordController, emailBorderColor: emailBorderColor, passwordBorderColor: passwordBorderColor),
              ),
             const SizedBox(height: 5,),
              Row(children: [const Spacer(),GestureDetector(child:
              const Padding(
                 padding:  EdgeInsets.only(right: 10),
                 child: Text('Forget the password?',style: TextStyle(color: AppColors.kPrimaryColor,fontWeight: FontWeight.w500),),
               ),)],),
              const SizedBox(
                height: 70,
              ),
             const Padding(
                padding:  EdgeInsets.all(15),
                child:  SignUpWith(
                  image: 'Assets/images/google.png',
                  text: 'Login with Google',
                ),
              ),
            const SizedBox(height: 20,),
                CustomButton(
                  customButtonText: "Login", onPressed: (){}),
                  const SizedBox(height: 8,),
                  GestureDetector(child:
              const Text('Don\'t have account yet?',style: TextStyle(color: AppColors.kPrimaryColor,fontSize: 16,fontWeight: FontWeight.w500),),),
              SizedBox(height : screenHieght *.1)
                  ],
                ),
              ),
              
             
            ],
          ),
        ),
      ),
    );
  }
}
 