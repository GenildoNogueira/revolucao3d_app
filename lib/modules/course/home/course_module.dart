import 'package:flutter_modular/flutter_modular.dart';

import 'course_page.dart';

class CourseModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => CoursePage(
            listObject: args.data,
          ),
        ),
      ];
}
