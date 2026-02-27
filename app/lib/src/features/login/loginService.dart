import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

const String clientId = String.fromEnvironment('clientId', defaultValue: 'app');

const String clientSecret = String.fromEnvironment(
  'clientSecret',
  defaultValue: '5ToRHRiqrEZxv0iicC8S2hrka3uabT2M',
);

const String authorizationEndpoint = String.fromEnvironment(
  'authorizationEndpoint',
  defaultValue:
      'http://localhost:7000/realms/Exkartikulator/protocol/openid-connect/token',
);

class LoginServiceFactory {
  static LoginService? _client;

  static LoginService client() {
    _client ??= LoginService();
    return _client!;
  }
}

class LoginService {
  oauth2.Client? _client;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> isAuthorized() async {
    // Check that there are credentials and that they have not expired.
    if (_client != null) {
      return !_client!.credentials.isExpired;
    } else {
      await _loadClient();
      return _client != null && !_client!.credentials.isExpired;
    }
  }

  Future<oauth2.Client?> getClient() async {
    // Retuns the client that can be used to make requests to the backend
    if (_client == null) {
      await _loadClient();
    }
    return _client;
  }

  Future<void> _loadClient() async {
    // Load client credentials from secure storage if exists
    String? authorizationJson = await _storage.read(key: "authJson");
    if (authorizationJson != null) {
      var credentials = oauth2.Credentials.fromJson(authorizationJson);

      _client = oauth2.Client(
        credentials,
        identifier: clientId,
        secret: clientSecret,
      );
    }
  }

  Future<void> login(String username, String password) async {
    try {
      _client = await oauth2.resourceOwnerPasswordGrant(
        Uri.parse(authorizationEndpoint),
        username,
        password,
        identifier: clientId,
        secret: clientSecret,
      );

      // Save client credentials to secure storage
      await _storage.write(
        key: "authJson",
        value: _client!.credentials.toJson(),
      );
    } catch (e) {
      _client = null;
    }
  }

  void logout() {
    // Delete credentials in secure storage and close client.
    _storage.delete(key: "authJson");
    _client?.close();
    _client = null;
  }
}
