part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

final class SignUpSuccess extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpError extends AuthState {
  final String message;

  SignUpError(this.message);
}
