import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/movieApiClient.dart'
    show ApiClientExeption;
import 'package:prog_lazy_f/domain/apiClient/apiClientExeption.dart'
    show ApiClientExeptionType;
import 'package:prog_lazy_f/navigation/mainNavigation.dart' show MainNavigation;
import 'package:prog_lazy_f/services/authService.dart' show AuthService;

class AuthViewModel extends ChangeNotifier {
  final loginTextController = TextEditingController();
  final passworldTextController = TextEditingController();
  final _authService = AuthService();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  bool _isValid(String login, String password) {
    return login.isNotEmpty && password.isNotEmpty;
  }

  void _updateState(String? errorMessageArg, bool isAuthProgressArg) {
    if (errorMessageArg == _errorMessage &&
        isAuthProgressArg == _isAuthProgress) {
      return;
    }
    _errorMessage = errorMessageArg;
    _isAuthProgress = isAuthProgressArg;
    notifyListeners();
  }

  Future<String?> _loginingProcess(String login, String password) async {
    try {
      await _authService.loginingMethod(login, password);
      return null;
    } on ApiClientExeption catch (e) {
      switch (e.type) {
        case ApiClientExeptionType.Network:
          return 'Network error. Wi-fi???';
        case ApiClientExeptionType.Auth:
          return 'Login or password error';
        case ApiClientExeptionType.Other:
          return 'Error. Repeat pleace';
        case ApiClientExeptionType.SessionExpired:
          return 'Crazy error';
      }
    } catch (er) {
      return 'Error catch. Repeat later';
    }
  }

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passworldTextController.text;

    if (!_isValid(login, password)) {
      _updateState('Lodin or password is empty', false);
      return;
    }
    _updateState(null, true);
    _errorMessage = await _loginingProcess(login, password);
    if (_errorMessage == null) {
      MainNavigation.resetNavigatot(context);
    } else {
      _updateState(_errorMessage, false);
    }
  }
}

class AuthInherit extends InheritedNotifier {
  final AuthViewModel model;
  AuthInherit({required super.child, required this.model})
    : super(notifier: model);

  static AuthInherit? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthInherit>();
  }

  static AuthInherit? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<AuthInherit>()
        ?.widget;
    return widget is AuthInherit ? widget : null;
  }
}
