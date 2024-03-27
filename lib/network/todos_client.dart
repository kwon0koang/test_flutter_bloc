import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:test_flutter_bloc/model/random_user_model.dart';
import 'package:test_flutter_bloc/model/todo_model.dart';

part 'todos_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class TodosClient {
  factory TodosClient(Dio dio, {String baseUrl}) = _TodosClient;

  // @GET('api/?results=100')
  @GET('todos')
  Future<List<TodoModel>> getTodos();
}
