part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class AuthFailed extends AuthState {
  final String error;

  AuthFailed(this.error);
}
