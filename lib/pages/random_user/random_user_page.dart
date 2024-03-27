import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test_flutter_bloc/model/random_user_model.dart';
import 'package:test_flutter_bloc/network/random_user_client.dart';
import 'package:test_flutter_bloc/pages/random_user/random_user_bloc.dart';
import 'package:test_flutter_bloc/pages/random_user/random_user_state.dart';

@RoutePage()
class RandomUserPage extends StatelessWidget {
  const RandomUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dio, RandomUserClient는 추후 위치 변경할 것
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    final randomUserClient = RandomUserClient(dio);

    return BlocProvider(
      create: (_) => RandomUserBloc(randomUserClient: randomUserClient),
      child: const RandomUserView(),
    );
  }
}

class RandomUserView extends StatelessWidget {
  const RandomUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocSelector<RandomUserBloc, RandomUserState, RandomUserModel>(
          selector: (state) => state.randomUserModel,
          builder: (context, randomUserModel) {
            return Text(
              '${randomUserModel.results.length}',
              style: Theme.of(context).textTheme.displayLarge,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          context.read<RandomUserBloc>().add(GetRandomUser());
        },
      ),
    );
  }
}
