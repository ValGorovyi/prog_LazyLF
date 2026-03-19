import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart'
    show SessionDataProvider;
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;

class AppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;
  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);
    Navigator.of(context).pushNamedAndRemoveUntil(
      NavigationRoutesNames.authRoute,
      (route) => false,
    );
  }
}
