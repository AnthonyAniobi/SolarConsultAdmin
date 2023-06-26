import 'package:admin/features/auth/data/models/auth_info.dart';
import 'package:admin/features/auth/domain/repositories/auth_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<void> login(AuthInfo info) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: info.email,
      password: info.password,
    );
  }

  @override
  Future<void> signup(AuthInfo info) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: info.email,
      password: info.password,
    );
  }
}
