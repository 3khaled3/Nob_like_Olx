part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class Waitting extends ChatState {}

class Success extends ChatState {}

class Error extends ChatState {
  final String errorMessage;

  Error(this.errorMessage);
}
