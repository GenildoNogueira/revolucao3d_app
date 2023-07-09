import '../../model/course/course.dart';
import '../../model/student/student.dart';
import '../../model/student/student_course.dart';
import '../../model/student/student_lesson.dart';
import '../../model/student/student_sections.dart';
import '../service/firebase_services.dart';

class StudentRepository {
  final _service = FirebaseServices.instance;

  StudentRepository();

  Stream<Student> getStudents(String id) {
    return _service.documentStream(
      path: 'students/$id',
      builder: (data) => Student.fromMap(data),
    );
  }

  Stream<List<Course>> getListCourse(String id) {
    return _service.collectionStream(
      path: 'students/$id/courses',
      builder: (data) => Course.fromMap(data),
    );
  }

  Stream<List<StudentCourse>>? studentListCourses(
    String studentId,
    String courseId,
  ) {
    return _service.collectionStream(
      path: 'students/$studentId/courses',
      builder: (data) => StudentCourse.fromMap(data),
    );
  }

  Future<void> updateStudentCourse({
    required String studentId,
    required String courseId,
    required String sectionId,
    required String lessonId,
    required StudentLesson? studentLesson,
    required StudentCourse? studentCourse,
    required double progress,
  }) async {
    final List<StudentSections> updatedSections = [];

    if (studentCourse == null) {
      await _service.setData(
        path: 'students/$studentId/courses/$courseId',
        data: StudentCourse(
          id: courseId,
          sections: [
            StudentSections(
              id: sectionId,
              lessons: [
                StudentLesson(
                  id: lessonId,
                  isCompleted: progress > 0.98,
                  currentPosition: progress,
                ),
              ],
            ),
          ],
        ).toMap(),
      );
    } else {
      final List<StudentSections> sections = studentCourse.sections ?? [];

      for (final section in sections) {
        final List<StudentLesson> lessons = section.lessons ?? [];

        if (section.id == sectionId) {
          final updatedSection = StudentSections(
            id: section.id,
            lessons: [
              ...lessons,
              StudentLesson(
                id: lessonId,
                isCompleted: progress > 0.99,
                currentPosition: progress,
              ),
            ],
          );
          updatedSections.add(updatedSection);
        } else {
          updatedSections.add(section);
        }
      }

      final newSection = StudentSections(
        id: sectionId,
        lessons: [
          StudentLesson(
            id: lessonId,
            isCompleted: progress > 0.98,
            currentPosition: progress,
          ),
        ],
      );
      updatedSections.add(newSection);

      final updatedStudentCourse = studentCourse.copyWith(
        sections: updatedSections,
      );

      await _service.updatedData(
        path: 'students/$studentId/courses/$courseId',
        data: updatedStudentCourse.toMap(),
      );
    }
  }
}
