import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_calc/models/calculation.dart';
import 'package:cloud_calc/widgets/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  final Function switchToLogin;
  SignUp({Key? key, required this.switchToLogin}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void createNewUser() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
        const Text("Sign up!"),
        const SizedBox(height: 30),
        Form(
          key: _signUpFormKey,
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
                  hintText: "Your new password",
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
            if (_signUpFormKey.currentState!.validate()) {
              createNewUser();
            }
          },
          child: const Text('Sign up'),
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
              onPressed: () => widget.switchToLogin(),
              child: const Text("Log in"),
            )
          ],
        ),
      ],
    );
  }
}
