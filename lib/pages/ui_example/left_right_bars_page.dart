import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_bloc/common/log.dart';

@RoutePage()
class LeftRightBarsPage extends StatelessWidget {
  const LeftRightBarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const LeftRightBarsView(),
    );
  }
}

class LeftRightBarsView extends StatelessWidget {
  const LeftRightBarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            return _BarsWidget(
              myLeftRights: _generateRandomMyLeftRightList(10),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'increment',
            child: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementPressed());
            },
          ),
        ],
      ),
    );
  }

  List<_MyLeftRight> _generateRandomMyLeftRightList(int count) {
    List<_MyLeftRight> myList = [];
    Random random = Random();

    for (int i = 0; i < count; i++) {
      double leftValue = random.nextDouble() * 1000;
      double rightValue = random.nextDouble() * 1000;
      myList.add(_MyLeftRight(leftValue, rightValue));
    }

    return myList;
  }
}

class _BarsWidget extends StatelessWidget {
  final List<_MyLeftRight> myLeftRights;

  const _BarsWidget({
    required this.myLeftRights,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = _getDeviceWidth(context);
    final maxBarWidth = deviceWidth / 2 / 2;
    return Container(
      color: Colors.green,
      child: ListView.builder(
        itemCount: myLeftRights.length, // 리스트 아이템 수
        itemBuilder: (BuildContext context, int index) {
          final myLeftRight = myLeftRights[index];
          final left = myLeftRight.left;
          final right = myLeftRight.right;
          final maxLeftRight = _getMaxLeftRight(myLeftRights);

          final calculatedMyLeftRight = _MyLeftRight(
              maxBarWidth * left / maxLeftRight,
              maxBarWidth * right / maxLeftRight);

          Log.d(
              'maxBarWidth : $maxBarWidth / index : $index / myLeftRight.left : ${myLeftRight.left} / myLeftRight.right : ${myLeftRight.right} / calculatedMyLeftRight.left : ${calculatedMyLeftRight.left} / calculatedMyLeftRight.right : ${calculatedMyLeftRight.right}');

          return _BarWidget(myLeftRight: calculatedMyLeftRight);
        },
      ),
    );
  }

  // 기기 넓이 구하기
  _getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // myLeftRights 에 left와 right의 최대값을 구하는 함수
  _getMaxLeftRight(List<_MyLeftRight> myLeftRights) {
    double maxLeftRight = 0;
    for (var item in myLeftRights) {
      if (maxLeftRight < item.left) {
        maxLeftRight = item.left;
      }
      if (maxLeftRight < item.right) {
        maxLeftRight = item.right;
      }
    }
    return maxLeftRight;
  }
}

class _BarWidget extends StatelessWidget {
  final _MyLeftRight myLeftRight;

  const _BarWidget({
    required this.myLeftRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: myLeftRight.left.toDouble(),
                  height: 20,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: myLeftRight.right.toDouble(),
                  height: 20,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MyLeftRight {
  double left;
  double right;

  _MyLeftRight(this.left, this.right);
}

abstract class CounterEvent {}

class CounterIncrementPressed extends CounterEvent {}

class CounterDecrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
    on<CounterDecrementPressed>((event, emit) => emit(state - 1));
  }
}
