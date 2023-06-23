import 'package:flutter_modular/flutter_modular.dart';

import 'course_lessons_page.dart';

class CourseLessonsModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => CourseLessonsPage(
            data: args.data,
          ),
        ),
      ];
}
