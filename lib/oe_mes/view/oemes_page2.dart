// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:fem_app/oe/model/oe_model.dart';
import 'package:get/get.dart';
import 'package:statistics/statistics.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transition;

import '../../../bloc/main_bloc.dart';
import '../../../resources/descarga_hojas.dart';
import '../../../resources/titulo.dart';
import '../../oe/view/oe_page.dart';

class OeMesPage2 extends StatefulWidget {
  final String? filtroInicial;
  const OeMesPage2({
    this.filtroInicial,
    super.key,
  });

  @override
  State<OeMesPage2> createState() => _OeMesPage2State();
}

class _OeMesPage2State extends State<OeMesPage2> {
  String filter = '';
  int endList = 70;
  bool firstTimeLoading = true;
  final ScrollController _controller = ScrollController();
  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        endList += 70;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        firstTimeLoading = false;
      });
    });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Órdenes de Entrega por Mes'),
        actions: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.oe == null || firstTimeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                String fechaActualizacion = state.oe!.oeList.first.actualizado;
                DateTime fecha = DateTime.parse(fechaActualizacion);
                return Center(
                  child: Text(
                    'Actualizado:' +
                        '\n${fecha.day.toStringPadded(2)}/${fecha.month.toStringPadded(2)}/${fecha.year}' +
                        '\n${fecha.hour.toStringPadded(2)}:${fecha.minute.toStringPadded(2)}',
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
          ),
          const Gap(5),
        ],
      ),
      floatingActionButton: BlocSelector<MainBloc, MainState, Oe?>(
        selector: (state) => state.oe,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahora(
                datos: state.oeList,
                nombre: 'Ordenes de entrega',
              ),
              child: const Icon(Icons.download),
            );
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
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
              List<ToCelda> titles = [
                for (var i = 0; i < state.oeMes?.keys.length - 1; i++)
                  ToCelda(
                    valor: state.oeMes!.keys[i]
                        .replaceAll('a', '-')
                        .replaceAll('m', ''),
                    flex: state.oeMes!.flex[i],
                  ),
              ];
              titles[0].valor = 'E4e';
              titles[1].valor = 'Descripción';
              return Row(
                children: [
                  for (ToCelda celda in titles)
                    Expanded(
                      flex: celda.flex,
                      child: Text(
                        celda.valor,
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
          Expanded(
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.oe == null || firstTimeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Map<dynamic, dynamic>> oeMesList = state.oeMes!.oeMesList;
                oeMesList = oeMesList
                    .where((element) => element.values.any((item) => item
                        .toString()
                        .toLowerCase()
                        .contains(filter.toLowerCase())))
                    .toList();
                if (oeMesList.length > endList) {
                  oeMesList = oeMesList.sublist(0, endList);
                }
                List<int> flex = state.oeMes?.flex ?? [];
                List keys = state.oeMes?.keys ?? [];
                return SingleChildScrollView(
                  controller: _controller,
                  child: SelectableRegion(
                    focusNode: FocusNode(),
                    selectionControls: emptyTextSelectionControls,
                    child: Column(
                      children: [
                        for (Map<dynamic, dynamic> oe in oeMesList)
                          Builder(builder: (context) {
                            List<ToCelda> oeAsList = [
                              for (var i = 0; i < keys.length - 1; i++)
                                ToCelda(
                                    valor: oe[keys[i]].toString(),
                                    flex: flex[i])
                            ];
                            return InkWell(
                              onDoubleTap: () {
                                Get.to(
                                  OePage(filtroInicial: oeAsList[0].valor),
                                  transition: transition.Transition.rightToLeft,
                                );
                              },
                              child: Row(
                                children: [
                                  for (ToCelda celda in oeAsList)
                                    Expanded(
                                      flex: celda.flex,
                                      child: Text(
                                        celda.valor,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
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
