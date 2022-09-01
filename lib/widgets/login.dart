import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_calc/models/calculation.dart';
import 'package:cloud_calc/widgets/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  final Function switchToSignUp;

  Login({Key? key, required this.switchToSignUp}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Login"),
        const SizedBox(height: 30),
        Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email"),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintText: "Your email",
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !value.contains("@") ||
                      !value.contains(".")) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              const Text("Password"),
              TextFormField(
                controller: passwordController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintText: "Your password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 3, 46, 132),
          ),
          onPressed: () {
            // Validate returns true if the form is valid, or false otherwise.
            if (_loginFormKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
          },
          child: const Text('Login'),
        ),
        const SizedBox(height: 60),
        Row(
          children: [
            const Text("Need an account?"),
            const SizedBox(width: 15),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () => widget.switchToSignUp(),
              child: const Text("Sign up"),
            )
          ],
        ),
      ],
    );
  }
}