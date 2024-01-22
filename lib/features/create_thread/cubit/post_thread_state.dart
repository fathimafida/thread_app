part of 'post_thread_cubit.dart';

@immutable
sealed class PostThreadState {}

final class PostThreadInitial extends PostThreadState {}

final class PostThreadLoading extends PostThreadState {}

final class PostThreadSuccess extends PostThreadState {
  final Thread thread;

  PostThreadSuccess(this.thread);
}

final class PostThreadError extends PostThreadState {
  final String message;

  PostThreadError(this.message);
}
