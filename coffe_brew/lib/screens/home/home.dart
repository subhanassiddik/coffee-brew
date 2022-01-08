import 'package:coffe_brew/models/brew.dart';
import 'package:coffe_brew/screens/home/brewlist.dart';
import 'package:coffe_brew/services/auth.dart';
import 'package:coffe_brew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
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
        body: const BrewList(),
      ),
    );
  }
}
