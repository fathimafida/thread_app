import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thread_app/common/utils/helpers.dart';
import 'package:thread_app/common/views/main_screen.dart';
import 'package:thread_app/features/auth/auth_screen.dart';
import 'package:thread_app/features/auth/cubit/cubit/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthCubit>().loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          navigateTo(context, const MainScreen());
        }
        if (state is AuthInitial) {
          navigateTo(context, AuthScreen());
        }
      },
      builder: (context, state) {
        // Fluttertoast.showToast(msg: (state as AuthInitial).toString());
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
