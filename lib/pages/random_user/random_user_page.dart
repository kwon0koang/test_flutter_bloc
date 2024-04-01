import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:test_flutter_bloc/common/async_value.dart';
import 'package:test_flutter_bloc/model/random_user_model.dart';
import 'package:test_flutter_bloc/network/random_user_client.dart';
import 'package:test_flutter_bloc/pages/random_user/random_user_bloc.dart';
import 'package:test_flutter_bloc/pages/random_user/random_user_event.dart';
import 'package:test_flutter_bloc/pages/random_user/random_user_state.dart';

@RoutePage()
class RandomUserPage extends StatelessWidget {
  const RandomUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = context.read<Dio>();
    final randomUserClient = RandomUserClient(dio);
    return BlocProvider(
      create: (_) => RandomUserBloc(randomUserClient: randomUserClient),
      child: const _RandomUserView(),
    );
  }
}

class _RandomUserView extends StatelessWidget {
  const _RandomUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _RandomUserListWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          context.read<RandomUserBloc>().add(GetRandomUser());
        },
      ),
    );
  }
}

class _RandomUserListWidget extends StatelessWidget {
  const _RandomUserListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () => context.read<RandomUserBloc>().add(GetRandomUser()),
      child: Center(
        child: BlocSelector<RandomUserBloc, RandomUserState,
            AsyncValue<RandomUserModel>>(
          selector: (state) => state.randomUserModel,
          builder: (context, randomUserModel) {
            return randomUserModel.when(
              data: (data) => ListView.builder(
                itemCount: data.results.length,
                itemBuilder: (context, index) {
                  final user = data.results[index];
                  return _buildItem(user, data);
                },
              ),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  ListTile _buildItem(Result user, RandomUserModel data) {
    return ListTile(
      leading: ClipOval(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: user.picture.thumbnail,
          width: 35,
          height: 35,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Text('${user.name.title} ${user.name.first} ${user.name.last}'),
      subtitle: Text(user.email),
    );
  }
}
