
import 'package:e__commerce/Features/NavBar/presentation/Views/MainHomeView.dart';
import 'package:e__commerce/Features/auth/data/cubit/AuthCubit/auth_cubit.dart';
import 'package:e__commerce/Features/auth/data/models/UserModel.dart';
import 'package:e__commerce/Features/auth/presentation/Views/ForgetPasswodView.dart';
import 'package:e__commerce/Features/auth/presentation/Views/SignUpView.dart';
import 'package:e__commerce/Features/auth/presentation/widgets/CustomEmailTextFormField.dart';
import 'package:e__commerce/Features/auth/presentation/widgets/CustomPasswordTextFormField.dart';
import 'package:e__commerce/Features/auth/presentation/widgets/SignUpWith.dart';
import 'package:e__commerce/Shared/Functions/ShowMessageFunction.dart';
import 'package:e__commerce/Shared/customButton.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess || state is GoogleSignInSuccess) {
            UserDataModel userDataModel = context.read<AuthCubit>().userDataModel!;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  MainHomeView()));
        }
        if (state is LoginError) {
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
                          "Welcome back !",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
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
                              Row(
                                children: [
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordView())),
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Forget the password?',
                                        style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 70,
                              ),
                               Padding(
                                padding: EdgeInsets.all(15),
                                child: SignUpWith(
                                  onTap: (){
                                    authCubit.googleSignIn();
                                  },
                                  image: 'Assets/images/google.png',
                                  text: 'Login with Google',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                  customButtonText: "Login",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      authCubit.login(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  }),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             SignUpView())),
                                child: const Text(
                                  'Don\'t have account yet?',
                                  style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(height: screenHieght * .1)
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
