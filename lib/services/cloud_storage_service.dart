import 'dart:io';

import '../utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cloud_firestore_service.dart';

import '../utils/prov/auth_prov.dart';

final fbStorageService = Provider(CloudStorageService.new);

final _storageProv = Provider(
  (_) => FirebaseStorage.instance,
);

class CloudStorageService {
  final Ref _ref;
  const CloudStorageService(this._ref);

  FirebaseStorage get _storage => _ref.read(_storageProv);

  Future<bool> uploadUserProfileImage(File file) async {
    final user = _ref.read(authProvider).appUser;

    if (user == null) {
      logger.e('User is null');

      return false;
    }

    final userId = user.id;

    final ref = _storage
        .ref(_StorageNames._users)
        .child(_StorageNames._profilePics)
        .child(userId)
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();

    final db = _ref.read(fbDbProv);
    final res = await db.setUserProfilePicUrl(userId, url);

    return res;
  }
}

class _StorageNames {
  // quiz
  static const String
      //
      _users = 'users',
      _profilePics = 'profile_pics'

      //
      ;
}
