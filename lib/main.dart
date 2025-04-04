import 'package:e__commerce/Features/NavBar/presentation/Views/MainHomeView.dart';
import 'package:e__commerce/Features/Profile/data/manager/cubit/nav_bar_cubit.dart';
import 'package:e__commerce/Features/auth/presentation/Views/LoginView.dart';
import 'package:e__commerce/Features/auth/presentation/Views/SIgnUpView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBarCubit>(
          create: (context) => NavBarCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainHomeView(),
      ),
    );
  }
}
