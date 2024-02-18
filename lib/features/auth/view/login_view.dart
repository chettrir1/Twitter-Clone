import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/UiConstants.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiConstants.appBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              /*textfield 1*/
              AuthField(
                controller: emailController,
                hintText: "Email address",
              ),
              const SizedBox(height: 25),
              /*textfield 2*/
              AuthField(
                controller: passwordController,
                hintText: "Password",
              )
            ]),
          ),
        ),
      ),
    );
  }
}
