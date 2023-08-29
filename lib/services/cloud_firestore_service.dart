import 'dart:convert';

import 'package:afad_app/features/mayday_call/help_message.dart';
import 'package:afad_app/features/tracker/models/tracker_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../features/auth/models/app_user.dart';
import '../utils/utils.dart';

final fbDbProv = Provider(CloudFirestoreService.new);

final _firestoreProv = Provider(
  (_) => FirebaseFirestore.instance,
);

final _realtimeProv = Provider(
  (_) => FirebaseDatabase.instance,
);

class CloudFirestoreService {
  final Ref _ref;
  const CloudFirestoreService(this._ref);

  FirebaseFirestore get _firestore => _ref.read(_firestoreProv);
  FirebaseDatabase get _realtime => _ref.read(_realtimeProv);
}

extension UserFunctions on CloudFirestoreService {
  Future<bool> registerDeviceInfo({
    required String? userId,
    required String? devId,
    required Map<String, String?> deviceInfo,
  }) async {
    try {
      await _firestore
          .collection(_FirestoreNames._deviceInfo)
          .doc(userId ?? _FirestoreNames._unauthUserDeviceInfo)
          .collection(
            _FirestoreNames._deviceInfo,
          )
          .doc(devId ?? _FirestoreNames._unIddUserDeviceInfo)
          .set(deviceInfo);

      return true;
    } catch (e) {
      logger.e(e);

      return false;
    }
  }

  Future<void> createUser(AppUser user) async {
    try {
      user = user.copyWith(
        lastUpdated: DateTime.now(),
      );

      final json = user.toJson();

      await _firestore.collection(_FirestoreNames._users).add(json);
    } catch (e) {
      logger.e(e);

      // if the user has been created, we want to delete it
      // and then rethrow the error

      final query = await _firestore
          .collection(_FirestoreNames._users)
          .where('email', isEqualTo: user.email)
          .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;

        await doc.reference.delete();
      }

      rethrow;
    }
  }

  Future<void> updateUser(
    AppUser user, {
    QuerySnapshot<Map<String, dynamic>>? fetchedDoc,
  }) async {
    try {
      user = user.copyWith(
        lastUpdated: DateTime.now(),
      );

      final json = user.toJson();

      var doc = fetchedDoc ??
          await _firestore
              .collection(_FirestoreNames._users)
              .where('id', isEqualTo: user.id)
              .get();

      if (doc.docs.isEmpty) {
        throw Exception('User not found');
      }

      var usref = doc.docs.first;

      try {
        final oldProfile = usref.data();
        usref.reference.collection(_FirestoreNames._userOldProfiles).doc().set(
              oldProfile,
            );
      } catch (e) {
        logger.e(e);
      }

      await usref.reference.update(json);
    } catch (e) {
      logger.e(e);

      rethrow;
    }
  }

  Stream<AppUser?> streamUser(String userId) {
    return _firestore
        .collection(_FirestoreNames._users)
        .where('id', isEqualTo: userId)
        .snapshots()
        .map(
      (event) {
        if (event.docs.isEmpty) {
          return null;
        }

        final doc = event.docs.first;

        final user = AppUser.fromJson(doc.data());

        return user;
      },
    );
  }

  /// cant reach auth prov from here
  /// as it causes a circular dependency
  Future<bool> setUserProfilePicUrl(String userId, String url) async {
    try {
      final doc = await _firestore
          .collection(_FirestoreNames._users)
          .where('id', isEqualTo: userId)
          .get();

      if (doc.docs.isEmpty) {
        return false;
      }

      final firstDoc = doc.docs.first;

      var model = AppUser.fromJson(firstDoc.data());

      model = model.copyWith(profilePicUrl: url);

      await updateUser(model, fetchedDoc: doc);

      return true;
    } catch (e) {
      logger.e(e);
    }

    return false;
  }

  Future<bool> deleteUser(String userId) async {
    try {
      final doc = await _firestore
          .collection(_FirestoreNames._users)
          .where('id', isEqualTo: userId)
          .get();

      if (doc.docs.isEmpty) {
        return false;
      }

      final firstDoc = doc.docs.first;

      await firstDoc.reference.delete();

      return true;
    } catch (e) {
      logger.e(e);
    }

    return false;
  }
}

extension AdminFunctions on CloudFirestoreService {
  Stream<List<AppUser>?> getUsers() {
    return _firestore.collection(_FirestoreNames._users).snapshots().map(
      (e) {
        final users = e.docs
            .map(
              (e) => AppUser.fromJson(
                e.data(),
              ),
            )
            .toList();

        return users;
      },
    );
  }

  Stream<List<HelpMessage?>> getUserWithUi(String userId) {
    return _firestore
        .collection(_FirestoreNames._messages)
        .where('id', isEqualTo: userId)
        .snapshots()
        .map(
      (event) {
        final doc =
            event.docs.map((e) => HelpMessage.fromJson(e.data())).toList();
        return doc;
      },
    );
  }

  Stream<List<HelpMessage>?> getMessages() {
    return _firestore.collection(_FirestoreNames._messages).snapshots().map(
      (e) {
        final users = e.docs
            .map(
              (e) => HelpMessage.fromJson(
                e.data(),
              ),
            )
            .toList();

        return users;
      },
    );
  }

  /*Stream<HelpMessage?> getUserWithUi(String ui) {
    return _firestore
        .collection(_FirestoreNames._messages)
        .where('ui', isEqualTo: ui)
        .snapshots()
        .map(
      (event) {
        if (event.docs.isEmpty) {
          return null;
        }

        final doc = event.docs.first;

        final msg = HelpMessage.fromJson(doc.data());
        return msg;
      },
    );
  }*/

  Stream<TrackerLocation> streamTrackerLocation() {
    final ref = _realtime.ref("tracker/str");

    return ref.onValue.map(
      (event) {
        final val64Full = event.snapshot.value as String;
        // blob,base64,base64({lat},{lng})
        final val64 = val64Full.split(",")[2];

        final bytes = base64.decode(val64);
        final decodedString = utf8.decode(bytes);

        final lat = decodedString.split(",")[0];
        final lng = decodedString.split(",")[1];

        return TrackerLocation(
          loc: GeoPoint(
            double.parse(lat),
            double.parse(lng),
          ),
          lastUpdated: DateTime.now(),
        );
      },
    );
  }
}

class DayHasQuiz {
  final DateTime day;
  final bool hasEstimationQuiz;
  final bool hasMultiQuiz;

  const DayHasQuiz({
    required this.day,
    required this.hasEstimationQuiz,
    required this.hasMultiQuiz,
  });
}

class _FirestoreNames {
  // general
  static const String
      //
      _unauthUserDeviceInfo = 'unauth_user_device_info',
      _unIddUserDeviceInfo = 'un_idd_user_device_info',
      _deviceInfo = 'device_info'
      //
      ;

  // quiz
  static const String
      //
      _estimateQuiz = 'estimate_quiz',
      _multiQuiz = 'multi_quiz'
      //
      ;

  // auth
  static const String
      //
      _users = 'users',
      _messages = 'messages',
      _userOldProfiles = 'user_old_profiles',
      _userPoints = 'user_points'
      //
      ;

  static const String
      //
      _quizSubmission = 'quiz_submission',
      _multiQuizSubmissions = 'multi_quiz_submissions',
      _estimateQuizSubmissions = 'estimate_quiz_submissions',
//
      _quizEntrances = 'quiz_entrances',
      _multiQuizEntrances = 'multi_quiz_entrances',
      _estimateQuizEntrances = 'estimate_quiz_entrances'
      //
      ;
}
