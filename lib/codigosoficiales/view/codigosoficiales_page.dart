import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:fem_app/codigosoficiales/model/codigosoficiales_model.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';
import '../../resources/transicion_pagina.dart';

class CodigosOficialesPage extends StatefulWidget {
  const CodigosOficialesPage({super.key});

  @override
  State<CodigosOficialesPage> createState() => _CodigosOficialesPageState();
}

class _CodigosOficialesPageState extends State<CodigosOficialesPage> {
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
        title: const Text('Códigos Oficiales'),
      ),
      floatingActionButton:
          BlocSelector<MainBloc, MainState, CodigosOficiales?>(
        selector: (state) => state.codigosOficiales,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahoraMap(
                datos: state.codigosOficiales.map((e) => e.toMap()).toList(),
                nombre: 'Códigos Oficiales',
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
              'Los códigos oficiales son los definidos por Supply Chain para la planificación de materiales, podrían no contener códigos que si esten en plataforma, o códigos que no se hayan comprado antes, si no encuentra un código requerido por favor comuniquese con yuly.barretorodriguez@enel.com para más información.',
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
                    for (ToCelda celda in state.codigosOficiales!.celdas)
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
                  if (state.codigosOficiales == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<CodigoOficial> codigosOficiales =
                      state.codigosOficiales!.codigosOficiales;
                  codigosOficiales = codigosOficiales
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
                  if (codigosOficiales.length > endList) {
                    codigosOficiales = codigosOficiales.sublist(0, endList);
                  }
                  return SingleChildScrollView(
                    controller: _controller,
                    child: SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: emptyTextSelectionControls,
                      child: Column(
                        children: [
                          for (CodigoOficial codigoOficial in codigosOficiales)
                            Builder(builder: (context) {
                              // print(toNum(pedido.pedido));
                              return Row(
                                key: UniqueKey(),
                                children: [
                                  for (ToCelda celda in codigoOficial.celdas)
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
