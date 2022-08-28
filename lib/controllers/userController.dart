import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  UserController._privateConstructor() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  static final UserController _instance = UserController._privateConstructor();

  factory UserController() {
    return _instance;
  }
}
