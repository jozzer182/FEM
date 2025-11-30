import 'package:fem_app/codigosadicionales/view/dialogs/codigosadicionales_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:fem_app/codigosadicionales/model/codigosadicionales_model.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';
import '../../resources/transicion_pagina.dart';

class CodigosAdicionalesPage extends StatefulWidget {
  const CodigosAdicionalesPage({super.key});

  @override
  State<CodigosAdicionalesPage> createState() => _CodigosAdicionalesPageState();
}

class _CodigosAdicionalesPageState extends State<CodigosAdicionalesPage> {
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
        .any((element) => element == 'modificar_codigos_adicionales');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Códigos Adicionales'),
        actions: [
          if (canModify)
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return const CodigosAdicionalesEdit();
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
          BlocSelector<MainBloc, MainState, CodigosAdicionales?>(
        selector: (state) => state.codigosAdicionales,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahoraMap(
                datos: state.codigosAdicionales.map((e) => e.toMap()).toList(),
                nombre: 'Códigos Adcionales',
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
              'Son códigos que no estan en los códigos oficiales y que se se han adicionado por parte de normas, o como análisis de disponibilidad en bodega.',
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
                  if (state.codigosAdicionales == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<CodigoAdicional> codigosAdicionales =
                      state.codigosAdicionales!.codigosAdicionales;
                  codigosAdicionales = codigosAdicionales
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
                  if (codigosAdicionales.length > endList) {
                    codigosAdicionales = codigosAdicionales.sublist(0, endList);
                  }
                  return SingleChildScrollView(
                    controller: _controller,
                    child: SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: emptyTextSelectionControls,
                      child: Column(
                        children: [
                          for (CodigoAdicional codigoAdicional
                              in codigosAdicionales)
                            Builder(builder: (context) {
                              // print(toNum(pedido.pedido));
                              return Row(
                                key: UniqueKey(),
                                children: [
                                  for (ToCelda celda in codigoAdicional.celdas)
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
                                              return CodigosAdicionalesEdit(
                                                codigoAdicional:
                                                    codigoAdicional,
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
