import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: const Center(
        child: SpinKitWave(
          color: Colors.pink,
          size: 50.0,
        ),
      ),
    );
  }
}
