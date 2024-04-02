import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_flutter_bloc/app_router.dart';
import 'package:test_flutter_bloc/common/enums.dart';
import 'package:test_flutter_bloc/common/log.dart';
import 'package:test_flutter_bloc/const/gaps.dart';
import 'package:test_flutter_bloc/network/random_user_client.dart';
import 'package:test_flutter_bloc/pages/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:test_flutter_bloc/pages/bottom_navigation/bottom_navigation_event.dart';
import 'package:test_flutter_bloc/pages/bottom_navigation/bottom_navigation_state.dart';

@RoutePage()
class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = context.read<Dio>();
    final randomUserClient = RandomUserClient(dio);
    return BlocProvider(
      create: (_) => BottomNavigationBloc(randomUserClient: randomUserClient),
      child: const _BottomNavigationView(),
    );
  }
}

class _BottomNavigationView extends HookWidget {
  const _BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _BodyWidget(),
      bottomNavigationBar: const _BottomNavWidget(),
    );
  }
}

class _BottomNavWidget extends StatelessWidget {
  const _BottomNavWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BottomNavigationBloc, BottomNavigationState,
        BottomNavigationMenuType>(
      selector: (state) => state.menuType,
      builder: (context, state) => BottomNavigationBar(
        items: BottomNavigationMenuType.values
            .map(
              (e) => BottomNavigationBarItem(
                icon: e.icon,
                label: e.label,
              ),
            )
            .toList(),
        currentIndex: state.index,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          context.read<BottomNavigationBloc>().add(
              UpdateMenuType(menuType: BottomNavigationMenuType.values[index]));
        },
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BottomNavigationBloc, BottomNavigationState,
        BottomNavigationMenuType>(
      selector: (state) => state.menuType,
      builder: (context, state) => IndexedStack(
        index: state.index,
        children: const [
          _HomeWidget(),
          _SearchWidget(),
          _MenuWidget(),
        ],
      ),
    );
  }
}

class _HomeWidget extends StatelessWidget {
  const _HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Log.d('_HomeWidget build');
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.router.push(
            const RandomUserRoute(),
          ),
          child: const Text('Route'),
        ),
        gapW5,
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              child: TextField(
                  controller: TextEditingController(text: '1-$index')),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Log.d('_SearchWidget build');
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.router.push(
            const RandomUserRoute(),
          ),
          child: const Text('Route'),
        ),
        gapW5,
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              child: TextField(
                  controller: TextEditingController(text: '2-$index')),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuWidget extends StatelessWidget {
  const _MenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Log.d('_MenuWidget build');
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.router.push(
            const RandomUserRoute(),
          ),
          child: const Text('Route'),
        ),
        gapW5,
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              child: TextField(
                  controller: TextEditingController(text: '3-$index')),
            ),
          ),
        ),
      ],
    );
  }
}
