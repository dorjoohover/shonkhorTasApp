part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String phone;
  final String password;

  AuthLoginRequested({
    required this.phone,
    required this.password,
  });
}

final class AuthLogoutRequested extends AuthEvent {}
