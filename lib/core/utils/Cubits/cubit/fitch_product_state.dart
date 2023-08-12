part of 'fitch_product_cubit.dart';


sealed class FitchProductState {}

final class FitchProductInitial extends FitchProductState {}


class Waitting extends  FitchProductState{}

class Success extends  FitchProductState {}

class Error extends  FitchProductState{
  final String errorMessage;

  Error(this.errorMessage);
}
