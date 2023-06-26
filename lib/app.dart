import 'package:admin/features/bookings/presentation/bloc/bookings_bloc.dart';
import 'package:admin/features/home/presentation/bloc/home_bloc.dart';
import 'package:admin/features/home/presentation/pages/home_screen.dart';
import 'package:admin/features/login/presentation/bloc/login_bloc.dart';
import 'package:admin/features/questions/presentation/bloc/questions_bloc.dart';
import 'package:admin/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider(
        //   create: (context) => SubjectRepository(),
        // ),
        // RepositoryProvider(
        //   create: (context) => SubjectRepository(),
        // ),
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
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => SignupBloc(),
          ),
          BlocProvider(
            create: (context) => BookingsBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Solarconsult admin',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
