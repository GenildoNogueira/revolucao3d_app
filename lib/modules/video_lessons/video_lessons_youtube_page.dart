import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/extencions/extencions.dart';
import '../../core/repository/student_repository.dart';
import '../../model/course/course.dart';
import '../../model/course/lesson.dart';
import '../../model/student/student.dart';
import '../../model/student/student_course.dart';
import '../../model/student/student_lesson.dart';

class VideoLessonYoutubePage extends StatefulWidget {
  const VideoLessonYoutubePage({
    super.key,
    required this.student,
    required this.course,
    required this.lesson,
    required this.studentLesson,
    required this.studentCourse,
    required this.sectionId,
    required this.lessonId,
  });

  final Student student;
  final Course course;
  final Lesson lesson;
  final StudentLesson? studentLesson;
  final StudentCourse? studentCourse;
  final String sectionId;
  final String lessonId;

  @override
  State<VideoLessonYoutubePage> createState() => _VideoLessonYoutubePageState();
}

class _VideoLessonYoutubePageState extends State<VideoLessonYoutubePage> {
  final studentRepository = Modular.get<StudentRepository>();
  late YoutubePlayerController _youtubeController;
  Duration _currentPosition = Duration.zero;

  void _updatePosition() {
    final lesson = widget.studentLesson;

    if (lesson?.isCompleted ?? true) {
      final int duration =
          _youtubeController.value.metaData.duration.inMilliseconds;
      final int position = _youtubeController.value.position.inMilliseconds;
      final double progress = position / duration;

      if (progress < 1.0) {
        final updatedLesson = lesson?.copyWith(
          id: widget.sectionId,
          isCompleted: true,
          currentPosition: position.toDouble(),
        );

        Future.delayed(const Duration(seconds: 6), () async {
          try {
            await studentRepository.updateStudentCourse(
              studentId: widget.student.id,
              courseId: widget.course.id,
              sectionId: widget.sectionId,
              lessonId: widget.lessonId,
              studentLesson: updatedLesson,
              studentCourse: widget.studentCourse,
              progress: progress,
            );
          } catch (e) {
            print('Error updating progress: ${e.toString()}');
            throw e.toString();
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _youtubeController = YoutubePlayerController(
      initialVideoId: 'k_no5GauziU',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    )..addListener(_onYoutubePlayerControllerChange);

    final lesson = widget.studentLesson;
    print('Lesson: $lesson');
    if (lesson?.currentPosition != null) {
      final int duration =
          _youtubeController.value.metaData.duration.inMilliseconds;
      final int position = (duration * lesson!.currentPosition!).round();
      _currentPosition = Duration(milliseconds: position);
      print('CurrentPosition $_currentPosition');
      setState(() {
        _youtubeController.seekTo(_currentPosition);
      });
    }

    _youtubeController.play();
  }

  void _onYoutubePlayerControllerChange() {
    if (_youtubeController.value.isFullScreen) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    if (_youtubeController.value.playerState == PlayerState.ended) {
      /*final double progress = _youtubeController.value.position.inMilliseconds /
          _youtubeController.metadata.duration.inMilliseconds;*/
      //widget.onProgressUpdated(progress);
      _updatePosition();
    }
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
          body: Padding(
            padding: orientation == Orientation.portrait
                ? const EdgeInsets.only(top: 100.0)
                : EdgeInsets.zero,
            child: YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  controller: _youtubeController,
                  isExpanded: true,
                  colors: const ProgressBarColors(
                    playedColor: Colors.blueAccent,
                    handleColor: Colors.blue,
                    bufferedColor: Colors.white24,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _youtubeController,
                  builder: (context, controller, child) => Text(
                    controller.metaData.duration.timeVideo,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FullScreenButton()
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _updatePosition();
    super.dispose();
  }
}
