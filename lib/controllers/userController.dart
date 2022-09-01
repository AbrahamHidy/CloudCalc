import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  Stream<User?> authState = FirebaseAuth.instance.authStateChanges();

  UserController._privateConstructor() {
    authState.listen((User? user) {
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
