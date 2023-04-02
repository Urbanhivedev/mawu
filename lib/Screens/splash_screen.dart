import 'package:flutter/material.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(color: black),
        child: Center(child: loader()),
      ),
    );
  }
}
