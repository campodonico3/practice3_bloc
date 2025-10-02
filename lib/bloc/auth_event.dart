part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRrequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRrequested({
    required this.email, 
    required this.password,
  });
}
