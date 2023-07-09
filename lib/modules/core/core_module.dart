import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/repository/authentication_repository.dart';
import '../../core/repository/course_repository.dart';
import '../../core/repository/student_repository.dart';
import '../../core/widgets/loading_dialog.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<LoadingDialog>(
          (i) => LoadingDialogImpl(),
          export: true,
        ),
        Bind.singleton(
          (i) => CourseRepository(),
          export: true,
        ),
        Bind.singleton(
          (i) => StudentRepository(),
          export: true,
        ),
        Bind.singleton(
          (i) => AuthenticationRepository(firebaseAuth: i()),
          export: true,
        ),
        Bind.singleton(
          (i) => FirebaseAuth.instance,
          export: true,
        ),
      ];

  @override
  List<ModularRoute> get routes => [];
}
