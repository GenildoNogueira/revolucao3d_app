import '../../model/course/course.dart';
import '../../model/course/lesson.dart';
import '../../model/course/sections.dart';
import '../service/firebase_path.dart';
import '../service/firebase_services.dart';

class CourseRepository {
  final _service = FirebaseServices.instance;

  Stream<Course> getCourse(String id) {
    return _service.documentStream(
      path: 'courses/$id',
      builder: (data) => Course.fromMap(data),
    );
  }

  Stream<List<Course>> getListCourse() {
    return _service.collectionStream(
      path: FirebasePath.coursesPath,
      builder: (data) => Course.fromMap(data),
    );
  }

  Stream<List<Sections>> getListSections(String courseId) {
    return _service.collectionStream(
      path: FirebasePath.listSectionsPath(courseId: courseId),
      builder: (data) => Sections.fromMap(data),
    );
  }

  Future<List<Lesson>> getListLessons(
    String courseId,
    String sectionId,
  ) {
    return _service.collectionFuture(
      path: FirebasePath.courseLessonPath(
        courseId: courseId,
        sectionId: sectionId,
      ),
      builder: (data) => Lesson.fromMap(data),
    );
  }
}
