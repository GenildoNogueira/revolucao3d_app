import '../../model/course.dart';
import '../../model/lesson.dart';
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
      path: 'courses',
      builder: (data) => Course.fromMap(data),
    );
  }

  Stream<List<Lesson>> getLessons(String courseId) {
    return _service.collectionStream(
      path: 'courses/$courseId/lessons',
      builder: (data) => Lesson.fromMap(data),
    );
  }
}
