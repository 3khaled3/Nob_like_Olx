part of 'fav_cubit.dart';

@immutable
sealed class FavState {}

final class FavInitial extends FavState {}


class Waitting extends  FavState{}

class Success extends  FavState {}

class Error extends  FavState{
  final String errorMessage;

  Error(this.errorMessage);
}
