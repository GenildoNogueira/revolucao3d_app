import 'package:flutter/foundation.dart';

import '../course/course.dart';
import 'student.dart';
import 'student_course.dart';

class StudentCourseData {
  final Course course;
  final Student student;
  final List<StudentCourse>? studentCourses;

  StudentCourseData({
    required this.course,
    required this.student,
    required this.studentCourses,
  });

  @override
  bool operator ==(covariant StudentCourseData other) {
    if (identical(this, other)) return true;

    return other.course == course &&
        other.student == student &&
        listEquals(other.studentCourses, studentCourses);
  }

  @override
  int get hashCode =>
      course.hashCode ^ student.hashCode ^ studentCourses.hashCode;

  @override
  String toString() =>
      'StudentCourseData(course: $course, student: $student, studentCourses: $studentCourses)';
}
