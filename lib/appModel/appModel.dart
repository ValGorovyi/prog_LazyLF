import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart'
    show SessionDataProvider;

class AppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;
  Future<void> checkAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }
}
