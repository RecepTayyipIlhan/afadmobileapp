import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageProv = Provider<LocalStorageService>(LocalStorageService.new);

class LocalStorageService {
  final Ref ref;

  LocalStorageService(this.ref);

  Future<SharedPreferences> getPrefs() async =>
      await SharedPreferences.getInstance();

  Future<bool> _setVal(String key, String val) async {
    final prefs = await getPrefs();

    final set = await prefs.setString(
      key,
      val,
    );

    return set;
  }

  Future<T> _getVal<T>(String key) async {
    final prefs = await getPrefs();

    final val = prefs.get(key);

    return val as T;
  }

  Future<bool> _removeVAl(String key) async {
    final prefs = await getPrefs();

    final removed = await prefs.remove(key);

    return removed;
  }

  Future<bool> setAuthEmail(String email) => _setVal(
        _LocalStorageKeys._authEmail,
        email,
      );

  Future<String?> getAuthEmail() =>
      _getVal<String>(_LocalStorageKeys._authEmail);

  Future<bool> removeAuthEmail() => _removeVAl(_LocalStorageKeys._authEmail);
}

class _LocalStorageKeys {
  static const _authEmail = 'authEmail';
}
