import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_bloc/common/async_value.dart';
import 'package:test_flutter_bloc/network/random_user_client.dart';
import 'package:test_flutter_bloc/pages/random_user/random_user_event.dart';
import 'package:test_flutter_bloc/pages/random_user/random_user_state.dart';

class RandomUserBloc extends Bloc<RandomUserEvent, RandomUserState> {
  final RandomUserClient _randomUserClient;

  RandomUserBloc({required RandomUserClient randomUserClient})
      : _randomUserClient = randomUserClient,
        super(
          const RandomUserState(
            randomUserModel: AsyncLoading(),
          ),
        ) {
    on<GetRandomUser>((event, emit) async {
      try {
        final randomUserModel = await _randomUserClient.getRandomUserModel();
        emit(
          state.copyWith(
            randomUserModel: AsyncData(randomUserModel),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            randomUserModel: AsyncError(e, StackTrace.current),
          ),
        );
      }
    });
  }
}
