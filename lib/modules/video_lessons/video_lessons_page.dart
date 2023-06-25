import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../model/course/lesson.dart';
import 'widget/video_progress_indicator_custom.dart';

class VideoLessonPage extends StatefulWidget {
  const VideoLessonPage({
    super.key,
    required this.lesson,
  });
  final Lesson lesson;

  @override
  State<VideoLessonPage> createState() => _VideoLessonPageState();
}

class _VideoLessonPageState extends State<VideoLessonPage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _animationController;
  final ValueNotifier<bool> _showProgress = ValueNotifier(true);
  bool _isPlaying = false;

  Timer? _progressTimer;

  late Animation<double> _animation;

  void togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying && _controller.value.isPlaying) {
        _animationController.forward();
        _controller.pause();
      } else {
        _animationController.reverse();
        _controller.play();
      }
    });
  }

  void _updatePosition() {
    if (_controller.value.isPlaying && _controller.value.isInitialized) {
      final int duration = _controller.value.duration.inMilliseconds;
      final int position = _controller.value.position.inMilliseconds;

      Timer(const Duration(seconds: 8), () {
        /*setState(() {
          widget.lesson.currentPosition = position / duration;
        });*/
        debugPrint('${position / duration}');
      });
    }
  }

  void _startProgressTimer() {
    _cancelProgressTimer();

    Timer(const Duration(seconds: 6), () {
      //setState(() {
      _showProgress.value = false;
      //});
    });
  }

  void _cancelProgressTimer() {
    _progressTimer?.cancel();
    _progressTimer = null;
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.lesson.videoUrl);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _controller.addListener(() {
      //setState(() {
      _updatePosition();
      //});
    });

    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    _startProgressTimer();
  }

  @override
  Widget build(BuildContext context) {
    print('Building...');

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            title: orientation == Orientation.portrait
                ? Text(widget.lesson.name)
                : null,
          ),
          body: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _showProgress.value = true;
                            _startProgressTimer();
                            /*if (_showProgress) {
                              _controller.pause();
                            }*/
                          },
                          onDoubleTap: togglePlayPause,
                          child: VideoPlayer(_controller),
                        ),
                        AnimatedBuilder(
                          animation: _showProgress,
                          builder: (context, child) {
                            print('building VideoProgressIndicatorCustom...');
                            return VideoProgressIndicatorCustom(
                              _controller,
                              animationController: _animationController,
                              animation: _animation,
                              showProgress: _showProgress.value,
                              togglePlayPause: togglePlayPause,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 10,
                              ),
                              colors: const VideoProgressColors(
                                backgroundColor: Colors.white12,
                                playedColor: Color.fromARGB(255, 194, 182, 169),
                              ),
                              buffered: _controller.value.buffered,
                              videoCurrentPosition:
                                  _controller.value.position.inMilliseconds,
                              videoDuration:
                                  _controller.value.duration.inMilliseconds,
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    _controller.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }
}
