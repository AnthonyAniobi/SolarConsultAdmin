part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final AuthInfo? info;

  const AuthState([this.info]);

  @override
  List<Object> get props => info == null ? [] : [info!];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.info);
}

class AuthLoading extends AuthState {
  const AuthLoading(super.info);
}

class AuthError extends AuthState {
  final String errorMessage;
  const AuthError(super.info, this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class AuthSuccess extends AuthState {
  const AuthSuccess(super.info);
}
