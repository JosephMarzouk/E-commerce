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


final class LogOutSuccess extends AuthState {}

final class LogOutLoading extends AuthState {}

final class LogOutError extends AuthState {
  final String message;

  LogOutError(this.message);
}


final class PasswordResetLoading extends AuthState {}

final class PasswordResetSuccess extends AuthState {}

final class PasswordResetError extends AuthState {}

final class UserDataAddedLoading extends AuthState {}

final class UserDataAddedSuccess extends AuthState {}

final class UserDataAddedError extends AuthState {}

final class GetUserDataLoading extends AuthState {}

final class GetUserDataSuccess extends AuthState {}

final class GetUserDataError extends AuthState {}

final class GoogleSignInSuccess extends AuthState {}

final class GoogleSignInLoading extends AuthState {}

final class GoogleSignInError extends AuthState {}
