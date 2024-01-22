import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/common/utils/helpers.dart';

import 'package:thread_app/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:thread_app/features/home/cubit/cubit/home_cubit.dart';
import 'package:thread_app/common/widgets/thread_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeCubit>().getthreads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthCubit>().state as AuthSuccess).user;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeCubit>().getthreads();
                  },
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back!",
                              style: applyGoogleFontToText(20),
                            ),
                            Text(
                              " ${user.username}",
                              style: applyGoogleFontToText(20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            for (final thread in state.threads)
                              ThreadCard(thread: thread),
                          ])),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
