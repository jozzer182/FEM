import 'package:fem_app/plataforma_mb51/controller/plataforma_mb51_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/main_bloc.dart';
import '../../disponibilidad/controller/disponibilidad_controller.dart';
import '../../disponibilidad/model/disponibilidad_ano_list.dart';
import '../../disponibilidad/model/disponibilidad_model.dart';
import '../../fem/model/fem_model_single_fem.dart';
import '../../nuevo/model/nuevo_model.dart';
import '../../resources/a_entero_2.dart';
import '../../resources/color_hsl.dart';
import '../../resources/legend_widget.dart';
import '../../resources/numero_precio.dart';
import '../../resources/reduce_to_initials.dart';
import '../../versiones/model/versiones_model_sumsingle.dart';
import 'line_chart_disponibilidad.dart';
import 'line_chart_disponibilidad_por_proyecto.dart';

class DisponibilidadGraficaPage extends StatefulWidget {
  const DisponibilidadGraficaPage({super.key});

  @override
  State<DisponibilidadGraficaPage> createState() =>
      _DisponibilidadGraficaPageState();
}

class _DisponibilidadGraficaPageState extends State<DisponibilidadGraficaPage> {
  String filter = '';
  Map<String, List<int>> femByProy = {};
  bool porProyecto = false;
  DateTime fechaSeleccionada = DateTime(DateTime.now().year + 1, 12, 30);
  @override
  Widget build(BuildContext context) {
    List<Color> colorsProy = generateColors(femByProy.keys.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disponibilidad Gráfica'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Uri url = Uri.parse(
                    'https://lookerstudio.google.com/reporting/9804dafb-214c-4cea-b04e-072708438172/page/RFcgD');
                launchUrl(url);
              },
              child: const Text(
                'Tablero\nLooker',
                textAlign: TextAlign.center,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(10),
              searchField(),
              BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  if (state.disponibilidad == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (filter.length != 6) {
                    return const SizedBox.shrink();
                  }
                  List<DisponibilidadSingle> dispList = state
                      .disponibilidad!.disponibilidadList
                      .where((disponibilidad) =>
                          disponibilidad.e4e.contains(filter))
                      .toList();
                  List<AnoList> anoList = state.disponibilidad!.anoList
                      .where((e) => e.e4e.contains(filter))
                      .toList();
                  if (dispList.isEmpty || anoList.isEmpty) {
                    return const Text('No hay datos para este código');
                  }
                  DisponibilidadSingle disp = dispList.first;
                  AnoList anoListSingle = anoList.first;
                  // print('disp: ${dispMes.toMap()}');
                  // String mesW0 = mes.toString().padLeft(2, "0");
                  int? disponibleMes = anoListSingle.mesList
                      .firstWhere((e) =>
                          e.mes == fechaSeleccionada.month &&
                          e.ano == fechaSeleccionada.year)
                      .proyectado;
                  int precio = aEntero(state.mm60!.mm60List
                      .where((mm60) => mm60.material.contains(filter))
                      .first
                      .precio);
                  bool estaOeDemana = aEntero(disp.fem) +
                          aEntero(disp.otros) +
                          aEntero(disp.oe) >
                      0;
                  // int totalOe = state.analisisCodigo!.totalOe;
                  // int totalFem = state.analisisCodigo!.totalFem;
                  // int totalOraCe = state.analisisCodigo!.totalOraCe;
                  // int cobertura =
                  //     aEntero(disp.plataforma) + totalOe - totalFem - totalOraCe;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Descripción: ${disp.descripcion} - ${disp.um} - Precio: ${uSFormat.format(precio)}',
                        // style: const TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Disponibilidad mes 12/2025: $disponibleMes'),
                          Text('Rotura Stock: ${anoListSingle.roturaStock}'),
                          Text(
                              'Disponibilidad final (${disp.mesFin}): ${disp.total}'),
                          Text('Plataforma hoy: ${disp.plataforma}'),
                        ],
                      ),
                      const Gap(3),
                      estaOeDemana
                          ? const SizedBox.shrink()
                          : Text(
                              'Descripción: ${disp.descripcion} - ${disp.um} - Precio: ${uSFormat.format(precio)}',
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                    ],
                  );
                },
              ),
              const Gap(10),
              LegendsListWidget(
                legends: [
                  Legend('Disponibilidad', Colors.pink),
                  Legend('Oferta', Colors.orange),
                  Legend('Demanda', Colors.blue),
                  if (porProyecto)
                    for (int i = 0; i < femByProy.keys.length; i++)
                      Legend(
                        reduceToInitials(femByProy.keys.toList()[i]),
                        femByProy.keys.toList()[i] == 'O R A'
                            ? Colors.grey[700]!
                            : colorsProy[i],
                      ),
                ],
              ),
              const Gap(10),
              Container(
                height: 500,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: !porProyecto
                    ? BlocBuilder<MainBloc, MainState>(
                        builder: (context, state) {
                          if (state.disponibilidad == null ||
                              state.disponibilidad!.anoList.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          DateTime fechaActual = DateTime.now();
                          fechaActual =
                              DateTime(fechaActual.year, fechaActual.month, 1);
                          int anoActual = fechaActual.year;
                          int anoSiguiente = anoActual + 1;
                          List<String> e4eList = obtenerE4E(
                            years: [anoActual, anoSiguiente],
                            fem: state.fem!,
                            versiones: state.versiones!,
                            plataformaByE4e: state.plataforma!.plataformaByE4e,
                            oeE4eList: state.oe!.e4eList,
                          );
                          if (filter.length != 6 || !e4eList.contains(filter)) {
                            return const Center(
                              child: Text('Ingrese un código E4E válido'),
                            );
                          }
                          List<List<int>> spots = state.disponibilidad!.anoList
                              .firstWhere((e) => e.e4e == filter)
                              .disponibilidadList;
                          // print('obtenerMesesInt: ${obtenerMesesInt}');
                          // print('state.plataformaMb51 ${state.plataformaMb51}');
                          for (int mes in obtenerMesesInt) {
                            // print('mes: $mes');
                            // print(
                            //     'mb51: ${state.plataformaMb51!.meses.firstWhere((e) => e.mes == (mes + 1).toString().padLeft(2, '0')).totalE4e(filter)}');
                            spots[mes - 1][9] = -state.plataformaMb51!.meses
                                    .firstWhere((e) =>
                                        e.mes ==
                                        (mes + 1).toString().padLeft(2, '0'))
                                    .totalE4e(filter) +
                                spots[mes][9];
                          }
                          // print('spots: $spots');

                          return LineChartDisponibilidad(spots: spots);
                        },
                      )
                    :
                    // Text('Por proyecto'),
                    BlocBuilder<MainBloc, MainState>(
                        builder: (context, state) {
                          if (state.disponibilidad == null ||
                              state.disponibilidad!.anoList.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          DateTime fechaActual = DateTime.now();
                          fechaActual =
                              DateTime(fechaActual.year, fechaActual.month, 1);
                          int anoActual = fechaActual.year;
                          int anoSiguiente = anoActual + 1;
                          List<String> e4eList = obtenerE4E(
                            years: [anoActual, anoSiguiente],
                            fem: state.fem!,
                            versiones: state.versiones!,
                            plataformaByE4e: state.plataforma!.plataformaByE4e,
                            oeE4eList: state.oe!.e4eList,
                          );
                          if (filter.length != 6 || !e4eList.contains(filter)) {
                            return const Center(
                              child: Text('Ingrese un código E4E válido'),
                            );
                          }

                          // setState(() {
                          //   femByProy = femByProy;
                          // });
                          colorsProy = generateColors(femByProy.keys.length);
                          // print(femByProy);
                          //agregar el pasado de plataforma
                          List<List<int>> spots = state.disponibilidad!.anoList
                              .firstWhere((e) => e.e4e == filter)
                              .disponibilidadList;
                          // print('obtenerMesesInt: ${obtenerMesesInt}');
                          // print('state.plataformaMb51 ${state.plataformaMb51}');
                          for (int mes in obtenerMesesInt) {
                            // print('mes: $mes');
                            // print(
                            //     'mb51: ${state.plataformaMb51!.meses.firstWhere((e) => e.mes == (mes + 1).toString().padLeft(2, '0')).totalE4e(filter)}');
                            spots[mes - 1][9] = -state.plataformaMb51!.meses
                                    .firstWhere((e) =>
                                        e.mes ==
                                        (mes + 1).toString().padLeft(2, '0'))
                                    .totalE4e(filter) +
                                spots[mes][9];
                          }
                          // print('spots: $spots');

                          return LineChartDisponibilidadProyecto(
                            spots: spots,
                            spotsPorProyecto: femByProy,
                            colors: colorsProy,
                          );
                        },
                      ),
              ),
              const Gap(10),
              if (porProyecto)
                Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'id',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            'Proyecto',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '01/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '02/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '03/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '04/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '05/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '06/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '07/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '08/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '09/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '10/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '11/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '12/24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '01/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '02/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '03/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '04/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '05/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '06/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '07/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '08/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '09/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '10/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '11/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '12/25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Builder(builder: (context) {
                      List<Widget> children = [];
                      for (int index = 0;
                          index < femByProy.keys.length;
                          index++) {
                        String key = femByProy.keys.toList()[index];
                        children.add(
                          Container(
                            color: index.isEven
                                ? Colors.grey[200]
                                : Colors.transparent,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: LegendWidget(
                                      name: reduceToInitials(key),
                                      color: colorsProy[femByProy.keys
                                          .toList()
                                          .indexOf(key)]),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    key,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![0] == 0 ? '' : femByProy[key]![0]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![1] == 0 ? '' : femByProy[key]![1]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![2] == 0 ? '' : femByProy[key]![2]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![3] == 0 ? '' : femByProy[key]![3]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![4] == 0 ? '' : femByProy[key]![4]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![5] == 0 ? '' : femByProy[key]![5]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![6] == 0 ? '' : femByProy[key]![6]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![7] == 0 ? '' : femByProy[key]![7]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![8] == 0 ? '' : femByProy[key]![8]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![9] == 0 ? '' : femByProy[key]![9]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![10] == 0 ? '' : femByProy[key]![10]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![11] == 0 ? '' : femByProy[key]![11]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![12] == 0 ? '' : femByProy[key]![12]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![13] == 0 ? '' : femByProy[key]![13]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![14] == 0 ? '' : femByProy[key]![14]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![15] == 0 ? '' : femByProy[key]![15]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![16] == 0 ? '' : femByProy[key]![16]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![17] == 0 ? '' : femByProy[key]![17]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![18] == 0 ? '' : femByProy[key]![18]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![19] == 0 ? '' : femByProy[key]![19]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![20] == 0 ? '' : femByProy[key]![20]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![21] == 0 ? '' : femByProy[key]![21]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![22] == 0 ? '' : femByProy[key]![22]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${femByProy[key]![23] == 0 ? '' : femByProy[key]![23]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: children,
                      );
                    }),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 300,
                child: BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    return TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Código E4E',
                      ),
                      onChanged: (value) {
                        if (value.length == 6) {
                          femByProy = {};
                          DateTime fechaActual = DateTime.now();
                          fechaActual =
                              DateTime(fechaActual.year, fechaActual.month, 1);
                          int anoActual = fechaActual.year;
                          int anoSiguiente = anoActual + 1;
                          for (int year in [anoActual, anoSiguiente]) {
                            List<SingleFEM> ficha = state.fem!
                                .obtenerAno(year)
                                .where((e) => e.e4e == value && e.total > 0)
                                .toList();
                            List<VersionSumSingle> version = state.versiones!
                                .obtenerAnoSum(year)
                                .where((e) =>
                                    e.e4e == value &&
                                    e.total > 0 &&
                                    !e.unidad.startsWith('PM'))
                                .toList();
                            // print(ficha);
                            Map<int, EnableDateInt> enableDatesInt =
                                state.fechasFEM!.enableDatesInt(year);
                            for (SingleFEM reg in ficha) {
                              List<int> porMes = reg.filtradoFechasFem(
                                  enableDatesInt: enableDatesInt);
                              if (porMes[12] > 0) {
                                if (femByProy[reg.proyecto] == null) {
                                  femByProy[reg.proyecto] = [
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                  ];
                                }

                                if (anoActual == year) {
                                  femByProy[reg.proyecto]![0] += porMes[0];
                                  femByProy[reg.proyecto]![1] += porMes[1];
                                  femByProy[reg.proyecto]![2] += porMes[2];
                                  femByProy[reg.proyecto]![3] += porMes[3];
                                  femByProy[reg.proyecto]![4] += porMes[4];
                                  femByProy[reg.proyecto]![5] += porMes[5];
                                  femByProy[reg.proyecto]![6] += porMes[6];
                                  femByProy[reg.proyecto]![7] += porMes[7];
                                  femByProy[reg.proyecto]![8] += porMes[8];
                                  femByProy[reg.proyecto]![9] += porMes[9];
                                  femByProy[reg.proyecto]![10] += porMes[10];
                                  femByProy[reg.proyecto]![11] += porMes[11];
                                } else {
                                  femByProy[reg.proyecto]![12] += porMes[0];
                                  femByProy[reg.proyecto]![13] += porMes[1];
                                  femByProy[reg.proyecto]![14] += porMes[2];
                                  femByProy[reg.proyecto]![15] += porMes[3];
                                  femByProy[reg.proyecto]![16] += porMes[4];
                                  femByProy[reg.proyecto]![17] += porMes[5];
                                  femByProy[reg.proyecto]![18] += porMes[6];
                                  femByProy[reg.proyecto]![19] += porMes[7];
                                  femByProy[reg.proyecto]![20] += porMes[8];
                                  femByProy[reg.proyecto]![21] += porMes[9];
                                  femByProy[reg.proyecto]![22] += porMes[10];
                                  femByProy[reg.proyecto]![23] += porMes[11];
                                }
                              }
                            }
                            for (VersionSumSingle reg in version) {
                              List<int> porMes = reg.spots;
                              if (porMes[12] > 0) {
                                if (femByProy['O R A'] == null) {
                                  femByProy['O R A'] = [
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                    0,
                                  ];
                                }

                                if (anoActual == year) {
                                  femByProy['O R A']![0] += porMes[0];
                                  femByProy['O R A']![1] += porMes[1];
                                  femByProy['O R A']![2] += porMes[2];
                                  femByProy['O R A']![3] += porMes[3];
                                  femByProy['O R A']![4] += porMes[4];
                                  femByProy['O R A']![5] += porMes[5];
                                  femByProy['O R A']![6] += porMes[6];
                                  femByProy['O R A']![7] += porMes[7];
                                  femByProy['O R A']![8] += porMes[8];
                                  femByProy['O R A']![9] += porMes[9];
                                  femByProy['O R A']![10] += porMes[10];
                                  femByProy['O R A']![11] += porMes[11];
                                } else {
                                  femByProy['O R A']![12] += porMes[0];
                                  femByProy['O R A']![13] += porMes[1];
                                  femByProy['O R A']![14] += porMes[2];
                                  femByProy['O R A']![15] += porMes[3];
                                  femByProy['O R A']![16] += porMes[4];
                                  femByProy['O R A']![17] += porMes[5];
                                  femByProy['O R A']![18] += porMes[6];
                                  femByProy['O R A']![19] += porMes[7];
                                  femByProy['O R A']![20] += porMes[8];
                                  femByProy['O R A']![21] += porMes[9];
                                  femByProy['O R A']![22] += porMes[10];
                                  femByProy['O R A']![23] += porMes[11];
                                }
                              }
                            }
                          }
                          // print(femByProy);
                          setState(() {
                            femByProy = femByProy;
                            filter = value;
                          });
                        } else {
                          setState(() {
                            filter = '';
                          });
                        }
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  const Text('Por proyecto'),
                  Checkbox(
                    value: porProyecto,
                    onChanged: (value) {
                      setState(() {
                        femByProy = femByProy;
                        porProyecto = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(10),
      ],
    );
  }
}

List<MonthYear> monthYearList() {
  List<MonthYear> monthYearList = [];
  int currentYear = DateTime.now().year;

  for (int year = currentYear; year <= currentYear + 1; year++) {
    for (int month = 1; month <= 12; month++) {
      monthYearList.add(MonthYear(month: month, year: year));
    }
  }

  return monthYearList;
}
