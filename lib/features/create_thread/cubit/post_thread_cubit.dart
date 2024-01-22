import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thread_app/common/utils/api.client.dart';
import 'package:thread_app/common/models/thread.dart';

part 'post_thread_state.dart';

class PostThreadCubit extends Cubit<PostThreadState> {
  PostThreadCubit() : super(PostThreadInitial());

  void postThread({
    required String content,
    required XFile? image,
  }) async {
    emit(PostThreadLoading());
    try {
      final formdata = FormData.fromMap({
        "content": content,
        if (image != null)
          "image":
              await MultipartFile.fromFile(image.path, filename: image.name),
      });
      final resp = await dioClient.post('/threads/', data: formdata);
      emit(PostThreadSuccess(Thread.fromJson(resp.data)));
    } on DioException catch (e) {
      print("error messge ${e.response?.data}");
      emit(PostThreadError(e.toString()));
    } catch (e) {
      print(e);
      emit(PostThreadError(e.toString()));
    }
  }
}
