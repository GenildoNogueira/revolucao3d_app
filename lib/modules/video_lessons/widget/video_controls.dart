import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControls extends StatelessWidget {
  const VideoControls({
    super.key,
    required this.colors,
    required this.togglePlayPause,
    required this.animation,
    required this.animationController,
    required this.timeVideo,
    required this.videoDuration,
  });

  final VideoProgressColors colors;
  final VoidCallback? togglePlayPause;
  final Animation<double> animation;
  final AnimationController animationController;
  final String timeVideo;
  final String videoDuration;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          timeVideo,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 5),
        /*Expanded(
          child: ,
          
        ),*/
        const SizedBox(width: 5),
        Text(
          videoDuration,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
