import 'package:coffe_brew/shared/constant.dart';
import 'package:coffe_brew/shared/loading.dart';

import '/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
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
                    label: const Text('Sign In'))
              ],
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('Register Coffee brew'),
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              textInputStyle.copyWith(hintText: 'Email'),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter email addres' : null,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              textInputStyle.copyWith(hintText: 'password'),
                          validator: (value) => value!.length < 6
                              ? 'Enter more than 6 character'
                              : null,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.pink),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'please supply a valid email';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: const Text('Register')),
                        const SizedBox(height: 20),
                        Text(error, style: const TextStyle(color: Colors.red))
                      ],
                    ))),
          );
  }
}
