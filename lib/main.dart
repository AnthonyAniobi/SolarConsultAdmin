import 'package:admin/app.dart';
import 'package:admin/features/auth/data/datasources/login_cache_datasource.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set default orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await LoginCacheDatasource.init();

  // initialize firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}
