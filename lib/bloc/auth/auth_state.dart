part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final String id; // This could be a UserModel
  final int? status; // This could be a UserModel
  final bool success; // This could be a UserModel
  final String? message; // This could be a UserModel

  AuthSuccess(
      {required this.id, this.status, required this.success, this.message});
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

final class AuthLoading extends AuthState {}
