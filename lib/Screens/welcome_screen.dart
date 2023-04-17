import 'package:flutter/material.dart';
import 'package:mawu/Screens/entry_screen.dart';
import 'package:mawu/Screens/register_screen.dart';
import '../Helpers/colors.dart';
import '../Helpers/constants.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/entry_screen';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(),
            const Image(
                image: AssetImage(
              'assets/icons/mawu_logo.png',
            )),
            // SvgPicture.asset(
            //   'assets/icons/mawu_logo.svg',
            //   fit: BoxFit.cover,
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                              onPressed: () async {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                              child: const Text("Create Account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ),
                  ),
                  verticalSpacer(30),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                              onPressed: () async {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EntryScreen()));
                              },
                              child: Text("SIGN IN",
                                  style: TextStyle(
                                      color: orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
