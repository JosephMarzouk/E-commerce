import 'package:e__commerce/Features/NavBar/presentation/Views/MainHomeView.dart';
import 'package:e__commerce/Features/auth/data/cubit/AuthCubit/auth_cubit.dart';
import 'package:e__commerce/Features/auth/presentation/Views/LoginView.dart';
import 'package:e__commerce/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

/// Decides between login and home only after the session + profile are resolved.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final session = Supabase.instance.client.auth.currentUser;
        final profile = context.read<AuthCubit>().userDataModel;

        if (session == null) {
          return LoginView();
        }

        if (state is GetUserDataLoading || state is AuthInitial) {
          return const Scaffold(
            backgroundColor: AppColors.kScaffoldColor,
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
            ),
          );
        }

        if (profile != null) {
          return MainHomeView();
        }

        return LoginView();
      },
    );
  }
}
