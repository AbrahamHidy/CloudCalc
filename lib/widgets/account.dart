import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_calc/controllers/userController.dart';
import 'package:cloud_calc/models/calculation.dart';
import 'package:cloud_calc/widgets/signUp.dart';
import 'package:cloud_calc/widgets/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool _hasAccount = true;

  UserController userController = UserController();
  User? currentUser;

  _AccountState() {
    userController.authState.listen((User? user) {
      setState(() {
        currentUser = user;
        _hasAccount = true;
      });
    });
  }

  void toggleHasAccount() {
    setState(() {
      _hasAccount = !_hasAccount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: currentUser != null
            ? Column(
                children: [
                  Text(currentUser!.email!),
                  ElevatedButton(
                    onPressed: () {
                      userController.logoutUser();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 3, 46, 132),
                    ),
                    child: Text("Logout"),
                  ),
                ],
              )
            : (_hasAccount
                ? Login(
                    switchToSignUp: toggleHasAccount,
                  )
                : SignUp(
                    switchToLogin: toggleHasAccount,
                  )),
      ),
    );
  }
}
