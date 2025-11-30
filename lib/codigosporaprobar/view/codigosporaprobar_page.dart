import 'package:fem_app/codigosporaprobar/model/codigosporaprobar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';
import '../../resources/transicion_pagina.dart';
import 'dialogs/codigosporparobar_edit.dart';

class CodigosPorAprobarPage extends StatefulWidget {
  const CodigosPorAprobarPage({super.key});

  @override
  State<CodigosPorAprobarPage> createState() => _CodigosPorAprobarPageState();
}

class _CodigosPorAprobarPageState extends State<CodigosPorAprobarPage> {
  String filter = '';
  int endList = 70;
  bool canModify = false;
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
    canModify = BlocProvider.of<MainBloc>(context)
        .state
        .user!
        .permisos
        .any((element) => element == 'modificar_codigos_por_aprobar');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Códigos Por Aprobar'),
        actions: [
          if (canModify)
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return const CodigosPoraprobarEdit();
                  }),
                );
              },
              child: const Text('Agregar'),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
      floatingActionButton:
          BlocSelector<MainBloc, MainState, CodigosPorAprobar?>(
        selector: (state) => state.codigosPorAprobar,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahoraMap(
                datos: state.codigosPorAprobar.map((e) => e.toMap()).toList(),
                nombre: 'Códigos Por Aprobar',
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
              'Son códigos que requieren de aprobación para el cambio en Fichas.',
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
                    for (ToCelda celda in state.codigosAdicionales!.celdas)
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
                    if (canModify)
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.edit,
                          size: 11,
                          color: Colors.grey,
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                );
              },
            ),
            const Gap(5),
            Expanded(
              child: BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  if (state.codigosPorAprobar == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<CodigoPorAprobar> codigosPorAprobar =
                      state.codigosPorAprobar!.codigosPorAprobar;
                  codigosPorAprobar = codigosPorAprobar
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
                  if (codigosPorAprobar.length > endList) {
                    codigosPorAprobar = codigosPorAprobar.sublist(0, endList);
                  }
                  return SingleChildScrollView(
                    controller: _controller,
                    child: SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: emptyTextSelectionControls,
                      child: Column(
                        children: [
                          for (CodigoPorAprobar codigoPorAprobar
                              in codigosPorAprobar)
                            Builder(builder: (context) {
                              // print(toNum(pedido.pedido));
                              return Row(
                                key: UniqueKey(),
                                children: [
                                  for (ToCelda celda in codigoPorAprobar.celdas)
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
                                  if (canModify)
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return CodigosPoraprobarEdit(
                                                codigoPorAprobar:
                                                    codigoPorAprobar,
                                              );
                                            }),
                                          );
                                        },
                                        iconSize: 11,
                                        splashRadius: 11,
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox.shrink(),
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
