import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/repository/authentication_repository.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AuthenticationRepository>();
    return StreamBuilder(
      stream: controller.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        final user = snapshot.data;
        return user != null && user.isNotEmpty
            ? HomePage(user: snapshot.data!)
            : const LoginPage();
      },
    );
  }
}
