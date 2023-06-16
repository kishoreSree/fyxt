import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class secureDatas {
  static final _storage = FlutterSecureStorage();
  static const _keyUsername = 'username';
  static const _keyPassword = 'password';
  static const _HostLink = 'hostlink';
  static const serviceType = 'SRtype';
  static Future setEmail(String email) async {
    await _storage.write(key: _keyUsername, value: email);
  }

  static Future getEmail() async {
    return await _storage.read(key: _keyUsername);
  }

  static Future setpass(String password) async {
    await _storage.write(key: _keyPassword, value: password);
  }

  static Future getpass() async {
    return await _storage.read(key: _keyPassword);
  }

  static Future sethost(String Hostlink) async {
    return await _storage.write(key: _HostLink, value: Hostlink);
  }

  static Future gethost() async {
    return await _storage.read(key: _HostLink);
  }

  static Future setSRType(String ServiceType) async {
    await _storage.write(key: serviceType, value: ServiceType);
  }

  static Future getSRtype() async {
    return await _storage.read(key: serviceType);
  }
}
