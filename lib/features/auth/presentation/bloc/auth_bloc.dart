import 'package:admin/features/auth/data/datasources/login_cache_datasource.dart';
import 'package:admin/features/auth/data/models/auth_info.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/features/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo;
  AuthBloc(this.repo) : super(AuthInitial()) {
    on<LoginEvent>(_loginEvent);
    on<SignupEvent>(_signupEvent);
  }

  void _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading(state.info));
    final result = await LoginUsecase(repo, event.info).call();
    result.fold((left) => emit(AuthError(state.info, left.message)),
        (right) => emit(AuthSuccess(state.info)));
  }

  void _signupEvent(SignupEvent event, Emitter<AuthState> emit) async {}
}
