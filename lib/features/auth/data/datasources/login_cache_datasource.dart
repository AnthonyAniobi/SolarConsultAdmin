import 'package:admin/features/auth/data/models/auth_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCacheDatasource {
  static const _emailInfoKey = "EMAIL_INFORMATION";
  static const _passwordInfoKey = "PASSWORD_INFORMATION";

  static SharedPreferences? _themePrefs;

  static Future<void> init() async {
    _themePrefs = await SharedPreferences.getInstance();
  }

  static Future<void> setLoginCache(AuthInfo info) async {
    await _themePrefs!.setString(_emailInfoKey, info.email);
    await _themePrefs!.setString(_passwordInfoKey, info.password);
  }

  static AuthInfo getLoginCache() {
    final email = _themePrefs!.getString(_emailInfoKey) ?? "";
    final password = _themePrefs!.getString(_passwordInfoKey) ?? "";
    return AuthInfo(email, password);
  }
}
