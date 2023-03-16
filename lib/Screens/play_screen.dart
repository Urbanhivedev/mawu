import 'package:flutter/material.dart';
import '../Helpers/constants.dart';
import '../Helpers/colors.dart';

import '../Screens/video_screen.dart';
class PlayScreen extends StatefulWidget {
  static const routeName = '/entry_screen';
  const PlayScreen({super.key});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 70);
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: AutofillGroup(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                      ),
                      Column(
                        children: [
                          verticalSpacer(20),
                          const Text("Welcome To",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500)),
                          Text("MAWU",
                              style: TextStyle(
                                  color: orange,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: light_background,
                            border: Border.all(color: orange)),
                      )
                    ],
                  ),
                  verticalSpacer(20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VideoScreen()));
                    },
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                          color: light_background,
                          border: Border.all(color: orange)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("VIRTUAL",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      Text("Fundamentals",
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      Text("RESUME",
                          style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  verticalSpacer(20),
                  Row(
                    children: [
                      Text("Featured Film",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: orange,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  verticalSpacer(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VideoScreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: width / 2,
                              decoration: BoxDecoration(
                                  color: light_background,
                                  border: Border.all(color: orange)),
                            ),
                            verticalSpacer(5),
                            Text("Latnem Pilot",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            verticalSpacer(3),
                            Text("Jan 2018 Action",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      // horizontalSpacer(20),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VideoScreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: width / 2,
                              decoration: BoxDecoration(
                                  color: light_background,
                                  border: Border.all(color: orange)),
                            ),
                            verticalSpacer(5),
                            Text("A Close Shave",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            verticalSpacer(3),
                            Text("Jan 2018 Action",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      )
                    ],
                  ),
                  verticalSpacer(25),
                  Row(
                    children: [
                      Text("All Movies",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: orange,
                              fontSize: 19,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  verticalSpacer(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VideoScreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: width / 3,
                              decoration: BoxDecoration(
                                  color: light_background,
                                  border: Border.all(color: orange)),
                            ),
                            verticalSpacer(5),
                            Text("Grudge",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            verticalSpacer(3),
                            Text("Jan 2018.",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      // horizontalSpacer(20),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VideoScreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: width / 3,
                              decoration: BoxDecoration(
                                  color: light_background,
                                  border: Border.all(color: orange)),
                            ),
                            verticalSpacer(5),
                            Text("Shaver",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            verticalSpacer(3),
                            Text("Jan 2018.",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VideoScreen()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: width / 3,
                              decoration: BoxDecoration(
                                  color: light_background,
                                  border: Border.all(color: orange)),
                            ),
                            verticalSpacer(5),
                            Text("Shaver",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            verticalSpacer(3),
                            Text("Jan 2018.",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
