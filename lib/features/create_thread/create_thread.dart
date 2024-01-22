import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thread_app/common/cubit/main_cubit.dart';
import 'package:thread_app/common/utils/helpers.dart';
import 'package:thread_app/common/views/main_screen.dart';

import 'package:thread_app/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:thread_app/features/create_thread/cubit/post_thread_cubit.dart';
import 'package:thread_app/features/home/cubit/cubit/home_cubit.dart';
import 'package:thread_app/features/home/views/home_view.dart';

class CreateThread extends StatefulWidget {
  const CreateThread({super.key});

  @override
  State<CreateThread> createState() => _CreateThreadState();
}

class _CreateThreadState extends State<CreateThread> {
  XFile? _selectedImage;
  final _postController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _postImage() async {
    final imagepicker = ImagePicker();
    final pickImage = await imagepicker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = pickImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final user = (context.read<AuthCubit>().state as AuthSuccess).user;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "New Post",
            style: applyGoogleFontToText(25).copyWith(color: Colors.black),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: _selectedImage != null
                          ? DecorationImage(
                              image:
                                  Image.file(File(_selectedImage!.path)).image,
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: TextButton.icon(
                      onPressed: _postImage,
                      label: Text("Post Your Thread"),
                      icon: Icon(Icons.image),
                    )),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _postController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your thoughts";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Type your thoughts here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                BlocConsumer<PostThreadCubit, PostThreadState>(
                  listener: (context, state) {
                    if (state is PostThreadSuccess) {
                      context.read<HomeCubit>().getthreads();
                      Fluttertoast.showToast(
                        msg: "post Added Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      context.read<MainCubit>().changeIndex(0);
                      // navigateTo(context, HomeView());
                    }

                    if (state is PostThreadError) {
                      Fluttertoast.showToast(
                        msg: state.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is PostThreadLoading) {
                      return CircularProgressIndicator();
                    }
                    return OutlinedButton(
                      onPressed: () {
                        if (_postController.text.isEmpty) {
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          context.read<PostThreadCubit>().postThread(
                                content: _postController.text,
                                image: _selectedImage,
                              );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Text("Post",
                            style: applyGoogleFontToText(20)
                                .copyWith(color: Colors.black)),
                      ),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.black),
                          shape: StadiumBorder(),
                          backgroundColor: Colors.indigoAccent),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
