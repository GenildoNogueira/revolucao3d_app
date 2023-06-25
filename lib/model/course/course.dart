import 'dart:convert';

import 'lesson.dart';

class Course {
  final String id;
  final String imageUrl;
  final String name;
  final String description;
  final num? progress;

  const Course({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.progress,
  });

  Course copyWith({
    String? id,
    String? imageUrl,
    String? name,
    String? description,
    num? progress,
    List<Lesson>? lessons,
  }) {
    return Course(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      description: description ?? this.description,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': imageUrl,
      'name': name,
      'description': description,
      'progress': progress,
    };
  }

  factory Course.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw Exception('There is no course data');
    }
    return Course(
      id: map['id'] as String,
      imageUrl: map['image_url'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      progress: map['progress'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Course(id: $id,image_url: $imageUrl, name: $name, description: $description, progress: $progress)';
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imageUrl == imageUrl &&
        other.name == name &&
        other.description == description &&
        other.progress == progress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        name.hashCode ^
        description.hashCode ^
        progress.hashCode;
  }
}
