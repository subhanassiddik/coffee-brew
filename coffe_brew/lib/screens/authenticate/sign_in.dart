import 'package:coffe_brew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign In Coffee brew'),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: ElevatedButton(
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print('Error sign in');
                } else {
                  print('sign in');
                  print(result.uid);
                }
              },
              child: const Text('Sign In Anonymous'))),
    );
  }
}
