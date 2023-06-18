import 'lesson.dart';

class Course {
  final String imageUrl;
  final String name;
  final String description;
  final double progress;
  final List<Lesson>? lessons;

  const Course({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.progress,
    this.lessons,
  });
}
