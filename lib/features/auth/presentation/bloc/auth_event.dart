part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final AuthInfo info;

  const LoginEvent(this.info);

  @override
  List<Object> get props => [info];
}

class SignupEvent extends AuthEvent {
  final AuthInfo info;

  const SignupEvent(this.info);

  @override
  List<Object> get props => [info];
}
