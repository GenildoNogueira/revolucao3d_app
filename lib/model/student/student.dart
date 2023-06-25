import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../course/course.dart';
import 'contact.dart';
import 'personal_data.dart';

class Student {
  final String id;
  final String? imageUrl;
  final String fullName;
  final String identificationNumber;
  final DateTime enrollmentDate;
  final Contact contact;
  final PersonalData personalData;
  final List<Course> coursesInProgress;

  const Student({
    required this.id,
    required this.imageUrl,
    required this.fullName,
    required this.identificationNumber,
    required this.enrollmentDate,
    required this.contact,
    required this.personalData,
    required this.coursesInProgress,
  });

  Student copyWith({
    String? id,
    String? imageUrl,
    String? fullName,
    String? identificationNumber,
    DateTime? enrollmentDate,
    Contact? contact,
    PersonalData? personalData,
    List<Course>? coursesInProgress,
  }) {
    return Student(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      fullName: fullName ?? this.fullName,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      contact: contact ?? this.contact,
      personalData: personalData ?? this.personalData,
      coursesInProgress: coursesInProgress ?? this.coursesInProgress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': imageUrl,
      'full_name': fullName,
      'identification_number': identificationNumber,
      'enrollment_date': enrollmentDate,
      'contact': contact.toMap(),
      'personal_data': personalData.toMap(),
      'coursesInProgress': coursesInProgress.map((x) => x.toMap()).toList(),
    };
  }

  factory Student.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw Exception('There is no data student');
    }
    return Student(
      id: map['id'] as String,
      imageUrl: map['image_url'] ?? '',
      fullName: map['full_name'] as String,
      identificationNumber: map['identification_number'] as String,
      enrollmentDate: (map['enrollment_date'] as Timestamp).toDate(),
      contact: Contact.fromMap(map['contact'] as Map<String, dynamic>),
      personalData:
          PersonalData.fromMap(map['personal_data'] as Map<String, dynamic>),
      coursesInProgress: List<Course>.from(
        (map['courses_in_progress'] as List<dynamic>).map<Course>(
          (x) => Course.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(id: $id, image_url: $imageUrl, full_name: $fullName, identification_number: $identificationNumber, enrollment_date: $enrollmentDate, contact: $contact, personal_data: $personalData, courses_in_progress: $coursesInProgress)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imageUrl == imageUrl &&
        other.fullName == fullName &&
        other.identificationNumber == identificationNumber &&
        other.enrollmentDate == enrollmentDate &&
        other.contact == contact &&
        other.personalData == personalData &&
        listEquals(other.coursesInProgress, coursesInProgress);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        fullName.hashCode ^
        identificationNumber.hashCode ^
        enrollmentDate.hashCode ^
        contact.hashCode ^
        personalData.hashCode ^
        coursesInProgress.hashCode;
  }
}
