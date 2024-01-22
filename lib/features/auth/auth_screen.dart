import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/common/utils/helpers.dart';
import 'package:thread_app/common/views/main_screen.dart';
import 'package:thread_app/features/auth/cubit/cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final _emailController = TextEditingController(text: "20mcs24@meaec.edu.in");
  final _passwordController = TextEditingController(text: "1234");
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    labelText: "username,email or mobile number",
                    border: OutlineInputBorder(),
                  )),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  )),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Successful")));
                    navigateTo(context, MainScreen());
                  }
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().loginUser(
                                username: _emailController.text,
                                password: _passwordController.text,
                              );
                        }
                      },
                      child: Text("Login"));
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
