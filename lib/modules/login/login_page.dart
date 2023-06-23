import 'package:flutter/material.dart';

import '../../core/repository/authentication_repository.dart';
import 'recover_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool isRemember = true;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  Future<void> login() async {
    _isLoading.value = true;
    final authRepository = AuthenticationRepository();
    try {
      await authRepository.logInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _isLoading.value = false;
    } on LogInWithEmailAndPasswordFailure catch (e) {
      _isLoading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Hero(
                tag: 'logo',
                child: Container(
                  width: 160,
                  height: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bem-vindo ao seu ambiente virtual de aprendizagem',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  label: const Text('E-mail'),
                  prefixIcon: const Icon(Icons.mail_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  _isLoading.value = false;
                  if (value!.isEmpty) {
                    return 'O campo não pode esta vasio!';
                  } else if (!value.contains('@')) {
                    return 'O email não é válido!';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  label: const Text('Senha'),
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: IconButton(
                    icon: _isPasswordVisible
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                    onPressed: () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: _isPasswordVisible,
                validator: (value) {
                  _isLoading.value = false;
                  if (value!.isEmpty) {
                    return 'O campo não pode esta vasio!';
                  }
                  if (value.length < 6) {
                    return 'Sua senha deve ter no mínimo 6 caracteres!';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                value: isRemember,
                onChanged: (newValue) {
                  setState(() {
                    isRemember = newValue!;
                  });
                },
                title: const Text('Lembrar login'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (context, valueLoading, _) {
                  return ElevatedButton(
                    onPressed: !valueLoading ? login : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                    ),
                    child: !valueLoading
                        ? const Text(
                            'Entrar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecoverPassword(),
                    ),
                  );
                },
                child: const Text('Esqueceu a senha?'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
