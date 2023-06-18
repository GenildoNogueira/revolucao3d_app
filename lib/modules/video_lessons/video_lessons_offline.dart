import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:revolucao3d_app/model/lesson.dart';
import 'package:video_player/video_player.dart';

class VideoLessonsOffline extends StatefulWidget {
  const VideoLessonsOffline({
    super.key,
    required this.lesson,
  });
  final Lesson lesson;

  @override
  State<VideoLessonsOffline> createState() => _VideoLessonsOfflineState();
}

class _VideoLessonsOfflineState extends State<VideoLessonsOffline>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _animationController;
  bool _showProgress = true;
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

      Timer(const Duration(seconds: 5), () {
        setState(() {
          widget.lesson.currentPosition = position / duration;
        });
        debugPrint('${position / duration}');
      });
    }
  }

  void _startProgressTimer() {
    _cancelProgressTimer();

    Timer(const Duration(seconds: 4), () {
      setState(() {
        _showProgress = false;
      });
    });
  }

  void _cancelProgressTimer() {
    _progressTimer?.cancel();
    _progressTimer = null;
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/video.mp4');

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _controller.addListener(() {
      setState(() {
        _updatePosition();
      });
    });

    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    _startProgressTimer();
  }

  @override
  Widget build(BuildContext context) {
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
                          onTap: () => setState(() {
                            _showProgress = true;
                            _startProgressTimer();
                            /*if (_showProgress) {
                              _controller.pause();
                            }*/
                          }),
                          onDoubleTap: togglePlayPause,
                          child: VideoPlayer(_controller),
                        ),
                        VideoProgressIndicatorCustom(
                          _controller,
                          animationController: _animationController,
                          animation: _animation,
                          showProgress: _showProgress,
                          togglePlayPause: togglePlayPause,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10,
                          ),
                          colors: const VideoProgressColors(
                            backgroundColor: Colors.white12,
                            playedColor: Color.fromARGB(255, 194, 182, 169),
                          ),
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

class VideoProgressIndicatorCustom extends StatelessWidget {
  const VideoProgressIndicatorCustom(
    this.controller, {
    super.key,
    required this.showProgress,
    this.togglePlayPause,
    required this.animationController,
    required this.animation,
    this.colors = const VideoProgressColors(),
    this.padding = const EdgeInsets.only(top: 5.0),
  });

  final VideoPlayerController controller;
  final VideoProgressColors colors;
  final EdgeInsets padding;
  final bool showProgress;
  final VoidCallback? togglePlayPause;
  final AnimationController animationController;
  final Animation<double> animation;

  String timeVideo(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(
      Radius.circular(16),
    );

    final int duration = controller.value.duration.inMilliseconds;
    final int position = controller.value.position.inMilliseconds;

    int maxBuffering = 0;
    for (final DurationRange range in controller.value.buffered) {
      final int end = range.end.inMilliseconds;
      if (end > maxBuffering) {
        maxBuffering = end;
      }
    }

    return showProgress
        ? Padding(
            padding: padding,
            child: Container(
              height: 50,
              alignment: Alignment.bottomCenter,
              margin: padding,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: Color.fromARGB(144, 100, 90, 81),
                borderRadius: borderRadius,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous),
                    ),
                    IconButton(
                      onPressed: togglePlayPause,
                      padding: const EdgeInsets.all(0),
                      color: Colors.white,
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: animation,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      timeVideo(controller.value.position),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: borderRadius,
                            child: SizedBox(
                              height: 7,
                              child: LinearProgressIndicator(
                                value: maxBuffering / duration,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colors.bufferedColor,
                                ),
                                backgroundColor: colors.backgroundColor,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: borderRadius,
                            child: SizedBox(
                              height: 7,
                              child: VideoScrubber(
                                controller: controller,
                                child: LinearProgressIndicator(
                                  value: position / duration,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    colors.playedColor,
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      timeVideo(controller.value.duration),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          )
        : Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              SizedBox(
                height: 7,
                child: LinearProgressIndicator(
                  value: maxBuffering / duration,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colors.bufferedColor,
                  ),
                  backgroundColor: colors.backgroundColor,
                ),
              ),
              SizedBox(
                height: 7,
                child: VideoScrubber(
                  controller: controller,
                  child: LinearProgressIndicator(
                    value: position / duration,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colors.playedColor,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          );
  }
}
