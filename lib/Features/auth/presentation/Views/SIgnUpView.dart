import 'package:e__commerce/Features/NavBar/presentation/Views/MainHomeView.dart';
import 'package:e__commerce/Features/Profile/presentation/widgets/CustomTextField.dart';
import 'package:e__commerce/Features/auth/presentation/widgets/CustomEmailTextFormField.dart';
import 'package:e__commerce/Features/auth/presentation/widgets/CustomPasswordTextFormField.dart';
import 'package:e__commerce/Features/auth/presentation/widgets/SignUpWith.dart';
import 'package:e__commerce/Shared/Functions/ShowMessageFunction.dart';
import 'package:e__commerce/Shared/customButton.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cubit/AuthCubit/auth_cubit.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  Color emailBorderColor = Colors.grey;

  Color passwordBorderColor = Colors.grey;

  String emailErrorMessage = '';

  String passwordErrorMessage = '';

  bool _obscureText = true;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double screenHieght = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess || state is GoogleSignInSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainHomeView()));
        }
        if (state is SignUpError) {
          showMsg(context, state.message);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Scaffold(
          body: state is LoginLoading || state is GoogleSignInLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ))
              : Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Text(
                          "Welcome To Our Market !",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
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
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: CustomTextFormField(
                                  controller: userNameController,
                                  labelText: "User Name",
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: CustomEmailTextFormField(
                                    emailController: emailController,
                                    emailBorderColor: emailBorderColor),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: CustomPasswordTextFormField(
                                    obscureText: _obscureText,
                                    passwordController: passwordController,
                                    emailBorderColor: emailBorderColor,
                                    passwordBorderColor: passwordBorderColor),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: SignUpWith(
                                  onTap: () {
                                    authCubit.googleSignIn();
                                  },
                                  image: 'Assets/images/google.png',
                                  text: 'SignUp with Google',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                customButtonText: "SignUp",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authCubit.SignUp(
                                        UserName: userNameController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                child: const Text(
                                  'Already have account ?',
                                  style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(height: screenHieght * .05)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
