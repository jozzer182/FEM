import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:statistics/statistics.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

import '../../../bloc/main_bloc.dart';
import '../../../resources/colorModifier.dart';
import '../../main/ficha/model/ficha_model.dart';
import '../model/ficha__resumen_model.dart';

class FichaResumenPage extends StatefulWidget {
  const FichaResumenPage({Key? key}) : super(key: key);

  @override
  State<FichaResumenPage> createState() => _FichaResumenPageState();
}

class _FichaResumenPageState extends State<FichaResumenPage> {
  final uSFormat = NumberFormat.currency(
    locale: "en_US",
    symbol: "\$",
    decimalDigits: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(20),
        BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            Ficha ficha = state.ficha!;
            FResumen resumen = ficha.resumen;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Budget Total',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${uSFormat.format(resumen.budgetTotal / 1000000)} MCOP',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Budget Material',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${uSFormat.format(resumen.budgetMaterial / 1000000)} MCOP',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Oficial',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: darkenColor(
                                Theme.of(context).colorScheme.primary, 0.5),
                          ),
                    ),
                    Text(
                      '${uSFormat.format(resumen.totalof / 1000000)}MCOP',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: darkenColor(
                                Theme.of(context).colorScheme.primary, 0.5),
                          ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Ficha',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      '${uSFormat.format(resumen.total / 1000000)} MCOP',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Pedidos',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    Text(
                      '${uSFormat.format(resumen.totalped / 1000000)} MCOP',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.ficha == null ||
                    state.ficha!.resumen.budgetTotal == 0) {
                  return const SizedBox();
                }
                Ficha ficha = state.ficha!;
                FResumen resumen = ficha.resumen;
                int gapMaterial = resumen.budgetMaterial - resumen.total;
                int gapTotal = resumen.budgetTotal - resumen.budgetMaterial;
                return SizedBox(
                  height: 200,
                  width: 200,
                  child: PieChart(
                    PieChartData(
                      startDegreeOffset: 270,
                      sections: [
                        PieChartSectionData(
                          value: resumen.total.toDouble(),
                          color: Theme.of(context).colorScheme.primary,
                          title:
                              'Planificado\n${(100 * resumen.total / resumen.budgetTotal).toStringAsFixed(0)}%',
                          // titlePositionPercentageOffset: 10.0,
                          titleStyle: DefaultTextStyle.of(context)
                              .style
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 10,
                                // fontWeight: FontWeight.bold,
                              ),
                        ),
                        gapMaterial > 0
                            ? PieChartSectionData(
                                value: gapMaterial.toDouble(),
                                color: lightenColor(
                                    Theme.of(context).colorScheme.primary, 0.5),
                                title:
                                    'Restante\n${(100 * gapMaterial / resumen.budgetTotal).toStringAsFixed(0)}%',
                                titleStyle:
                                    DefaultTextStyle.of(context).style.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 10,
                                          // fontWeight: FontWeight.bold,
                                        ),
                              )
                            : PieChartSectionData(
                                value: 0,
                                color: Theme.of(context).colorScheme.secondary,
                                title: '',
                                titleStyle:
                                    DefaultTextStyle.of(context).style.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 10,
                                          // fontWeight: FontWeight.bold,
                                        ),
                              ),
                        PieChartSectionData(
                          value: gapMaterial > 0
                              ? gapTotal.toDouble()
                              : (resumen.budgetTotal - ficha.resumen.total)
                                  .toDouble(),
                          color: Colors.grey[200],
                          title: 'Budget',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Gap(20),
            SizedBox(
              height: 200,
              width: 600,
              child: BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  if (state.ficha == null) {
                    return const SizedBox();
                  }
                  Ficha ficha = state.ficha!;
                  FResumen resumen = ficha.resumen;
                  // print('ficha.tmofmax ${ficha.tmofmax}');
                  // print('ficha.tmax ${ficha.tmax}');
                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: [resumen.tmax, resumen.tmofmax]
                              .statistics
                              .max
                              .toDouble() +
                          10,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            String month = '';
                            if (group.x.toInt() == 1) month = 'Enero';
                            if (group.x.toInt() == 2) month = 'Febrero';
                            if (group.x.toInt() == 3) month = 'Marzo';
                            if (group.x.toInt() == 4) month = 'Abril';
                            if (group.x.toInt() == 5) month = 'Mayo';
                            if (group.x.toInt() == 6) month = 'Junio';
                            if (group.x.toInt() == 7) month = 'Julio';
                            if (group.x.toInt() == 8) month = 'Agosto';
                            if (group.x.toInt() == 9) month = 'Septiembre';
                            if (group.x.toInt() == 10) month = 'Octubre';
                            if (group.x.toInt() == 11) month = 'Noviembre';
                            if (group.x.toInt() == 12) month = 'Diciembre';
                            String title = '';
                            if (rodIndex == 0) title = 'Oficial';
                            if (rodIndex == 1) title = 'Ficha';
                            if (rodIndex == 2) title = 'Pedido';
                            return BarTooltipItem(
                              '$title\n$month\n${uSFormat.format(rod.toY)}',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm01of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm01.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm01ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm02of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm02.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm02ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm03of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm03.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm03ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm04of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm04.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm04ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 5,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm05of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm05.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm05ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 6,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm06of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm06.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm06ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 7,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm07of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm07.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm07ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 8,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm08of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm08.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm08ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 9,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm09of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm09.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm09ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 10,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm10of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm10.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm10ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 11,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm11of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm11.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm11ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 12,
                          barRods: [
                            BarChartRodData(
                              toY: resumen.tm12of.toDouble(),
                              color: darkenColor(
                                  Theme.of(context).colorScheme.primary, 0.5),
                            ),
                            BarChartRodData(
                              toY: resumen.tm12.toDouble(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            BarChartRodData(
                              toY: resumen.tm12ped.toDouble(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const Gap(20),
        BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            Ficha ficha = state.ficha!;
            FResumen resumen = ficha.resumen;
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      'Asertividad Neta',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: darkenColor(
                                Theme.of(context).colorScheme.primary, 0.5),
                          ),
                    ),
                    AnimatedRadialGauge(
                      /// The animation duration.
                      duration: Duration(seconds: 1),
                      curve: Curves.elasticOut,

                      /// Define the radius.
                      /// If you omit this value, the parent size will be used, if possible.
                      radius: 100,

                      /// Gauge value.
                      value: resumen.totalped / resumen.total * 99.9,

                      /// Optionally, you can configure your gauge, providing additional
                      /// styles and transformers.
                      axis: GaugeAxis(
                        /// Provide the [min] and [max] value for the [value] argument.
                        min: 0,
                        max: 100,

                        /// Render the gauge as a 180-degree arc.
                        degrees: 180,

                        /// Set the background color and axis thickness.
                        style: GaugeAxisStyle(
                          thickness: 20,
                          background: Color(0xFFDFE2EC),
                          segmentSpacing: 4,
                        ),

                        // / Define the pointer that will indicate the progress (optional).
                        pointer: GaugePointer.needle(
                          width: 16,
                          height: 100,
                          color: Color(0xFF193663),
                          // size: Size(16, 100),
                          borderRadius: 16,
                          // backgroundColor: Color(0xFF193663),
                        ),

                        // / Define the progress bar (optional).
                        progressBar: GaugeProgressBar.rounded(
                          color: Colors.transparent,
                        ),
                        segments: [
                          GaugeSegment(
                            from: 0,
                            to: 33.3,
                            color: Colors.red,
                            cornerRadius: Radius.zero,
                          ),
                          GaugeSegment(
                            from: 33.3,
                            to: 66.6,
                            color: Colors.orange,
                            cornerRadius: Radius.zero,
                          ),
                          GaugeSegment(
                            from: 66.6,
                            to: 100,
                            color: Colors.green,
                            cornerRadius: Radius.zero,
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Text(
                      '${(resumen.totalped / resumen.total * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: darkenColor(
                                Theme.of(context).colorScheme.primary, 0.5),
                          ),
                    ),
                    const Text(
                      'Pedidos / Ficha',
                      style:  TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '${uSFormat.format(resumen.totalped / 1000000)} MCOP / ${uSFormat.format(resumen.total / 1000000)} MCOP',
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const Gap(100),
              ],
            );
          },
        ),
      ],
    );
  }
}
