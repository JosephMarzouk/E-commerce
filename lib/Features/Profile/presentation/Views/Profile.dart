import 'package:e__commerce/Features/Profile/presentation/Views/EditNameView.dart';
import 'package:e__commerce/Features/Profile/presentation/Views/MyOrdersView.dart';
import 'package:e__commerce/Features/auth/data/cubit/AuthCubit/auth_cubit.dart';
import 'package:e__commerce/Features/auth/data/models/UserModel.dart';
import 'package:e__commerce/Features/auth/presentation/Views/LoginView.dart';
import 'package:e__commerce/Shared/CustomRowButton.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginView()));
        }
      },
      builder: (context, state) {
         AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
         UserDataModel? user = authCubit.userDataModel;
        return state is LoginLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ))
            : Center(
                child: SizedBox(
                  height: screenHight * .65,
                  child: Card(
                    color: AppColors.kWhiteColor,
                    margin: const EdgeInsets.all(24),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding:
                         const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                           Text(
                            user?.name ??"User Name",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                           Text(
                            user?.email ?? "User__E-mail.com",
                            style:const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomRowBtn(
                            icon: Icons.person,
                            text: "Edit Name",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditNameView()));
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomRowBtn(
                            icon: Icons.shopping_basket_outlined,
                            text: "My Orders",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyOrdersView()));
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomRowBtn(
                            icon: Icons.logout,
                            text: "Logout",
                            onTap: () {
                              authCubit.LogOut();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
