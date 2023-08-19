import 'dart:io';

import 'package:uuid/uuid.dart';

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

  Future<String?> uploadUserProfileImage(File file) async {
    final ref = _storage
        .ref(_StorageNames._users)
        .child(_StorageNames._profilePics)
        .child(const Uuid().v4())
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();

    return url;
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
