import 'package:admin/core/utils/app_config.dart';

abstract class AuthRepository {
  AsyncErrorOr<void> login();
  AsyncErrorOr<void> signup();
}
