import 'package:flutter/material.dart';

import 'package:prog_lazy_f/navigation/mainNavigation.dart';
import 'package:prog_lazy_f/services/authService.dart' show AuthService;

class LoaderVieWModel {
  BuildContext context;
  final _authService = AuthService();
  LoaderVieWModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();
    final nextScreen = isAuth
        ? NavigationRoutesNames.mainRoute
        : NavigationRoutesNames.authRoute;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
