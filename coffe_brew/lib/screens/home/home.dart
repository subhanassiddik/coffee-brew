import 'package:coffe_brew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Coffee Brew'),
        actions: [
          IconButton(
              onPressed: () async {
                await _auth.logOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
    );
  }
}
