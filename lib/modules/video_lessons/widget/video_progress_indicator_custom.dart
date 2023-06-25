import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:revolucao3d_app/core/extencions/extencions.dart';
import 'package:video_player/video_player.dart';

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
    required this.buffered,
    required this.videoCurrentPosition,
    required this.videoDuration,
  });

  final VideoPlayerController controller;
  final VideoProgressColors colors;
  final EdgeInsets padding;
  final bool showProgress;
  final VoidCallback? togglePlayPause;
  final AnimationController animationController;
  final Animation<double> animation;
  final List<DurationRange> buffered;
  final int videoCurrentPosition;
  final int videoDuration;

  @override
  Widget build(BuildContext context) {
    print('Building progress indicator...');
    const borderRadius = BorderRadius.all(
      Radius.circular(16),
    );

    int maxBuffering = 0;
    for (final DurationRange range in buffered) {
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
                color: Color.fromARGB(123, 100, 90, 81),
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
                      controller.value.position.timeVideo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: <Widget>[
                            SizedBox(
                              height: 7,
                              child: LinearProgressIndicator(
                                value: maxBuffering / videoDuration,
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
                                  value: videoCurrentPosition / videoDuration,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    colors.playedColor,
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      controller.value.duration.timeVideo,
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
        : SizedBox(
            height: 7,
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                LinearProgressIndicator(
                  value: maxBuffering / videoDuration,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colors.bufferedColor,
                  ),
                  backgroundColor: colors.backgroundColor,
                ),
                VideoScrubber(
                  controller: controller,
                  child: LinearProgressIndicator(
                    value: videoCurrentPosition / videoDuration,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colors.playedColor,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          );
  }
}
