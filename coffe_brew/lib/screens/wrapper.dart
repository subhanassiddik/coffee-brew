import 'package:coffe_brew/models/user_data.dart';
import 'package:coffe_brew/screens/authenticate/authenticate.dart';
import 'package:coffe_brew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData? user = Provider.of<UserData?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
