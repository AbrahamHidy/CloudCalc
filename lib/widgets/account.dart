import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_calc/controllers/userController.dart';
import 'package:cloud_calc/models/calculation.dart';
import 'package:cloud_calc/widgets/signUp.dart';
import 'package:cloud_calc/widgets/login.dart';
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
        child: _hasAccount
            ? Login(
                switchToSignUp: toggleHasAccount,
              )
            : SignUp(
                switchToLogin: toggleHasAccount,
              ),
      ),
    );
  }
}
