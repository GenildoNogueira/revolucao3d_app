import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../course.dart';
import 'contact.dart';
import 'personal_data.dart';

class Student {
  final String? imageUrl;
  final String fullName;
  final String identificationNumber;
  final DateTime enrollmentDate;
  final Contact contact;
  final PersonalData personalData;
  final List<Course> coursesInProgress;

  const Student({
    required this.imageUrl,
    required this.fullName,
    required this.identificationNumber,
    required this.enrollmentDate,
    required this.contact,
    required this.personalData,
    required this.coursesInProgress,
  });

  Student copyWith({
    String? imageUrl,
    String? fullName,
    String? identificationNumber,
    DateTime? enrollmentDate,
    Contact? contact,
    PersonalData? personalData,
    List<Course>? coursesInProgress,
  }) {
    return Student(
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
    return 'Student(image_url: $imageUrl, full_name: $fullName, identification_number: $identificationNumber, enrollment_date: $enrollmentDate, contact: $contact, personal_data: $personalData, courses_in_progress: $coursesInProgress)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.fullName == fullName &&
        other.identificationNumber == identificationNumber &&
        other.enrollmentDate == enrollmentDate &&
        other.contact == contact &&
        other.personalData == personalData &&
        listEquals(other.coursesInProgress, coursesInProgress);
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        fullName.hashCode ^
        identificationNumber.hashCode ^
        enrollmentDate.hashCode ^
        contact.hashCode ^
        personalData.hashCode ^
        coursesInProgress.hashCode;
  }

  static fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {}
}
