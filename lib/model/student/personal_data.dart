// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalData {
  final DateTime dateOfBirth;
  final String gender;
  final String nationality;

  const PersonalData({
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
  });

  PersonalData copyWith({
    DateTime? dateOfBirth,
    String? gender,
    String? nationality,
  }) {
    return PersonalData(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'nationality': nationality,
    };
  }

  factory PersonalData.fromMap(Map<String, dynamic> map) {
    return PersonalData(
      dateOfBirth: (map['date_of_birth'] as Timestamp).toDate(),
      gender: map['gender'] as String,
      nationality: map['nationality'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalData.fromJson(String source) =>
      PersonalData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PersonalData(date_of_birth: $dateOfBirth, gender: $gender, nationality: $nationality)';

  @override
  bool operator ==(covariant PersonalData other) {
    if (identical(this, other)) return true;

    return other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.nationality == nationality;
  }

  @override
  int get hashCode =>
      dateOfBirth.hashCode ^ gender.hashCode ^ nationality.hashCode;
}
