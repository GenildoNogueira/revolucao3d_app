import 'package:flutter/material.dart';

import '../../../core/repository/course_repository.dart';
import '../../../core/repository/student_repository.dart';
import '../../../model/course/course.dart';
import '../../../model/course/lesson.dart';
import '../../../model/course/sections.dart';
import '../../../model/student/student.dart';
import '../../video_lessons/video_lessons_page.dart';

class CourseLessonsWidget extends StatelessWidget {
  const CourseLessonsWidget({
    super.key,
    required this.course,
    required this.sections,
    required this.student,
    required this.courseRepository,
    required this.studentRepository,
  });
  final Course course;
  final Sections sections;
  final Student student;
  final CourseRepository courseRepository;
  final StudentRepository studentRepository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Lesson>>(
      future: studentRepository.getLissonsProgress(
        student.id,
        course.id,
        sections.id,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 60,
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        final lessons = snapshot.data;
        return lessons != null
            ? ListView.builder(
                itemCount: lessons.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Lesson lesson = lessons[index];

                  return ListTile(
                    title: Text(lesson.name),
                    leading: CircleAvatar(
                      backgroundColor:
                          lesson.isCompleted != null && lesson.isCompleted!
                              ? Colors.green
                              : Colors.grey,
                      child: Icon(
                        lesson.isCompleted != null && lesson.isCompleted!
                            ? Icons.check
                            : Icons.pending,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Conteúdo: ${lesson.description}'),
                        Text('Duração: ${lesson.duration} minutos'),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 6,
                            child: LinearProgressIndicator(
                              value: lesson.currentPosition?.toDouble() ?? 0.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoLessonPage(
                            lesson: lesson,
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : const SizedBox(
                height: 60,
                child: Center(
                  child: Text('Não tem aulas disponiveis'),
                ),
              );
      },
    );
  }
}
