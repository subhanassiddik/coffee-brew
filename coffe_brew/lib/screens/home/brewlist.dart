// import 'package:coffe_brew/shared/loading.dart';
import 'package:coffe_brew/models/brew.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  // bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ?? [];

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) => BrewTile(brew: brews[index]));

    // final brews = Provider.of<List<Brew>?>(context);
    // if (brews == null) {
    //   _loading = true;
    // } else {
    //   _loading = false;
    // }
    // return _loading
    //     ? Loading(color: Colors.brown.shade100)
    //     : ListView.builder(
    //         itemCount: brews.length,
    //         itemBuilder: (context, index) => BrewTile(brew: brews[index]));
  }
}
