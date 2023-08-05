import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteConfigService = Provider(
  (_) => const RemoteConfigService(),
);

class RemoteConfigService {
  const RemoteConfigService();

  FirebaseRemoteConfig get _config => FirebaseRemoteConfig.instance;
}
