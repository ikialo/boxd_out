import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:taka_box/MainScreen/mainscreen.dart';
import 'package:taka_box/MainScreen/profile.dart';
import 'package:taka_box/MenuScreen/menuscreen.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((value) async {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: data.name, password: data.password);

        return null;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');

          return 'user-not-found';
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          return 'wrong-password';
        }
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'user exists';
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MenuScreen(); //MainView();
        }
        return login(context);
      },
    );
  }

  Widget login(context) {
    return FlutterLogin(
      // title: 'BOXd OUT',
      logo: AssetImage('assets/logo/logo2.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        print('in submision animation');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MenuScreen()),
        );
        // waitForCustomClaims().then((value) {
        //   print("this is: " + value.toString());
        //   if (value != null) {
        //     Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => Container()),
        //     );
        //   } else {
        //     Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (context) => Text("TEST")),
        //     );
        //   }
        // });
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
