import 'dart:ui';

import 'package:video_player/video_player.dart';

import '../../../Screens/video_screen.dart';

class AppVideoPlayer {
  int index = 0;
  double position = 0;
  double buffer = 0;
  bool _lock = true;
  final Map<String, VideoPlayerController> _controllers = {};
  final Map<int, VoidCallback> _listeners = {};

  final Set<String> _videosUrl = {
    getMovieName(MovieName.bridgerton),
    getMovieName(MovieName.nf),
    getMovieName(MovieName.brotherhood),
    getMovieName(MovieName.johnwick),
    getMovieName(MovieName.wednessday),
    getMovieName(MovieName.rick),
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
    'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
  };

  VoidCallback _listenerSpawner(index) {
    return () {
      int dur = videoController(index)!.value.duration.inMilliseconds;
      int pos = videoController(index)!.value.position.inMilliseconds;
      int buf = videoController(index)!.value.buffered.last.end.inMilliseconds;

      // setState(() {
      if (dur <= pos) {
        position = 0;
        return;
      }
      position = pos / dur;
      buffer = buf / dur;
      // });
      if (dur - pos < 1) {
        if (index < _videosUrl.length - 1) {
          nextVideo();
        }
      }
    };
  }

  VideoPlayerController? videoController(int index) {
    return _controllers[_videosUrl.elementAt(index)];
  }

  Future<void> initController(int index) async {
    var controller = VideoPlayerController.network(_videosUrl.elementAt(index));
    _controllers[_videosUrl.elementAt(index)] = controller;
    await controller.initialize();
  }

  init() {
    if (_videosUrl.isNotEmpty) {
      initController(0).then((_) {
        playController(0);
      });
    }

    if (_videosUrl.length > 1) {
      initController(1).whenComplete(() => _lock = false);
    }
  }

  void removeController(int index) {
    videoController(index)!.dispose();
    _controllers.remove(_videosUrl.elementAt(index));
    _listeners.remove(index);
  }

  void stopController(int index) {
    videoController(index)!.removeListener(_listeners[index]!);
    videoController(index)!.pause();
    videoController(index)!.seekTo(const Duration(milliseconds: 0));
  }

  void playController(int index) async {
    if (!_listeners.keys.contains(index)) {
      _listeners[index] = _listenerSpawner(index);
    }
    videoController(index)!.addListener(_listeners[index]!);
    await videoController(index)!.play();
    // setState(() {});
  }

  void previousVideo() {
    if (_lock || index == 0) {
      return;
    }
    _lock = true;

    stopController(index);

    if (index + 1 < _videosUrl.length) {
      removeController(index + 1);
    }

    playController(--index);

    if (index == 0) {
      _lock = false;
    } else {
      initController(index - 1).whenComplete(() => _lock = false);
    }
  }

  void nextVideo() async {
    if (_lock || index == _videosUrl.length - 1) {
      return;
    }
    _lock = true;

    stopController(index);

    if (index - 1 >= 0) {
      removeController(index - 1);
    }

    playController(++index);

    if (index == _videosUrl.length - 1) {
      _lock = false;
    } else {
      initController(index + 1).whenComplete(() => _lock = false);
    }
  }

  void pauseVideo(int index) async {
    //pause
    if (videoController(index)!.value.isPlaying) {
      videoController(index)!.pause();
    }
    // setState(() {});
  }

  void playVideo(int index) async {
    //play
    if (!videoController(index)!.value.isPlaying) {
      videoController(index)!.play();
    }
    // setState(() {});
  }
}
