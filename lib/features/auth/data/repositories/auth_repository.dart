import 'package:admin/core/data/models/app_error.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:admin/features/auth/data/datasources/login_cache_datasource.dart';
import 'package:admin/features/auth/data/models/auth_info.dart';
import 'package:admin/features/auth/domain/repositories/auth_datasource.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);
  @override
  AsyncErrorOr<void> login(AuthInfo info) async {
    try {
      await LoginCacheDatasource.setLoginCache(info);
      await datasource.login(info);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  AsyncErrorOr<void> signup(AuthInfo info) async {
    try {
      await datasource.signup(info);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(e.message ?? ""));
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}
