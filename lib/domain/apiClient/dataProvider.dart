import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _myKeys {
  static const sessionIdK = 'session-id-k';
  static const accountIdK = 'account-id-k';
}

class SessionDataProvider {
  static const _securityStorage = FlutterSecureStorage();

  Future<String?> getSessionId() =>
      _securityStorage.read(key: _myKeys.sessionIdK);

  Future<int?> getAccountId() async {
    final id = await _securityStorage.read(key: _myKeys.accountIdK);
    return id != null ? int.tryParse(id) : null;
  }

  Future<void> setSessionId(String value) {
    return _securityStorage.write(key: _myKeys.sessionIdK, value: value);
  }

  Future<void> setAccountId(int? value) {
    return _securityStorage.write(
      key: _myKeys.accountIdK,
      value: value.toString(),
    );
  }

  Future<void> deleteAccountId() {
    return _securityStorage.delete(key: _myKeys.accountIdK);
  }

  Future<void> deleteSessionId() {
    return _securityStorage.delete(key: _myKeys.sessionIdK);
  }
}
