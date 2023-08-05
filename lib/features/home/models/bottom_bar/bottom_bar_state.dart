import 'package:freezed_annotation/freezed_annotation.dart';

import 'bottom_bar_index.dart';

part 'bottom_bar_state.freezed.dart';

@freezed
class BottomBarState with _$BottomBarState {
  const BottomBarState._();

  factory BottomBarState({
    required BottomBarIndex bottomBarIndex,
  }) = _BottomBarState;

  factory BottomBarState.initial() => BottomBarState(
        bottomBarIndex: BottomBarIndex.home,
      );
}
