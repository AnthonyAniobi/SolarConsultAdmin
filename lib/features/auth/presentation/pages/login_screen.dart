import 'package:admin/features/auth/presentation/pages/signup_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future _login(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus(); // remove keyboard

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      //print failed
      print(e);
    }
  }

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                validator: (email) =>
                    email != null && EmailValidator.validate(email)
                        ? null
                        : "enter a valid email",
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) =>
                    password != null && password.length <= 8
                        ? "password"
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: TextSpan(
                    text: "Dont have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: "Signup",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
