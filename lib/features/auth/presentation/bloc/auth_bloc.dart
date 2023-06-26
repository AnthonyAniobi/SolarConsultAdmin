import 'package:admin/features/auth/data/models/auth_info.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo;
  AuthBloc(this.repo) : super(const AuthInitial(null)) {
    on<LoginEvent>(_loginEvent);
    on<SignupEvent>(_signupEvent);
  }

  void _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {}
  void _signupEvent(SignupEvent event, Emitter<AuthState> emit) async {}
}
