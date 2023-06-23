import 'package:revolucao3d_app/core/service/firebase_services.dart';

import '../../model/student/student.dart';

class StudentRepository {
  final _service = FirebaseServices.instance;

  Stream<Student> getStudents(String id) {
    return _service.documentStream(
      path: 'students/$id',
      builder: (data) => Student.fromMap(data),
    );
  }
}
