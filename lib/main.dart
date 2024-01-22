import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/common/cubit/main_cubit.dart';
import 'package:thread_app/common/views/splash_screen.dart';

import 'package:thread_app/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:thread_app/features/create_thread/cubit/post_thread_cubit.dart';
import 'package:thread_app/features/home/cubit/cubit/home_cubit.dart';
import 'package:thread_app/features/profile/cubit/profile_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => PostThreadCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
