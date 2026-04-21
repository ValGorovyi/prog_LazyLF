import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart';

class AuthService {
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuthBool = sessionId != null;
    return isAuthBool;
  }
}

//repository
