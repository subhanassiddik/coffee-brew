import 'package:coffe_brew/services/auth.dart';
import 'package:coffe_brew/shared/constant.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          actions: [
            TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.white, // foreground
                ),
                onPressed: () {
                  widget.toggleView();
                },
                icon: const Icon(Icons.app_registration),
                label: const Text('Register'))
          ],
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Sign In Coffee brew'),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 20),
                  TextFormField(
                      decoration: textInputStyle.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter email addres' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
                      decoration: textInputStyle.copyWith(hintText: 'password'),
                      validator: (value) => value!.length < 6
                          ? 'Enter more than 6 character'
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      }),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.pink),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          print(result);
                          if (result == null) {
                            setState(() {
                              error = 'cannot sign in with user credential';
                            });
                          }
                        }
                      },
                      child: const Text('Sign In')),
                  const SizedBox(height: 20),
                  Text(error, style: const TextStyle(color: Colors.red))
                ]))));
  }
}
