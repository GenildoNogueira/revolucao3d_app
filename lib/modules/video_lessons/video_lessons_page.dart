import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player/video_player.dart';

import '../../core/repository/student_repository.dart';
import '../../model/course/course.dart';
import '../../model/course/lesson.dart';
import '../../model/student/student.dart';
import '../../model/student/student_course.dart';
import '../../model/student/student_lesson.dart';
import 'widget/video_progress_indicator_custom.dart';

class VideoLessonPage extends StatefulWidget {
  const VideoLessonPage({
    super.key,
    required this.course,
    required this.lesson,
    required this.student,
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
  State<VideoLessonPage> createState() => _VideoLessonPageState();
}

class _VideoLessonPageState extends State<VideoLessonPage>
    with SingleTickerProviderStateMixin {
  final studentRepository = Modular.get<StudentRepository>();
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
    final lesson = widget.studentLesson;

    if (lesson?.isCompleted ?? true) {
      final int duration = _controller.value.duration.inMilliseconds;
      final int position = _controller.value.position.inMilliseconds;
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
            print('Erro na hora de atualizar o progresso ${e.toString()}');
            throw e.toString();
          }
        });
      }
    }
  }

  void _startProgressTimer() {
    _cancelProgressTimer();

    Timer(const Duration(seconds: 6), () {
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

    _controller.initialize().then((_) {
      if (widget.studentLesson != null) {
        if (widget.studentLesson!.currentPosition != null) {
          final int duration = _controller.value.duration.inMilliseconds;
          final int position =
              (duration * widget.studentLesson!.currentPosition!).round();
          _controller.seekTo(Duration(milliseconds: position));
        }
      }
    });
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
                          onTap: () {
                            setState(() {
                              _showProgress = true;
                              _startProgressTimer();
                            });
                          },
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
                          buffered: _controller.value.buffered,
                          videoCurrentPosition:
                              _controller.value.position.inMilliseconds,
                          videoDuration:
                              _controller.value.duration.inMilliseconds,
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
    _progressTimer?.cancel();
    super.dispose();
  }
}
