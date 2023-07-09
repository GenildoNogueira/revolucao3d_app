import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/extencions/extencions.dart';
import '../../../model/course/sections.dart';
import '../../../model/student/student_course.dart';
import '../../../model/student/student_course_data.dart';
import '../../../model/student/student_lesson.dart';
import '../course_controller.dart';
import '../lessons/course_lessons_widget.dart';
import '../widgets/couser_app_bar.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({
    super.key,
    required this.studentCourseData,
  });

  final StudentCourseData studentCourseData;

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final controller = Modular.get<CourseController>();
  late final PageController _pageController;

  final int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPageIndex,
    )..addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    controller.youtubeController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseAppBar(
        closePage: () => Navigator.pop(context),
        title: widget.studentCourseData.course.name,
        controller: controller,
      ),
      body: StreamBuilder<List<Sections>>(
        stream: controller.setionsStream(widget.studentCourseData.course.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          controller.addSetions(snapshot.data);

          if (controller.setions == null) {
            return const Center(
              child: Text('Nesse curso não tem nenhuma seção'),
            );
          }

          return Column(
            children: [
              Observer(
                builder: (_) {
                  if (controller.youtubeController != null) {
                    return Expanded(
                      child: YoutubePlayer(
                        controller: controller.youtubeController!,
                        showVideoProgressIndicator: true,
                        bottomActions: [
                          CurrentPosition(),
                          ProgressBar(
                            controller: controller.youtubeController,
                            isExpanded: true,
                            colors: const ProgressBarColors(
                              playedColor: Colors.blueAccent,
                              handleColor: Colors.blue,
                              bufferedColor: Colors.white24,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: controller.youtubeController!,
                            builder: (context, youtubeC, child) => Text(
                              youtubeC.metaData.duration.timeVideo,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: controller.youtubeController!,
                            builder: (context, youtubeC, child) => IconButton(
                              icon: Icon(
                                youtubeC.isFullScreen
                                    ? Icons.fullscreen_exit
                                    : Icons.fullscreen,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  controller.toggleFullScreenMode(),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              Observer(
                builder: (_) => Visibility(
                  visible: !controller.isFullScreen,
                  child: Expanded(
                    flex: 2,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.setions!.length,
                      itemBuilder: (context, index) {
                        final section = controller.setions![index];
                        List<StudentLesson>? studentLessons = [];

                        final studentSection = controller.getStudentSection(
                          section,
                          widget.studentCourseData.studentCourses,
                        );

                        if (studentSection != null &&
                            studentSection.lessons != null) {
                          final lessons = studentSection.lessons;
                          if (lessons != null) {
                            for (var lesson in lessons) {
                              studentLessons.add(lesson);
                            }
                          }
                        }

                        StudentCourse? getStudentCoursesByCourseId(
                          String courseId,
                        ) {
                          if (widget.studentCourseData.studentCourses != null) {
                            return widget.studentCourseData.studentCourses!
                                .firstWhereOrNull(
                              (course) => course.id == courseId,
                            );
                          }
                          return null;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 8),
                              child: Text(
                                section.name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            CourseLessonsWidget(
                              student: widget.studentCourseData.student,
                              course: widget.studentCourseData.course,
                              section: section,
                              lessons: section.lessons,
                              studentLessons: studentLessons,
                              studentCourse: getStudentCoursesByCourseId(
                                widget.studentCourseData.course.id,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: Observer(
        builder: (context) => !controller.isFullScreen
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) => Visibility(
                        visible: _pageController.positions.isNotEmpty &&
                            _pageController.page! > 0,
                        child: FilledButton.icon(
                          onPressed: () =>
                              controller.previousPage(_pageController),
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                          label: const Text('Seção anterior'),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () => controller.nextPage(
                        _pageController,
                        widget.studentCourseData.studentCourses,
                      ),
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      label: const Text('Próxima seção'),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
