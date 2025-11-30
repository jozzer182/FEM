import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class LineChartDisponibilidad extends StatefulWidget {
  const LineChartDisponibilidad({
    super.key,
    required this.spots,
    Color? indicatorStrokeColor,
  }) : indicatorStrokeColor = indicatorStrokeColor ?? AppColors.mainTextColor1;
  final List<List<int>> spots;
  final Color indicatorStrokeColor;

  @override
  State<LineChartDisponibilidad> createState() =>
      _LineChartDisponibilidadState();
}

class _LineChartDisponibilidadState extends State<LineChartDisponibilidad> {
  List<int> showingTooltipOnSpots = [8];

  List<FlSpot> disponibilidad = [];
  List<FlSpot> oferta = [];
  List<FlSpot> demanda = [];

  int mesFinDisponibilidad = 15;
  @override
  void initState() {
    for (List<int> spot in widget.spots) {
      if (spot[0] < 2) {
        disponibilidad.add(FlSpot.nullSpot);
        // oferta.add(FlSpot.nullSpot);
        // demanda.add(FlSpot.nullSpot);
      }
      disponibilidad.add(FlSpot(spot[0].toDouble(), spot[10].toDouble()));
      oferta.add(FlSpot(spot[0].toDouble(), spot[9].toDouble()));
      demanda.add(FlSpot(spot[0].toDouble(), spot[6].toDouble()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> lineBarsData = [
      LineChartBarData(
        preventCurveOverShooting: true,
        showingIndicators: showingTooltipOnSpots,
        spots: disponibilidad,
        color: Colors.pink,
        isCurved: true,
        barWidth: 2,
        dotData: const FlDotData(show: false),
      ),
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: oferta,
        color: Colors.orange,
        // isCurved: true,
        barWidth: 2,
        dotData: const FlDotData(show: false),
        isStepLineChart: true,
        belowBarData: BarAreaData(
          show: true,
          color: Colors.orange.withOpacity(0.3),
          applyCutOffY: true,
        ),
      ),
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        preventCurveOverShooting: true,
        spots: demanda,
        color: Colors.blue,
        isCurved: true,
        barWidth: 2,
        dotData: const FlDotData(show: false),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineBarsData: lineBarsData,
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  fitInsideVertically: true,
                  tooltipBgColor: Colors.grey[100]!,
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {
                      FlSpot flSpot =
                          touchedSpot.bar.spots[touchedSpot.spotIndex];
                      LineChartBarData barData = touchedSpot.bar;
                      int index = lineBarsData.map((e) => e.color).toList().indexOf(barData.color);
                      // if (flSpot.x < 3) return null;
                      List<String> titles = ['Disp: ', 'Oferta: ', 'Demanda: '];
                      String title = '';
                      if (index != -1) {
                        title = titles[index];
                      }
                      return LineTooltipItem(
                        "$title${flSpot.y.toStringAsFixed(0)}",
                        TextStyle(
                          color: touchedSpot.bar.color,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              // minY: -200,
              titlesData: FlTitlesData(
                // leftTitles: const AxisTitles(
                //   sideTitles: SideTitles(showTitles: true),
                // ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 2,
                          child: RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                '${widget.spots[value.toInt()][1].toString().padLeft(2, '0')}/${widget.spots[value.toInt()][2].toString().substring(2, 4)}',
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              )));
                    },
                    reservedSize: 30,
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: const FlGridData(show: true),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black),
              ),
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: 0,
                    color: Colors.black,
                    strokeWidth: 2,
                    dashArray: [5, 5],
                  ),
                ],
              ),
              rangeAnnotations: RangeAnnotations(
                verticalRangeAnnotations: [
                  VerticalRangeAnnotation(
                    x1: 0,
                    x2: DateTime.now().month - 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  VerticalRangeAnnotation(
                    x1: 0,
                    x2: mesFinDisponibilidad.toDouble(), 
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
