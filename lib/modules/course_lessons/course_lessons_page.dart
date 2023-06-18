import 'package:flutter/material.dart';

import '../../model/course.dart';
import '../../model/lesson.dart';
import '../video_lessons/video_lessons_offline.dart';

class CourseLessonsPage extends StatelessWidget {
  const CourseLessonsPage({
    super.key,
    required this.course,
  });
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: course.lessons != null
          ? ListView.builder(
              itemCount: course.lessons!.length,
              itemBuilder: (context, index) {
                Lesson lesson = course.lessons![index];

                return ListTile(
                  title: Text(lesson.name),
                  leading: CircleAvatar(
                    backgroundColor:
                        lesson.isCompleted ? Colors.green : Colors.grey,
                    child: Icon(
                      lesson.isCompleted ? Icons.check : Icons.pending,
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
                            value: lesson.currentPosition,
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
                        builder: (context) => VideoLessonsOffline(
                          lesson: lesson,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const SizedBox(),
    );
  }
}
