import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bloc/common/log.dart';

class LineChartSample2 extends StatelessWidget {
  LineChartSample2({super.key});

  final List<Color> gradientColors = [
    Colors.red,
    Colors.lime,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: AspectRatio(
        aspectRatio: 1.70,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 18,
            left: 12,
            top: 24,
            bottom: 12,
          ),
          child: LineChart(
            mainData(),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0', style: style);
        break;
      case 50:
        text = const Text('50', style: style);
        break;
      case 100:
        text = const Text('100', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 5:
        text = '5';
        break;
      case 10:
        text = '10';
        break;
      default:
        return Container();
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.left,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        checkToShowHorizontalLine: (double value) {
          return value == 3 || value == 4 || value == 5 || value == 9;
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.orange,
            dashArray: [5, 10],
            strokeWidth: 3,
          );
        },
        // getDrawingVerticalLine: (value) {
        //   return const FlLine(
        //     color: Colors.purple,
        //     strokeWidth: 1,
        //   );
        // },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
//       extraLinesData: ExtraLinesData(
// //         extraLinesOnTop: true,
//         horizontalLines: [
//           HorizontalLine(
//             y: 5,
//             color: Colors.orange,
//             strokeWidth: 2,
//             dashArray: [5, 10],
//             label: HorizontalLineLabel(
//               show: true,
//               alignment: Alignment.topRight,
//               padding: const EdgeInsets.only(right: 5, bottom: 5),
//               style: const TextStyle(
//                 fontSize: 9,
//                 fontWeight: FontWeight.bold,
//               ),
//               // labelResolver: (line) => 'H: ${line.y}',
//             ),
//           ),
//         ],
//       ),
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        // getTouchLineStart: (LineChartBarData barData, int spotIndex) {
        //   return barData.spots[spotIndex].y;
        // },
        // getTouchLineEnd: (LineChartBarData barData, int spotIndex) {
        //   return 0;
        // },
        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
          if (response == null || response.lineBarSpots == null) {
            return;
          }

          if (response.lineBarSpots?[0].y == 9) {
            Log.d(
                'event : $event / response.lineBarSpots?[0].y : ${response.lineBarSpots?[0].y}');
          }

          if (event is FlPointerHoverEvent) {}
          if (event is FlTapUpEvent) {
            // final spotIndex = response.lineBarSpots!.first.spotIndex;
            // setState(() {
            //   if (showingTooltipOnSpots.contains(spotIndex)) {
            //     showingTooltipOnSpots.remove(spotIndex);
            //   } else {
            //     showingTooltipOnSpots.add(spotIndex);
            //   }
            // });
          }
        },
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map(
            (spotIndex) {
              return TouchedSpotIndicatorData(
                const FlLine(
                  color: Colors.green,
                  strokeWidth: 5,
                  dashArray: [5, 10],
                ),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 8,
                    color: Colors.purple,
                  ),
                ),
              );
            },
          ).toList();
        },
        touchTooltipData: const LineTouchTooltipData(
          tooltipBgColor: Colors.orange, //.withOpacity(0.8),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
          bottom: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
        ),
      ),
      minX: 0,
      maxX: 100,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
            FlSpot(20, 3),
            FlSpot(30, 5),
            FlSpot(40, 9),
            FlSpot(50, 8),
            FlSpot(60, 6),
            FlSpot(70, 3.1),
            FlSpot(80, 4),
            FlSpot(90, 3),
            FlSpot(100, 9.5),
          ],
          isCurved: true,
          // gradient: LinearGradient(
          //   colors: gradientColors,
          // ),
          color: Colors.blue,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            // gradient: LinearGradient(
            //   colors: gradientColors
            //       // .map((color) => color.withOpacity(0.3))
            //       .toList(),
            // ),
            gradient: LinearGradient(
              colors: gradientColors
                  // .map((color) => color.withOpacity(0.3))
                  .toList(),
              stops: const [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
