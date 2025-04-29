import 'package:e__commerce/Features/Home/data/cubit/ProductDataCubit/product_data_cubit.dart';
import 'package:e__commerce/Features/NavBar/presentation/Views/MainHomeView.dart';
import 'package:e__commerce/Features/NavBar/data/manager/cubit/nav_bar_cubit.dart';
import 'package:e__commerce/Features/auth/data/cubit/AuthCubit/auth_cubit.dart';
import 'package:e__commerce/Features/auth/presentation/Views/LoginView.dart';
import 'package:e__commerce/core/Observer.dart';
import 'package:e__commerce/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://asbxvyaxvraxpevngyjy.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFzYnh2eWF4dnJheHBldm5neWp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM4NjMzMDQsImV4cCI6MjA1OTQzOTMwNH0.Z4LXgVoUqucTJ_Ggu-VYeNcB7HVveGIYoA1cPMRI1jE",
  );
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  @override
  Widget build(BuildContext context) {
    SupabaseClient client = Supabase.instance.client;
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBarCubit>(
          create: (context) => NavBarCubit(),
        ),
         BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..getUserData(),
        ),
        BlocProvider<ProductDataCubit>(
          create: (context) => ProductDataCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: client.auth.currentUser !=null ? MainHomeView(
          user: context.read<AuthCubit>().userDataModel!,
        ): LoginView(),
      ),
    );
  }
}
