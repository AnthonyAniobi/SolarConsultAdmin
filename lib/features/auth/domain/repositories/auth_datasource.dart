import 'package:admin/features/auth/data/models/auth_info.dart';

abstract class AuthDatasource {
  Future<void> signup(AuthInfo info);
  Future<void> login(AuthInfo info);
}
