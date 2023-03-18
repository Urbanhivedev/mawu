import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mawu/Helpers/constants.dart';
import 'package:mawu/Screens/play_screen.dart';
import 'package:video_player/video_player.dart';

import '../../Helpers/colors.dart';

enum MovieName {
  bridgerton,
  brotherhood,
  johnwick,
  nf,
  nowyouseeme,
  rick,
  wednessday,
}

String getMovieName(MovieName type) {
  switch (type) {
    case MovieName.bridgerton:
      return "https://drive.google.com/u/0/uc?id=1QD61BKjQ71VIq0ei4eHwwXpZ2R8DcU4G&export=download#.mp4";
    case MovieName.brotherhood:
      return "https://drive.google.com/u/0/uc?id=1rC5e-NpT7Eh2rTg5cQnfu395P9DjBiNK&export=download#.mp4";
    case MovieName.johnwick:
      return "https://drive.google.com/u/0/uc?id=1_VBD9jLqnjdvQtn_HogbPmCe79EIVNWS&export=download#.mp4";
    case MovieName.nf:
      return "https://drive.google.com/u/0/uc?id=1ixESVrWfVPCMgip2c7CfenFlU1j4cPIe&export=download#.mp4";
    case MovieName.nowyouseeme:
      return "https://drive.google.com/u/0/uc?id=1s7JSovZu5xDSqCc0Hv4B35MscuSnAcaI&export=download#.mp4";
    case MovieName.rick:
      return "https://drive.google.com/u/0/uc?id=1TcSd0AN62rDC-dsSlpmS0aeqbPZGapBE&export=download#.mp4";
    case MovieName.wednessday:
      return "https://drive.google.com/u/0/uc?id=1dNUyxOtRBFYFQpjucSXdC7b-V0ei8CPY&export=download#.mp4";
    default:
      return "assets/icons/icon_dialog.svg";
  }
}

class VideoScreen extends StatefulWidget {
  final String movieUrl;
  static const routeName = '/entry_screen';
  const VideoScreen({super.key, required this.movieUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  //'assets/icons/videoplayback.mp4';
  //"https://drive.google.com/file/d/1FBIJjkgsGu8nsNAUVMnPcHYzmmGUZoP0/view?usp=share_link";
  //https://drive.google.com/u/0/uc?id=1dNUyxOtRBFYFQpjucSXdC7b-V0ei8CPY&export=download#.mp4
  //  "https://drive.google.com/u/0/uc?id=1djHw2eeIoeGKd0EZA1t5YWnw7hEB5FXl&export=download#.mp4";
  // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  //"https://streamable.com/9jmoos";
  // "https://www.sexyloops.com/movies/3pgripvid.mp4";

  //https://drive.google.com/u/0/uc?id=1QD_HjP7fhHApMySxYsUZlRRYiACjbp_g&export=download#.mp4

  //https://drive.google.com/u/0/uc?id=1QD_HjP7fhHApMySxYsUZlRRYiACjbp_g&export=download

  //https://drive.google.com/file/d/1QD_HjP7fhHApMySxYsUZlRRYiACjbp_g/view?usp=sharing
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller = VideoPlayerController.network(widget.movieUrl)
      ..initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
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
                child: Stack(
                  children: [
                    !_controller!.value.isInitialized
                        ? const Center(
                            child: SpinKitCircle(
                              color: Colors.white,
                              size: 50.0,
                            ),
                          )
                        : _controller!.value.isInitialized
                            ? Center(
                                child: VideoPlayer(
                                  _controller!,
                                ),
                              )
                            : const Center(
                                child: SpinKitCircle(
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _controller!.pause();
                                setState(() {
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.portraitUp,
                                    DeviceOrientation.portraitUp,
                                  ]);
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PlayScreen()));
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
                            GestureDetector(
                              onTap: () {
                                //_controller!.dispose();
                              },
                              child: const Icon(
                                Icons.stop,
                                color: Colors.white,
                              ),
                            ),
                            horizontalSpacer(10),
                            GestureDetector(
                              onTap: () {
                                _controller!.value.isPlaying
                                    ? _controller!.pause()
                                    : _controller!.play();
                              },
                              child: Icon(
                                _controller!.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                            horizontalSpacer(10),
                            GestureDetector(
                              onTap: () {
                                _controller!
                                    .seekTo(const Duration(seconds: 10));
                              },
                              child: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                              ),
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
