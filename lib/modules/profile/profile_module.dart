import 'package:flutter_modular/flutter_modular.dart';
import 'package:revolucao3d_app/modules/profile/profile_page.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ProfilePage(student: args.data),
        ),
      ];
}
