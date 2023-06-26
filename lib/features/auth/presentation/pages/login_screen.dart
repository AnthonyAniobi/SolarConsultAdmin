// import 'package:admin/features/auth/presentation/pages/signup_screen.dart';
import 'package:admin/features/auth/data/models/auth_info.dart';
import 'package:admin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:admin/features/home/presentation/pages/home_screen.dart';
import 'package:email_validator/email_validator.dart';

// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AuthInfo? info = context.read<AuthBloc>().state.info;
    emailController = TextEditingController(text: info?.email);
    passwordController = TextEditingController(text: info?.password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            errorDialog(context, state.errorMessage);
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      label: const Text("Email"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                    ),
                    validator: (email) =>
                        email != null && EmailValidator.validate(email)
                            ? null
                            : "enter a valid email",
                  ),
                  SizedBox(height: 4.h),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                    ),
                    validator: (password) =>
                        password != null && password.length <= 8
                            ? "Password must be greater than 8 characters"
                            : null,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await _login(context);
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: RichText(
                  //     text: TextSpan(
                  //       text: "Dont have an account? ",
                  //       style: Theme.of(context).textTheme.bodyMedium,
                  //       children: [
                  //         TextSpan(
                  //           text: "Signup",
                  //           recognizer: TapGestureRecognizer()
                  //             ..onTap = () {
                  //               Navigator.pushReplacement(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (context) => SignupScreen()));
                  //             },
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodyMedium!
                  //               .copyWith(color: Colors.green),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _login(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      final info = AuthInfo(emailController.text, passwordController.text);
      context.read<AuthBloc>().add(LoginEvent(info));
    }
  }

  void errorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Error 🛑"),
              content: Text(message),
            ));
  }
}
