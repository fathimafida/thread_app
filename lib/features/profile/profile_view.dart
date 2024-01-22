import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thread_app/common/models/thread.dart';
import 'package:thread_app/common/models/user.dart';
import 'package:thread_app/common/utils/helpers.dart';
import 'package:thread_app/common/widgets/thread_card.dart';
import 'package:thread_app/features/auth/auth_screen.dart';
import 'package:thread_app/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:thread_app/features/profile/cubit/profile_cubit.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final User user;

  @override
  void initState() {
    user = (context.read<AuthCubit>().state as AuthSuccess).user;
    context.read<ProfileCubit>().getUserThreads(userId: user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logOut();
              navigateTo(context, AuthScreen());
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(user.image),
              ),
              Text(
                user.username,
                style: applyGoogleFontToText(25),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                user.email,
                style: applyGoogleFontToText(15),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                user.bio,
                style: applyGoogleFontToText(15),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all()),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 40, left: 40),
                      child: Text(
                        "Edit profile",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all()),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 40, left: 40),
                      child: Text(
                        "Share profile",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                if (state is ProfileError) {
                  Fluttertoast.showToast(msg: state.message);
                }
              }, builder: (context, state) {
                if (state is ProfileSuccess) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final thread in state.threads)
                            ThreadCard(thread: thread),
                        ],
                      ),
                    ),
                  );
                }
                if (state is ProfileInitial) {
                  return Text("default state not changed yet");
                }
                return CircularProgressIndicator();
              })
            ],
          ),
        ),
      ),
    );
  }
}
