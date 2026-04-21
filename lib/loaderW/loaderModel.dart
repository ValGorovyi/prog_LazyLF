import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart'
    show SessionDataProvider;
import 'package:prog_lazy_f/navigation/mainNavigation.dart';

class LoaderVieWModel {
  BuildContext context;
  final _sessionDataProvider = SessionDataProvider();
  LoaderVieWModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuth = sessionId != null;
    final nextScreen = isAuth
        ? NavigationRoutesNames.mainRoute
        : NavigationRoutesNames.authRoute;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
