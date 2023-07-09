import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'lesson.dart';

class Sections {
  final String id;
  final String name;
  final List<Lesson>? lessons;

  Sections({
    required this.id,
    required this.name,
    this.lessons,
  });

  Sections copyWith({
    String? id,
    String? name,
    List<Lesson>? lessons,
  }) {
    return Sections(
      id: id ?? this.id,
      name: name ?? this.name,
      lessons: lessons ?? this.lessons,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lessons': lessons?.map((x) => x.toMap()).toList(),
    };
  }

  factory Sections.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw Exception('There is no Sections data');
    }
    return Sections(
      id: map['id'] as String,
      name: map['name'] as String,
      lessons: map['lessons'] != null
          ? List<Lesson>.from(
              (map['lessons'] as List<dynamic>).map<Lesson?>(
                (x) => Lesson.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sections.fromJson(String source) =>
      Sections.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Sections(id: $id, name: $name, lessons: $lessons)';

  @override
  bool operator ==(covariant Sections other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.lessons, lessons);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ lessons.hashCode;
}
