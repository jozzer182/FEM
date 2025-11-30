import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../fem/model/fem_model_single_fem.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/transicion_pagina.dart';

class BusquedaFichasE4ePage extends StatefulWidget {
  const BusquedaFichasE4ePage({super.key});

  @override
  State<BusquedaFichasE4ePage> createState() => _BusquedaFichasE4ePageState();
}

class _BusquedaFichasE4ePageState extends State<BusquedaFichasE4ePage> {
  String year = '2025';
  String filter = '';
  int endList = 70;
  bool group = false;
  final ScrollController _controller = ScrollController();
  List<SingleFEM> femList = [];
  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        endList += 70;
      });
      print('endList: $endList');
    }
  }

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void goTo(Widget page) => Navigator.push(context, createRoute(page));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busqueda en fichas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => DescargaHojas().ahoraMap(
          datos: femList.map((e) => e.mapDownloadForecast).toList(),
          nombre: 'Pedidos',
        ),
        child: const Icon(Icons.download),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: year,
                    onChanged: (String? newValue) {
                      setState(() {
                        year = newValue!;
                      });
                    },
                    items: <String>[
                      '2023',
                      '2024',
                      '2025',
                      '2026',
                      '2027',
                      '2028'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Año',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Gap(5),
                BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (state.fem != null) {
                              if (year == '2023') {
                                femList = state.fem?.f2023 ?? [];
                              }
                              if (year == '2024') {
                                femList = state.fem?.f2024 ?? [];
                              }
                              if (year == '2025') {
                                femList = state.fem?.f2025 ?? [];
                              }
                              if (year == '2026') {
                                femList = state.fem?.f2026 ?? [];
                              }
                              if (year == '2027') {
                                femList = state.fem?.f2027 ?? [];
                              }
                              if (year == '2028') {
                                femList = state.fem?.f2028 ?? [];
                              }
                            }
                          });
                        },
                        child: const Text('Calcular'),
                      ),
                    );
                  },
                ),
                const Gap(5),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        group = !group;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: group ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text('Agrupar\nProyecto'),
                  ),
                ),
                const Gap(5),
                Expanded(
                  flex: 3,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Búsqueda',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(5),
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return Row(
                children: [
                  for (String key in state.fem!.mapToBusquedaE4e.keys)
                    Expanded(
                      flex: state.fem!.mapToBusquedaE4e[key][0],
                      child: Text(
                        state.fem!.mapToBusquedaE4e[key][1],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const Gap(5),
          // Text('data'),
          Expanded(
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.fem == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (femList.isEmpty) {
                  return const Column(children: [
                    Text(
                        'No hay resultados, pruebe una nueva busqueda o de clic en el botón calcular.'),
                  ]);
                }
                List<SingleFEM> femListFilter = [];
                femListFilter = femList
                    .where(
                      (e) => e.toList().any(
                            (el) => el.toLowerCase().contains(
                                  filter.toLowerCase(),
                                ),
                          ),
                    )
                    .toList();
                List<SingleFEM> femListTrim = [];
                Map femByProy = {};
                if (group) {
                  for (SingleFEM reg in femListFilter) {
                    if (femByProy['${reg.e4e}${reg.proyecto}'] == null) {
                      femByProy['${reg.e4e}${reg.proyecto}'] = {
                        'proyecto': reg.proyecto,
                        'e4e': reg.e4e,
                        'descripcion': reg.descripcion,
                        'um': reg.um,
                        '01': 0,
                        '02': 0,
                        '03': 0,
                        '04': 0,
                        '05': 0,
                        '06': 0,
                        '07': 0,
                        '08': 0,
                        '09': 0,
                        '10': 0,
                        '11': 0,
                        '12': 0,
                      };
                    }
                    femByProy['${reg.e4e}${reg.proyecto}']['01'] += reg.m01;
                    femByProy['${reg.e4e}${reg.proyecto}']['02'] += reg.m02;
                    femByProy['${reg.e4e}${reg.proyecto}']['03'] += reg.m03;
                    femByProy['${reg.e4e}${reg.proyecto}']['04'] += reg.m04;
                    femByProy['${reg.e4e}${reg.proyecto}']['05'] += reg.m05;
                    femByProy['${reg.e4e}${reg.proyecto}']['06'] += reg.m06;
                    femByProy['${reg.e4e}${reg.proyecto}']['07'] += reg.m07;
                    femByProy['${reg.e4e}${reg.proyecto}']['08'] += reg.m08;
                    femByProy['${reg.e4e}${reg.proyecto}']['09'] += reg.m09;
                    femByProy['${reg.e4e}${reg.proyecto}']['10'] += reg.m10;
                    femByProy['${reg.e4e}${reg.proyecto}']['11'] += reg.m11;
                    femByProy['${reg.e4e}${reg.proyecto}']['12'] += reg.m12;
                  }
                  for (String key in femByProy.keys) {
                    femListTrim.add(
                      SingleFEM.fromFemByProy(
                        femByProy[key],
                      ),
                    );
                  }
                } else{
                  femListTrim = femListFilter;
                }

                if (femListTrim.length > endList) {
                  femListTrim = femListTrim.sublist(0, endList);
                }
                return SingleChildScrollView(
                  controller: _controller,
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableRegion(
                    focusNode: FocusNode(),
                    selectionControls: emptyTextSelectionControls,
                    child: Column(
                      children: [
                        for (SingleFEM fem in femListTrim)
                          Builder(builder: (context) {
                            // print(toNum(pedido.pedido));
                            return Row(
                              key: UniqueKey(),
                              children: [
                                for (String key in fem.mapToTitlesForecast.keys)
                                  Expanded(
                                    flex: fem.mapToTitlesForecast[key]![0],
                                    child: Text(
                                      fem.mapToTitlesForecast[key]![1].toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
