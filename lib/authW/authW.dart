import 'package:flutter/material.dart';
import 'package:prog_lazy_f/authW/authModel.dart';
import 'package:provider/provider.dart';

class AuthorizW extends StatelessWidget {
  const AuthorizW({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text('Log In')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text('E-mail'),
              TextField(
                controller: model.loginTextController,
                decoration: InputDecoration(labelText: 'e-mail'),
              ),
              SizedBox(height: 12),
              Text('Password'),
              TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'password'),
                controller: model.passworldTextController,
              ),
              SizedBox(height: 15),
              _errorMessageWidget(),

              Row(
                children: [
                  _elevatedLoginButton(),
                  SizedBox(width: 30),
                  TextButton(
                    onPressed: () {},
                    style: Theme.of(context).textButtonTheme.style,
                    child: const Text('Reset password'),
                  ),
                ],
              ),
              SizedBox(height: 15),
              const Text(
                'Stream or download all our movies, anytime. On any screen or device, anywhere. From cult classics to modern masterpieces. From the greatest ever directors, to the greatest new directors. Films from everywhere on earth.',
              ),
              TextButton(onPressed: () {}, child: Text('Registration')),
              SizedBox(height: 15),
              const Text(
                'Read a print magazine devoted to the art and the culture of cinema. Created, prepared, and published by MUBI. Receive two beautiful issues a year. Available worldwide with a magazine subscription.',
              ),
              TextButton(onPressed: () {}, child: Text('Veryfy e-mail')),
            ],
          ),
        ),
      ),
    );
  }
}

class _errorMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select(
      (AuthViewModel model) => model.errorMessage,
    );

    final errWidget = errorMessage == null
        ? SizedBox.shrink()
        : Text(errorMessage, style: TextStyle(color: Colors.red));
    if (errorMessage == null) return SizedBox.shrink();
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 20),
      child: errWidget,
    );
  }
}

class _elevatedLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthViewModel>();
    final onPressedW = model.canStartAuth == true
        ? () => model.auth(context)
        : null;
    final childW = model.isAuthProgress
        ? SizedBox(
            height: 16,
            width: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text('Login');
    return ElevatedButton(
      onPressed: onPressedW,
      style: Theme.of(context).elevatedButtonTheme.style,
      child: childW,
    );
  }
}
