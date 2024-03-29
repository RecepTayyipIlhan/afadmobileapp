import 'app_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_init_state.freezed.dart';

@freezed
class AppInitState with _$AppInitState {
  const factory AppInitState({
    required AppSettings? settings,
    @Default(false) bool isInited,
  }) = _AppInitState;

  factory AppInitState.initial() => const AppInitState(
        settings: null,
      );
}
