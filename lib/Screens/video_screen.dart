import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawu/Helpers/constants.dart';
import 'package:mawu/Screens/play_screen.dart';

import '../../Helpers/colors.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/entry_screen';
  const VideoScreen({super.key});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 50);
    var heigth = (MediaQuery.of(context).size.height - 50);
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                height: heigth,
                width: width,
                decoration: BoxDecoration(
                    color: light_background, border: Border.all(color: orange)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PlayScreen()));
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: orange,
                          ),
                        ),
                        horizontalSpacer(10),
                        Text("CC",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: orange,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.stop,
                          color: Colors.white,
                        ),
                        horizontalSpacer(10),
                        const Icon(
                          Icons.pause,
                          color: Colors.white,
                        ),
                        horizontalSpacer(10),
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("CC",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.transparent,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        Text("FUNDAMENTALS",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: orange,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                        Text("11:16",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
