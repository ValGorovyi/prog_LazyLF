import 'package:prog_lazy_f/domain/apiClient/accountApiClient.dart'
    show AccountApiClient;
import 'package:prog_lazy_f/domain/apiClient/authApiClient.dart'
    show AuthApiClient;
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart'
    show SessionDataProvider;

class AuthService {
  final _sessionDataProvider = SessionDataProvider();
  final _accountApiClient = AccountApiClient();
  final _authApiCliet = AuthApiClient();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuthBool = sessionId != null;
    return isAuthBool;
  }

  Future<void> loginingMethod(String login, String password) async {
    final sessionId = await _authApiCliet.auth(
      username: login,
      password: password,
    );
    final accountId = await _accountApiClient.getAccId(sessionId);
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
  }

  Future<void> logoutMethod() async {
    await _sessionDataProvider.deleteSessionId();
    await _sessionDataProvider.deleteAccountId();
  }
}

//repository
