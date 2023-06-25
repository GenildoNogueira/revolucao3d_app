import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/repository/course_repository.dart';
import '../../../core/repository/student_repository.dart';
import '../../../model/course/course.dart';
import '../../../model/course/sections.dart';
import '../../../model/student/student.dart';
import '../lessons/course_lessons_widget.dart';

class CourseSectionsWidget extends StatelessWidget {
  final Course course;
  final Student student;

  const CourseSectionsWidget({
    super.key,
    required this.course,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final courseRepository = Modular.get<CourseRepository>();
    final studentRepository = Modular.get<StudentRepository>();

    return FutureBuilder<List<Sections>>(
      future: courseRepository.getListSections(course.id),
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
        //bool isCurrentSectionCompleted = sections[currentSectionIndex].areAllLessonsCompleted();
        final courseSections = snapshot.data;
        return courseSections != null
            ? ListView.builder(
                itemCount: courseSections.length,
                itemBuilder: (context, index) {
                  Sections section = courseSections[index];

                  return ExpansionTile(
                    title: Text(section.name),
                    leading: const Icon(Icons.pending),
                    children: [
                      CourseLessonsWidget(
                        course: course,
                        sections: section,
                        student: student,
                        courseRepository: courseRepository,
                        studentRepository: studentRepository,
                      ),
                    ],
                  );
                },
              )
            : const Center(
                child: Text('Não tem nenhuma seção'),
              );
      },
    );
  }
}
