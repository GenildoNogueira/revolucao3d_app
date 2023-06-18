import '../course.dart';
import 'contact.dart';
import 'personal_data.dart';

class Student {
  final String fullName;
  final String identificationNumber;
  final DateTime enrollmentDate;
  final Contact contact;
  final PersonalData personalData;
  final List<Course> coursesInProgress;

  const Student({
    required this.fullName,
    required this.identificationNumber,
    required this.enrollmentDate,
    required this.contact,
    required this.personalData,
    required this.coursesInProgress,
  });
}
