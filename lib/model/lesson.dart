import 'dart:convert';

class Lesson {
  final String id;
  final String name;
  final String description;
  final String videoUrl;
  final String duration;
  final bool? isCompleted;
  final double? currentPosition;

  Lesson({
    required this.id,
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.duration,
    this.isCompleted,
    this.currentPosition,
  });

  Lesson copyWith({
    String? id,
    String? name,
    String? description,
    String? videoUrl,
    String? duration,
    bool? isCompleted,
    double? currentPosition,
  }) {
    return Lesson(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'video_url': videoUrl,
      'duration': duration,
      'is_completed': isCompleted,
      'currentPosition': currentPosition,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw Exception('There is no course data');
    }
    return Lesson(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      videoUrl: map['video_url'] as String,
      duration: map['duration'] ?? '',
      isCompleted: map['is_completed'] ?? false,
      currentPosition: map['currentPosition'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) =>
      Lesson.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Lesson(id: $id, name: $name, description: $description, duration: $duration, is_completed: $isCompleted, currentPosition: $currentPosition)';
  }

  @override
  bool operator ==(covariant Lesson other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.duration == duration &&
        other.isCompleted == isCompleted &&
        other.currentPosition == currentPosition;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        duration.hashCode ^
        isCompleted.hashCode ^
        currentPosition.hashCode;
  }
}
