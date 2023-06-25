import '../../model/course/course.dart';
import '../../model/course/lesson.dart';
import '../../model/student/student.dart';
import '../../model/student/student_course.dart';
import '../service/firebase_path.dart';
import '../service/firebase_services.dart';
import 'course_repository.dart';

class StudentRepository {
  final _service = FirebaseServices.instance;
  final CourseRepository courseRepository;

  StudentRepository({
    required this.courseRepository,
  });

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

  Stream<List<Lesson>> getUserListLessons(
    String courseId,
    String sectionId,
  ) {
    return _service.collectionStream(
      path: FirebasePath.courseLessonPath(
        courseId: courseId,
        sectionId: sectionId,
      ),
      builder: (data) => Lesson.fromMap(data),
    );
  }

  Future<List<StudentCourse>> studentListCourses(
    String studentId,
    String courseId,
    String sectionId,
  ) {
    return _service.collectionFuture(
      path: 'students/$studentId/courses',
      builder: (data) => StudentCourse.fromMap(data),
    );
  }

  Future<List<Lesson>> getLissonsProgress(
    String studentId,
    String courseId,
    String sectionId,
  ) async {
    List<Lesson> lessonList = [];
    List<StudentCourse> courseList = [];

    final lessons = await courseRepository.getListLessons(
      courseId,
      sectionId,
    );
    final studentCourse = await studentListCourses(
      studentId,
      courseId,
      sectionId,
    );

    for (var lesson in lessons) {
      for (var course in studentCourse) {
        courseList.add(course);
        lessonList.add(
          Lesson(
            id: lesson.id,
            name: lesson.name,
            description: lesson.description,
            videoUrl: lesson.videoUrl,
            duration: lesson.duration,
            isCompleted: course.sections?[0].lessons?[0].isCompleted,
            currentPosition: course.sections?[0].lessons?[0].currentPosition,
          ),
        );
      }
    }

    return lessonList;
  }
}
