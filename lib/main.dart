import 'package:e__commerce/Features/Home/presentation/Views/ProductDetails.dart';
import 'package:e__commerce/Features/NavBar/presentation/Views/MainHomeView.dart';
import 'package:e__commerce/Features/NavBar/data/manager/cubit/nav_bar_cubit.dart';
import 'package:e__commerce/Features/auth/data/cubit/AuthCubit/auth_cubit.dart';
import 'package:e__commerce/Features/auth/presentation/Views/LoginView.dart';
import 'package:e__commerce/Features/auth/presentation/Views/SIgnUpView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://asbxvyaxvraxpevngyjy.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFzYnh2eWF4dnJheHBldm5neWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM4NjMzMDQsImV4cCI6MjA1OTQzOTMwNH0.Z4LXgVoUqucTJ_Ggu-VYeNcB7HVveGIYoA1cPMRI1jE",
  );
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
         BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}
