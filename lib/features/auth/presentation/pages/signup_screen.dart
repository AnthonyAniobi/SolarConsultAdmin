import 'package:admin/features/auth/presentation/pages/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignupScreen({Key? key}) : super(key: key);

  Future _signup(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: firstPasswordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Signup",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                SizedBox(height: 2.5.w),
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
                  controller: firstPasswordController,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length <= 8
                          ? "password must be more than 8 characters"
                          : null,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: InkWell(
                        onTap: () async {
                          await _signup(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3, 3),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.5),
                                blurRadius: 3,
                              )
                            ],
                          ),
                          child: Center(
                              child: Text(
                            "Signup",
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RichText(
                    text: TextSpan(
                        text: 'Already have an account?   ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Login",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
