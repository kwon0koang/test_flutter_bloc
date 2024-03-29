import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_flutter_bloc/model/random_user_model.dart';

part 'random_user_state.freezed.dart';

@freezed
class RandomUserState with _$RandomUserState {
  const factory RandomUserState({
    required RandomUserModel randomUserModel,
  }) = _RandomUserState;
}
