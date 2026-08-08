import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prog_lazy_f/authW/authCubit.dart';
import 'package:prog_lazy_f/navigation/mainNavigation.dart' show MainNavigation;
import 'package:provider/provider.dart';

class _AuthDataStorage {
  String login = '';
  String pasword = '';
}

class AuthorizW extends StatelessWidget {
  const AuthorizW({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = context.read<AuthViewModel>();
    return BlocListener<AuthViewCubit, AuthVieWCubitState>(
      listenWhen: (_, current) => current is AuthVieWCubitSuccesAuthState,
      listener: _onAuthCubitState,
      child: Provider(
        create: (_) => _AuthDataStorage(),
        child: Scaffold(
          appBar: AppBar(title: Text('Log In')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AuthInputTextFormW(),
            ),
          ),
        ),
      ),
    );
  }

  void _onAuthCubitState(BuildContext context, AuthVieWCubitState state) {
    if (state is AuthVieWCubitSuccesAuthState) {
      MainNavigation.resetNavigatot(context);
    }
  }
}

class AuthInputTextFormW extends StatelessWidget {
  const AuthInputTextFormW({super.key});

  @override
  Widget build(BuildContext context) {
    final _authDataStorage = context.read<_AuthDataStorage>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text('E-mail'),
        TextField(
          decoration: InputDecoration(labelText: 'e-mail'),
          onChanged: (lText) => _authDataStorage.login = lText,
        ),
        SizedBox(height: 12),
        Text('Password'),
        TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'password'),
          onChanged: (pText) => _authDataStorage.pasword = pText,
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
    );
  }
}

class _errorMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final errorMessage = context.select(
    //   (AuthViewModel model) => model.errorMessage,
    // );

    final errorMessage = context.select((AuthViewCubit c) {
      final state = c.state;
      return state is AuthVieWCubitErrorState ? state.errorMessage : null;
    });

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
    final cubit = context.watch<AuthViewCubit>();
    final authDataStorage = context.read<_AuthDataStorage>();

    print(cubit.state);

    final canStartAuth =
        cubit.state is AuthViewCubitExpectationState ||
        cubit.state is AuthVieWCubitErrorState;
    final onPressedW = canStartAuth
        ? () => cubit.auth(
            login: authDataStorage.login,
            password: authDataStorage.pasword,
          )
        : null;
    final childW = cubit.state is AuthVieWCubitInProgressState
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
