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
    required Name name,
    required String email,
    // required Login login,
    required String phone,
    required String cell,
    // required Id id,
    required Picture picture,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
class Name with _$Name {
  const factory Name({
    required String title,
    required String first,
    required String last,
  }) = _Name;

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
}

// @freezed
// class Login with _$Login {
//   const factory Login({
//     required String uuid,
//     required String username,
//     required String password,
//     required String salt,
//     required String md5,
//     required String sha1,
//     required String sha256,
//   }) = _Login;

//   factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
// }

// @freezed
// class Id with _$Id {
//   const factory Id({
//     required String name,
//     required String value,
//   }) = _Id;

//   factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);
// }

@freezed
class Picture with _$Picture {
  const factory Picture({
    required String large,
    required String medium,
    required String thumbnail,
  }) = _Picture;

  factory Picture.fromJson(Map<String, dynamic> json) =>
      _$PictureFromJson(json);
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
