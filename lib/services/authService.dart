import 'package:prog_lazy_f/domain/apiClient/apiClient.dart';
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart';

class AuthService {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuthBool = sessionId != null;
    return isAuthBool;
  }

  Future<void> loginingMethod(String login, String password) async {
    final sessionId = await _apiClient.auth(
      username: login,
      password: password,
    );
    final accountId = await _apiClient.getAccId(sessionId);
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
  }
}

//repository
