import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawu/core/service/video_player/video_player.dart';
import 'package:video_player/video_player.dart';
import '../Helpers/constants.dart';
import '../Helpers/colors.dart';
import 'play_screen.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = '/entry_screen';
  const VideoScreen({super.key});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  AppVideoPlayer appVideoPlayer = AppVideoPlayer();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    appVideoPlayer.init();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
    appVideoPlayer.removeController(appVideoPlayer.index);
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
          child: Stack(
            children: [
              // PageView.builder(
              //   itemCount: _videosUrl.length,
              //   itemBuilder: (context, index) {
              //     return VideoPlayerWidget(
              //       videpPath: _videosUrl.elementAt(index),
              //     );
              //   },
              // ),
              Center(
                child: appVideoPlayer
                        .videoController(appVideoPlayer.index)!
                        .value
                        .isInitialized
                    ? AspectRatio(
                        aspectRatio: appVideoPlayer
                            .videoController(appVideoPlayer.index)!
                            .value
                            .aspectRatio,
                        child: VideoPlayer(appVideoPlayer
                            .videoController(appVideoPlayer.index)!),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlayScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: orange,
                    ),
                  ),
                  horizontalSpacer(10),
                  Text(
                    "CC",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: appVideoPlayer.previousVideo,
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => appVideoPlayer.stopController(appVideoPlayer.index),
                          icon: const Icon(
                            Icons.stop,
                            color: Colors.white,
                          ),
                        ),
                        horizontalSpacer(10),
                        IconButton(
                          onPressed: () =>
                              appVideoPlayer.pauseVideo(appVideoPlayer.index),
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.white,
                          ),
                        ),
                        horizontalSpacer(10),
                        IconButton(
                          onPressed: () =>
                              appVideoPlayer.playVideo(appVideoPlayer.index),
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: appVideoPlayer.nextVideo,
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          child: Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width *
                                appVideoPlayer.buffer,
                            color: kBorderLineColor,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width *
                                appVideoPlayer.position,
                            color: orange,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "CC",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.transparent,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "FUNDAMENTALS",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: orange,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${[
                            appVideoPlayer
                                .videoController(appVideoPlayer.index)!
                                .value
                                .position
                                .inMinutes,
                            appVideoPlayer
                                .videoController(appVideoPlayer.index)!
                                .value
                                .position
                                .inSeconds
                          ].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':')} : ${[
                            appVideoPlayer
                                .videoController(appVideoPlayer.index)!
                                .value
                                .duration
                                .inMinutes,
                            appVideoPlayer
                                .videoController(appVideoPlayer.index)!
                                .value
                                .duration
                                .inSeconds
                          ].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':')}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videpPath,
  });
  final String videpPath;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _videoController = VideoPlayerController.network(widget.videpPath);
    _initializeVideoPlayerFuture = _videoController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Chewie(
            controller: ChewieController(
              videoPlayerController: _videoController,
              looping: false,
              autoInitialize: true,
              errorBuilder: (context, errorMessage) {
                return Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
