import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:test_flutter_bloc/model/random_user_model.dart';

part 'random_user_client.g.dart';

@RestApi(baseUrl: 'http://randomuser.me/')
abstract class RandomUserClient {
  factory RandomUserClient(Dio dio, {String baseUrl}) = _RandomUserClient;

  // @GET('api')
  @GET('api/?results=100')
  Future<RandomUserModel> getRandomUserModel();
}
