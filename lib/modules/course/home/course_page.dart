import 'package:flutter/material.dart';

import '../../../model/course/course.dart';
import '../../../model/student/student.dart';
import '../sections/course_sections_widget.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({
    super.key,
    required this.listObject,
  });

  final List<Object> listObject;

  @override
  Widget build(BuildContext context) {
    final course = listObject[0] as Course;
    final student = listObject[1] as Student;

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: CourseSectionsWidget(
        course: course,
        student: student,
      ),
    );
  }
}
