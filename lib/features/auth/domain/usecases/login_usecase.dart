import 'package:admin/core/domain/repositories/usecase.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:admin/features/auth/data/models/auth_info.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase extends Usecase {
  final AuthRepository repo;
  final AuthInfo info;

  LoginUsecase(this.repo, this.info);
  @override
  AsyncErrorOr<void> call() => repo.login(info);
}
