import 'package:flutter_modular/flutter_modular.dart';

import 'course/details/details_page.dart';
import 'core/auth_page.dart';
import 'core/core_module.dart';
import 'course/home/course_module.dart';
import 'home/home_module.dart';
import 'login/login_module.dart';
import 'profile/profile_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const AuthPage(),
        ),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/profile', module: ProfileModule()),
        ModuleRoute('/course', module: CourseModule()),
        ChildRoute(
          '/course-details',
          child: (context, args) => DetailsPage(course: args.data),
        ),
      ];
}
