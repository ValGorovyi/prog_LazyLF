import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  final loginTextController = TextEditingController();
  final passworldTextController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Future<void> auth(BuildContext context) async {}
  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
}

class AuthInherit extends InheritedNotifier {
  final AuthModel model;
  AuthInherit({required super.child, required this.model})
    : super(notifier: model);

  static AuthInherit? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  static AuthInherit? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType()?.widget;
    return widget is AuthInherit ? widget : null;
  }
}
