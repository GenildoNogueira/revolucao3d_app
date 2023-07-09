import 'package:flutter/foundation.dart';

import 'student_lesson.dart';

class StudentSections {
  final String? id;
  final List<StudentLesson>? lessons;

  StudentSections({
    this.id,
    this.lessons,
  });

  StudentSections copyWith({
    String? id,
    num? progress,
    List<StudentLesson>? lessons,
  }) {
    return StudentSections(
      id: id ?? this.id,
      lessons: lessons ?? this.lessons,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lessons': lessons?.map((lesson) => lesson.toMap()).toList(),
    };
  }

  factory StudentSections.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw Exception('There is no student course data');
    }
    return StudentSections(
      id: map['id'] ?? '',
      lessons: (map['lessons'] as List<dynamic>?)
          ?.map((lesson) => StudentLesson.fromMap(lesson))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'StudentCourse(id: $id, lessons: $lessons)';
  }

  @override
  bool operator ==(covariant StudentSections other) {
    if (identical(this, other)) return true;

    return other.id == id && listEquals(other.lessons, lessons);
  }

  @override
  int get hashCode {
    return id.hashCode ^ lessons.hashCode;
  }
}
