import 'package:e__commerce/Features/Home/data/cubit/ProductDataCubit/product_data_cubit.dart';
import 'package:e__commerce/Features/NavBar/data/manager/cubit/nav_bar_cubit.dart';
import 'package:e__commerce/Features/auth/data/cubit/AuthCubit/auth_cubit.dart';
import 'package:e__commerce/Features/NavBar/presentation/Views/MainHomeView.dart';
import 'package:e__commerce/core/demo_data.dart';
import 'package:e__commerce/core/Observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://gwhcryhwcxuafijsofqt.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3aGNyeWh3Y3h1YWZpanNvZnF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk3MDQ5MTksImV4cCI6MjA5NTI4MDkxOX0.xKzLhxNVynQDKee0kQOZYDJSC0lgoxGEUYFW_FC3BtY",
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBarCubit>(
          create: (context) => NavBarCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) {
            final cubit = AuthCubit();
            if (kDemoMode) {
              cubit.seedDemoGuest();
            } else {
              cubit.restoreSession();
            }
            return cubit;
          },
        ),
        if (!kDemoMode)
          BlocProvider<ProductDataCubit>(
            create: (context) => ProductDataCubit(),
          ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainHomeView(),
      ),
    );
  }
}

// import 'package:e__commerce/Features/Home/data/cubit/ProductDataCubit/product_data_cubit.dart';
// import 'package:e__commerce/Features/NavBar/data/manager/cubit/nav_bar_cubit.dart';
// import 'package:e__commerce/Features/NavBar/presentation/Views/MainHomeView.dart';
// import 'package:e__commerce/Features/auth/data/cubit/AuthCubit/auth_cubit.dart';
// import 'package:e__commerce/Features/auth/presentation/Views/LoginView.dart';
// import 'package:e__commerce/core/Observer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: "https://gwhcryhwcxuafijsofqt.supabase.co",
//     anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
//   );
//   Bloc.observer = MyObserver();
  
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider<NavBarCubit>(create: (_) => NavBarCubit()),
//         BlocProvider<AuthCubit>(create: (_) => AuthCubit()..getUserData()),
//         BlocProvider<ProductDataCubit>(create: (_) => ProductDataCubit()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final client = Supabase.instance.client;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: client.auth.currentUser != null
//           ? MainHomeView(user: context.read<AuthCubit>().userDataModel!)
//           : LoginView(),
//     );
//   }
// }