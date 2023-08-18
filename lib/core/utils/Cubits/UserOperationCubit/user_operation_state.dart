part of 'user_operation_cubit.dart';

@immutable
sealed class UserOperationState {}

final class UserOperationInitial extends UserOperationState {}

class Waitting extends UserOperationState {}

class Success extends UserOperationState {}

class Error extends UserOperationState {
  final String errorMessage;

  Error(this.errorMessage);
}
