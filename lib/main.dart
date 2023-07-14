import 'package:admin/app.dart';
import 'package:admin/core/utils/app_config.dart';
import 'package:admin/features/auth/data/datasources/login_cache_datasource.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set default orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // dot env
  await dotenv.load(fileName: ".env");
  // set app to test mode
  AppConfig.isTestMode = dotenv.env['TEST_MODE'] == "true";

  await LoginCacheDatasource.init();

  // initialize firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}
