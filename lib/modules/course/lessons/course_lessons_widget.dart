import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../model/course/course.dart';
import '../../../model/course/lesson.dart';
import '../../../model/course/sections.dart';
import '../../../model/student/student.dart';
import '../../../model/student/student_course.dart';
import '../../../model/student/student_lesson.dart';
import '../course_controller.dart';
import '../widgets/lesson_widget.dart';

class CourseLessonsWidget extends StatelessWidget {
  const CourseLessonsWidget({
    super.key,
    required this.student,
    required this.course,
    required this.section,
    required this.lessons,
    required this.studentLessons,
    required this.studentCourse,
  });
  final Student student;
  final Course course;
  final Sections section;
  final List<Lesson>? lessons;
  final List<StudentLesson>? studentLessons;
  final StudentCourse? studentCourse;

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<CourseController>();
    return lessons != null
        ? ListView.builder(
            itemCount: lessons!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final Lesson lesson = lessons![index];
              final StudentLesson? studentLesson =
                  studentLessons != null && index < studentLessons!.length
                      ? studentLessons![index]
                      : null;

              return Observer(
                builder: (context) => LessonWidget(
                  lesson: lesson,
                  isLessonSelected: controller.isLessonSelected == index,
                  studentLesson: studentLesson,
                  onTap: () {
                    if (controller.youtubeController == null) {
                      controller.initializeController(lesson.videoUrl);
                    } else {
                      controller.changeVideo(lesson.videoUrl);
                    }
                    controller.setLessonSelected(index);
                  },
                ),
              );
            },
          )
        : const SizedBox(
            height: 60,
            child: Center(
              child: Text('Não há aulas disponíveis para esta seção.'),
            ),
          );
  }
}
