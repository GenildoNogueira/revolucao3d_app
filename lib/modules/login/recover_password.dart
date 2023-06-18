import 'validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailAndPasswordValidators {
  final TextInputFormatter emailInputFormatter =
      ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator());
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
}

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  bool submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Form(
            onChanged: () => _emailController.text,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildEmailField(),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  key: const Key('primary-button'),
                  icon: const Icon(Icons.send),
                  label: const Text('Enviar Codigo'),
                  onPressed: isLoading ? null : () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      key: const Key('email'),
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        enabled: !isLoading,
        prefixIcon: const Icon(Icons.mail_outlined),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.white,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
      autocorrect: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
