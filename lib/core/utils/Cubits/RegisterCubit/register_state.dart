part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class Waitting extends  RegisterState{}

class Success extends  RegisterState {}

class Error extends  RegisterState{
  final String errorMessage;

  Error(this.errorMessage);
}
