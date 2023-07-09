import 'package:flutter_modular/flutter_modular.dart';

import '../course_controller.dart';
import '../course_state.dart';
import 'course_page.dart';

class CourseModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => CourseState('')),
        Bind((i) => CourseController(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => CoursePage(
            studentCourseData: args.data,
          ),
        ),
      ];
}
