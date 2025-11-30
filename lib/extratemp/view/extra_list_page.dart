// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:fem_app/extratemp/model/extra_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:statistics/statistics.dart';

import '../../bloc/main_bloc.dart';
import '../../pedidos/model/pedidos_model.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';

class PedidosExtraPage extends StatefulWidget {
  const PedidosExtraPage({super.key});

  @override
  State<PedidosExtraPage> createState() => _PedidosExtraPageState();
}

class _PedidosExtraPageState extends State<PedidosExtraPage> {
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
        title: const Text('Pedidos Extra Temporales'),
        actions: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.plataforma == null || firstTimeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                String fechaActualizacion =
                    state.plataforma!.plataformaList.first.actualizado;
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
      floatingActionButton: BlocSelector<MainBloc, MainState, Extra?>(
        selector: (state) => state.extra,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahora(
                datos: state.extraListBD,
                nombre: 'Extra',
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
              List<ToCelda> titles = state.extra!.titles;
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
                if (state.extra == null || firstTimeLoading ) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<PedidosSingle> extraList =
                    state.extra!.extraListBD;
                extraList = extraList
                    .where(
                      (e) => e.toList().any(
                            (el) => el.toLowerCase().contains(
                                  filter.toLowerCase(),
                                ),
                          ),
                    )
                    .toList();
                if (extraList.length > endList) {
                  extraList = extraList.sublist(0, endList);
                }
                return SingleChildScrollView(
                  controller: _controller,
                  child: SelectableRegion(
                    focusNode: FocusNode(),
                    selectionControls: emptyTextSelectionControls,
                    child: Column(
                      children: [
                        for (PedidosSingle extra in extraList)
                          Builder(builder: (context) {
                            return Row(
                              children: [
                                for (ToCelda celda in extra.celdasToExtra)
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
