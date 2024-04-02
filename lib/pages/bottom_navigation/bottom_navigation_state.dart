import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_flutter_bloc/common/enums.dart';

part 'bottom_navigation_state.freezed.dart';

@freezed
class BottomNavigationState with _$BottomNavigationState {
  const factory BottomNavigationState({
    required BottomNavigationMenuType menuType,
  }) = _BottomNavigationState;
}
