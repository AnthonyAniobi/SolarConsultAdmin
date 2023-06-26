import 'package:admin/app.dart';
import 'package:admin/features/auth/data/datasources/login_cache_datasource.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LoginCacheDatasource.init();

  // initialize firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}
