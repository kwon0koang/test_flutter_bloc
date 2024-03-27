import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_user_model.freezed.dart';
part 'random_user_model.g.dart';

@freezed
class RandomUserModel with _$RandomUserModel {
  const factory RandomUserModel({
    required List<Result> results,
    required Info info,
  }) = _RandomUserModel;

  factory RandomUserModel.fromJson(Map<String, dynamic> json) =>
      _$RandomUserModelFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    required String gender,
    required String email,
    required String phone,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
class Info with _$Info {
  const factory Info({
    required String seed,
    required int results,
    required int page,
    required String version,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}
