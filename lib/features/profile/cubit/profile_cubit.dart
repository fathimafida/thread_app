import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thread_app/common/utils/api.client.dart';
import 'package:thread_app/common/models/thread.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getUserThreads({required int userId}) async {
    emit(ProfileLoading());
    try {
      final resp = await dioClient.get("/threads/?user=$userId");
      final List<Thread> threadList = [];
      for (final thread in resp.data) {
        threadList.add(Thread.fromJson(thread));
      }
      emit(ProfileSuccess(threadList.reversed.toList()));
    } catch (e) {
      print(e);
      emit(ProfileError(e.toString()));
    }
  }
}
