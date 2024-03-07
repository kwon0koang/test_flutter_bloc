import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_bloc/app_router.dart';
import 'package:test_flutter_bloc/const/gaps.dart';
import 'package:test_flutter_bloc/main.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                context.router.push(const CounterRoute());
              },
              child: const Text('Counter with bloc'),
            ),
            gapH4,
            ElevatedButton(
              onPressed: () {
                context.router.push(const CubitCounterRoute());
              },
              child: const Text('Counter with cubit'),
            ),
            gapH4,
            ElevatedButton(
              onPressed: () {
                context.router.push(const LeftRightBarsRoute());
              },
              child: const Text('Left right bars'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'toggleTheme',
        child: const Icon(Icons.brightness_6),
        onPressed: () {
          context.read<ThemeCubit>().toggleTheme();
        },
      ),
    );
  }
}
