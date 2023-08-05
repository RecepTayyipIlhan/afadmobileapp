import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../features/app_init/app_init_prov.dart';
import '../utils/utils.dart';

final fbAnalyticsProv = Provider(AnalyticsService.new);

final _analyticsProv = Provider(
  (_) => FirebaseAnalytics.instance,
);

final _setAnalyticsConsentProv = StateProvider.autoDispose<bool>(
  (_) => false,
);

class AnalyticsService {
  final Ref _ref;

  String sessionId;

  AnalyticsService(this._ref) : sessionId = const Uuid().v4();

  FirebaseAnalytics get _analytics => _ref.read(_analyticsProv);

  Future<String> _logEvent(
    String name, {
    Map<String, Object?>? parameters,
  }) async {
    try {
      final settings = _ref.watch(appSettingsProv);
      final isTrackingAllowed = settings?.userTrackingStatus.isApproved;

      if (isTrackingAllowed != true) {
        if (_ref.read(_setAnalyticsConsentProv) != true) {
          _analytics.setConsent(
            adStorageConsentGranted: false,
            analyticsStorageConsentGranted: false,
          );

          _ref.read(_setAnalyticsConsentProv.notifier).state = true;
        }

        return 'no tracking allowed';
      }

      await _analytics.logEvent(
        name: name,
        parameters: {
          if (parameters != null)
            ...(parameters.map(
              (key, value) => MapEntry(
                key,
                value.toString(),
              ),
            )),
          'session_id': sessionId,
          'date': DateTime.now().toIso8601String(),
        },
      );

      return '';
    } catch (e) {
      logger.e(e);

      return e.toString();
    }
  }
}

extension CommonEvents on AnalyticsService {
  Future<void> appOpened() async => await _analytics.logEvent(
        name: 'app_opened',
        parameters: {
          'date': DateTime.now().toIso8601String(),
        },
      );
}

extension ButtonEvents on AnalyticsService {
  Future<String> buttonPressed(
    String buttonName,
    String eventName, {
    Map<String, Object?>? parameters,
  }) async {
    final _l = await _logEvent(
      'button_pressed',
      parameters: {
        'button_name': buttonName,
        'event_name': eventName,
        ...(parameters ?? {}),
      },
    );

    return _l;
  }
}

extension QuizEvents on AnalyticsService {
  Future<void> navigateToEstimationQuiz(String? quizId) async =>
      await _logEvent(
        'navigate_to_estimation_quiz',
        parameters: {
          'quiz_id': quizId,
        },
      );
  Future<void> completedEstimationQuiz(String quizId) async => await _logEvent(
        'completed_estimation_quiz',
        parameters: {
          'quiz_id': quizId,
        },
      );
  Future<void> exitedEstimationQuiz(String quizId) async => await _logEvent(
        'exited_estimation_quiz',
        parameters: {
          'quiz_id': quizId,
        },
      );

  Future<void> navigateToMultiQuiz(String? quizId) async => await _logEvent(
        'navigate_to_multi_quiz',
        parameters: {
          'quiz_id': quizId,
        },
      );
  Future<void> completedMultiQuiz(String quizId) async => await _logEvent(
        'completed_multi_quiz',
        parameters: {
          'quiz_id': quizId,
        },
      );
  Future<void> exitedMultiQuiz(String quizId) async => await _logEvent(
        'exited_multi_quiz',
        parameters: {
          'quiz_id': quizId,
        },
      );

  Future<void> tappedOnDisabledQuiz() async =>
      await _logEvent('home:already_entered_quiz_dialog:show');
}
