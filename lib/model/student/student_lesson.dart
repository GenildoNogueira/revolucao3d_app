import 'dart:convert';

class StudentLesson {
  final String? id;
  final bool? isCompleted;
  final num? currentPosition;

  StudentLesson({
    this.id,
    this.isCompleted,
    this.currentPosition,
  });

  StudentLesson copyWith({
    String? id,
    bool? isCompleted,
    num? currentPosition,
  }) {
    return StudentLesson(
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'is_completed': isCompleted,
      'current_position': currentPosition,
    };
  }

  factory StudentLesson.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw Exception('There is no student lesson data');
    }
    return StudentLesson(
      id: map['id'] ?? '',
      isCompleted: map['is_completed'] ?? false,
      currentPosition: map['current_position'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentLesson.fromJson(String source) =>
      StudentLesson.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudentLesson(id: $id, is_completed: $isCompleted, current_position: $currentPosition)';
  }

  @override
  bool operator ==(covariant StudentLesson other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isCompleted == isCompleted &&
        other.currentPosition == currentPosition;
  }

  @override
  int get hashCode {
    return id.hashCode ^ isCompleted.hashCode ^ currentPosition.hashCode;
  }
}
