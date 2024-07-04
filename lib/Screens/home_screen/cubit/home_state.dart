part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeBottomNavBar extends HomeState {}

class ChangeMode extends HomeState {}

class ChangeLanguage extends HomeState {}



class Logout extends HomeState {}

class LogoutError extends HomeState {
  final String error;

  LogoutError(this.error);
}
