import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_bloc/model/random_user_model.dart';
import 'package:test_flutter_bloc/network/random_user_client.dart';
import 'package:test_flutter_bloc/pages/random_user/random_user_state.dart';

abstract class RandomUserEvent {}

class GetRandomUser extends RandomUserEvent {}

class RandomUserBloc extends Bloc<RandomUserEvent, RandomUserState> {
  final RandomUserClient _randomUserClient;

  RandomUserBloc({required RandomUserClient randomUserClient})
      : _randomUserClient = randomUserClient,
        super(
          const RandomUserState(
            randomUserModel: RandomUserModel(
              results: [],
              info: Info(seed: '', results: 0, page: 0, version: ''),
            ),
          ),
        ) {
    on<GetRandomUser>((event, emit) async {
      final randomUserModel = await _randomUserClient.getRandomUserModel();
      emit(
        state.copyWith(
          randomUserModel: randomUserModel,
        ),
      );
    });
  }
}
