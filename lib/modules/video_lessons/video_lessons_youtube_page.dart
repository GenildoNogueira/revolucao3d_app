import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoLessonsPage extends StatefulWidget {
  const VideoLessonsPage({super.key, required this.lessonName,});
  final String lessonName;

  @override
  State<VideoLessonsPage> createState() => _VideoLessonsPageState();
}

class _VideoLessonsPageState extends State<VideoLessonsPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    const url = 'https://www.youtube.com/watch?v=XNOKsUBk6Sk';

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: orientation == Orientation.portrait
              ? AppBar(
                  title: Text(widget.lessonName),
                )
              : null,
          body: Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                debugPrint('Player is ready.');
              },
            ),
          ),
        );
      },
    );
  }
}
