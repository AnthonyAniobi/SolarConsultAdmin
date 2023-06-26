// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  AuthInfo? info;

  AuthState([this.info]);

  @override
  List<Object> get props => info == null ? [] : [info!];
}

class AuthInitial extends AuthState {
  AuthInitial() {
    info = LoginCacheDatasource.getLoginCache();
  }
}

class AuthLoading extends AuthState {
  AuthLoading(super.info);
}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError(super.info, this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class AuthSuccess extends AuthState {
  AuthSuccess(super.info);
}
