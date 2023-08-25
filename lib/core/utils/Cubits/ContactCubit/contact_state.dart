part of 'contact_cubit.dart';

@immutable
sealed class ContactState {}

final class ContactInitial extends ContactState {}

class Waitting extends ContactState {}

class Success extends ContactState {}

class Error extends ContactState {
  final String errorMessage;

  Error(this.errorMessage);
}