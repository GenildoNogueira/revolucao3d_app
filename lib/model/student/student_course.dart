import 'package:flutter/foundation.dart';

import 'student_sections.dart';

class StudentCourse {
  final String id;
  final num? progress;
  final List<StudentSections>? sections;

  StudentCourse({
    required this.id,
    this.progress,
    this.sections,
  });

  StudentCourse copyWith({
    String? id,
    num? progress,
    List<StudentSections>? sections,
  }) {
    return StudentCourse(
      id: id ?? this.id,
      progress: progress ?? this.progress,
      sections: sections ?? this.sections,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'progress': progress,
      'sections': sections?.map((lesson) => lesson.toMap()).toList(),
    };
  }

  factory StudentCourse.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw Exception('There is no student course data');
    }
    return StudentCourse(
      id: map['id'] as String,
      progress: map['progress'] as num?,
      sections: (map['sections'] as List<dynamic>?)
          ?.map((lesson) => StudentSections.fromMap(lesson))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'StudentCourse(id: $id, progress: $progress, sections: $sections)';
  }

  @override
  bool operator ==(covariant StudentCourse other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.progress == progress &&
        listEquals(other.sections, sections);
  }

  @override
  int get hashCode {
    return id.hashCode ^ progress.hashCode ^ sections.hashCode;
  }
}
