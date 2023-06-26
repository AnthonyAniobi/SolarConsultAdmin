import 'package:admin/core/data/datasources/booking_datasource.dart';
import 'package:admin/core/data/repositories/booking_repository.dart';
import 'package:admin/core/domain/repositories/booking_datasource.dart';
import 'package:admin/core/domain/repositories/booking_repository.dart';
import 'package:admin/core/presentation/bloc/bookings/bookings_bloc.dart';
import 'package:admin/features/auth/data/datasources/auth_datasource.dart';
import 'package:admin/features/auth/data/repositories/auth_repository.dart';
import 'package:admin/features/auth/domain/repositories/auth_datasource.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:admin/features/auth/presentation/pages/login_screen.dart';
import 'package:admin/features/home/presentation/bloc/home_bloc.dart';
import 'package:admin/features/home/presentation/pages/home_screen.dart';
import 'package:admin/features/questions/presentation/bloc/questions_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiRepositoryProvider(
        providers: [
          //datasources
          RepositoryProvider<AuthDatasource>(
            create: (context) => AuthDatasourceImpl(),
          ),
          RepositoryProvider<BookingDatasource>(
            create: (context) => BookingDatasourceImpl(),
          ),

          // repositories
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepositoryImpl(context.read()),
          ),
          RepositoryProvider<BookingRepository>(
            create: (context) => BookingRepositoryImpl(context.read()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => QuestionsBloc(),
            ),
            BlocProvider(
              create: (context) => HomeBloc(),
            ),
            BlocProvider(
              create: (context) => AuthBloc(context.read()),
            ),
            BlocProvider(
              create: (context) => BookingsBloc(context.read()),
            ),
          ],
          child: MaterialApp(
            title: 'Solarconsult admin',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: FirebaseAuth.instance.currentUser != null
                ? const HomeScreen()
                : const LoginScreen(),
          ),
        ),
      );
    });
  }
}
