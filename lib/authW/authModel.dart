import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClient.dart'
    show ApiClient, ApiClientExeption, ApiClientExeptionType;
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart';
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;

class AuthModel extends ChangeNotifier {
  final _sessinDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();
  final loginTextController = TextEditingController();
  final passworldTextController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passworldTextController.text;
    if (login.isEmpty && password.isEmpty) {
      _errorMessage = 'lodin or password is empty';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(username: login, password: password);
    } on ApiClientExeption catch (e) {
      switch (e.type) {
        case ApiClientExeptionType.Network:
          _errorMessage = 'Network error. Wi-fi???';
          break;
        case ApiClientExeptionType.Auth:
          _errorMessage = 'Login or password error';
          break;
        case ApiClientExeptionType.Other:
          _errorMessage = 'error. repeat pleace';
          break;
      }
    } catch (er) {
      _errorMessage = 'error catch. repeat';
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'unknow error';
      notifyListeners();
      return;
    }
    await _sessinDataProvider.setSessionId(sessionId);
    Navigator.of(context).pushReplacementNamed(NavigationRoutesNames.mainRoute);
  }

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;
}

class AuthInherit extends InheritedNotifier {
  final AuthModel model;
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
