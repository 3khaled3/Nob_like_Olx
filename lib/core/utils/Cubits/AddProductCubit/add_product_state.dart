part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}



class Waitting extends  AddProductState{}

class Success extends  AddProductState {}

class Error extends  AddProductState{
  final String errorMessage;

  Error(this.errorMessage);
}
