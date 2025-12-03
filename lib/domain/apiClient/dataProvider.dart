import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _myKeys {
  static const sessionIdK = 'session-id-k';
}

class SessionDataProvider {
  static const _securityStorage = FlutterSecureStorage();
  Future<String?> getSessionId() =>
      _securityStorage.read(key: _myKeys.sessionIdK);
  Future<void> setSessionId(String? value) {
    if (value != null) {
      return _securityStorage.write(key: _myKeys.sessionIdK, value: value);
    } else {
      return _securityStorage.delete(key: _myKeys.sessionIdK);
    }
  }
}
