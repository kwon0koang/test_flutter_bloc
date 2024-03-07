import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bloc/pages/chart/line_chart_sample2.dart';
import 'package:test_flutter_bloc/pages/chart/pie_chart_sample2.dart';

@RoutePage()
class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LineChartSample2(),
            const PieChartSample2(),
          ],
        ),
      ),
    );
  }
}
