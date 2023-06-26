import 'package:admin/core/utils/app_config.dart';
import 'package:admin/features/auth/data/models/auth_info.dart';

abstract class AuthRepository {
  AsyncErrorOr<void> login(AuthInfo info);
  AsyncErrorOr<void> signup(AuthInfo info);
}
