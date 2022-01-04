import 'package:coffe_brew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String? email;
  String? password;

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
                      validator: (value) =>
                          value!.isEmpty ? 'Enter email addres' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      }),
                  const SizedBox(height: 20),
                  TextFormField(
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print(email);
                          print(password);
                        }
                      },
                      child: const Text('Sign In'))
                ]))));
  }
}
