import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:fem_app/codigoshabilitados/model/codigoshabilitados_model.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';
import '../../resources/transicion_pagina.dart';

class CodigosHabilitadosPage extends StatefulWidget {
  const CodigosHabilitadosPage({super.key});

  @override
  State<CodigosHabilitadosPage> createState() => _CodigosHabilitadosPageState();
}

class _CodigosHabilitadosPageState extends State<CodigosHabilitadosPage> {
  String filter = '';
  int endList = 70;
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
        title: const Text('Códigos Habilitados'),
      ),
      floatingActionButton:
          BlocSelector<MainBloc, MainState, CodigosHabilitados?>(
        selector: (state) => state.codigosHabilitados,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahoraMap(
                datos: state.codigoshabilitados.map((e) => e.toMap()).toList(),
                nombre: 'Códigos Habilitados',
              ),
              child: const Icon(Icons.download),
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Son la combinación de los códigos oficiales y los códigos adicionales, son los codigos habilitados para incluir en las fichas de materiales.' ,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const Gap(10),
            Row(
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
            const Gap(5),
            BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                return Row(
                  children: [
                    for (ToCelda celda in state.codigosHabilitados!.celdas)
                      Expanded(
                        key: UniqueKey(),
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
                  if (state.codigosHabilitados == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<CodigoHabilitado> codigosHabilitados =
                      state.codigosHabilitados!.codigoshabilitados;
                  codigosHabilitados = codigosHabilitados
                      .where(
                        (e) => e.toList().any(
                              (el) => el.toLowerCase().contains(
                                    filter.toLowerCase(),
                                  ),
                            ),
                      )
                      .toList();
                  // pedidos.sort((a, b) => toOrderString(b.pedido).compareTo(toOrderString(a.pedido))
                  // );
                  if (codigosHabilitados.length > endList) {
                    codigosHabilitados = codigosHabilitados.sublist(0, endList);
                  }
                  return SingleChildScrollView(
                    controller: _controller,
                    child: SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: emptyTextSelectionControls,
                      child: Column(
                        children: [
                          for (CodigoHabilitado codigoHabilitado in codigosHabilitados)
                            Builder(builder: (context) {
                              // print(toNum(pedido.pedido));
                              return Row(
                                key: UniqueKey(),
                                children: [
                                  for (ToCelda celda in codigoHabilitado.celdas)
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
      ),
    );
  }
}
