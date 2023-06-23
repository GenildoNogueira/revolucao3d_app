import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:revolucao3d_app/model/student/student.dart';

import '../../core/repository/course_repository.dart';
import '../../model/course.dart';
import '../../model/lesson.dart';
import '../video_lessons/video_lessons_page.dart';

class CourseLessonsPage extends StatelessWidget {
  const CourseLessonsPage({
    super.key,
    required this.data,
  });
  final List<Object> data;

  @override
  Widget build(BuildContext context) {
    final courseRepository = Modular.get<CourseRepository>();
    final course = data[0] as Course;
    final student = data[1] as Student;

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: StreamBuilder<List<Lesson>>(
        stream: courseRepository.getLessons(course.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          final lessons = snapshot.data;
          return lessons != null
              ? ListView.builder(
                  itemCount: lessons.length,
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
                                value: student.coursesInProgress[0]
                                        .lessons?[index].currentPosition ??
                                    0.0,
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
              : const Center(
                  child: Text('Não tem aulas disponiveis'),
                );
        },
      ),
    );
  }
}
