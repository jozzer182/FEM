import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../budget/model/budget_model.dart';
import '../../fem/model/fem_model.dart';
import '../../pdis/model/pdis_model.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/transicion_pagina.dart';
import '../model/pedidos_model.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
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
    context.read<MainBloc>().add(LoadFem());
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
        title: const Text('Pedidos'),
        actions: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.isLoadingFem) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const Gap(5),
        ],
      ),
      floatingActionButton: BlocSelector<MainBloc, MainState, Fem?>(
        selector: (state) => state.fem,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            List<PedidosSingle> pedidosList = state.pedidosList;
            List<PdisSingle> pdis =
                context.read<MainBloc>().state.pdis?.pdisList ?? [];
            List<BudgetSingle> budgetList =
                context.read<MainBloc>().state.budget?.budgetList ?? [];
            for (PedidosSingle pedido in pedidosList) {
              pedido.pdiname = pdis
                  .firstWhere(
                    (e) => e.lote == pedido.pdi,
                    orElse: () => PdisSingle.fromZero(),
                  )
                  .almacen;
              pedido.nombrecorto = budgetList
                  .firstWhere(
                    (e) => e.nomproyecto == pedido.proyecto,
                    orElse: () => BudgetSingle.fromZero(),
                  )
                  .codproyecto;
            }
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahora(
                datos: pedidosList,
                nombre: 'Pedidos',
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
              return Row(
                children: [
                  for (String key in state.fem!.mapToTitlesPedidos.keys)
                    Expanded(
                      flex: state.fem!.mapToTitlesPedidos[key][0],
                      child: Text(
                        state.fem!.mapToTitlesPedidos[key][1],
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
                if (state.fem == null || firstTimeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<PedidosSingle> pedidos = state.fem!.pedidosList;
                pedidos = pedidos
                    .where(
                      (e) => e.toList().any(
                            (el) => el.toLowerCase().contains(
                                  filter.toLowerCase(),
                                ),
                          ),
                    )
                    .toList();
                pedidos.sort((a, b) => sortByPedido(a, b));
                if (pedidos.length > endList) {
                  pedidos = pedidos.sublist(0, endList);
                }
                return SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      for (PedidosSingle pedido in pedidos)
                        Builder(builder: (context) {
                          // print(toNum(pedido.pedido));
                          return Row(
                            children: [
                              for (String key in pedido.mapToTitlesPedidos.keys)
                                Expanded(
                                  flex: pedido.mapToTitlesPedidos[key]![0],
                                  child: SelectableText(
                                    pedido.mapToTitlesPedidos[key]![1],
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

sortByPedido(PedidosSingle a, PedidosSingle b) {
  return toOrderString2(b).compareTo(toOrderString2(a));
}

String toOrderString2(PedidosSingle input) {
  String cto = input.ref;
  String e4e = input.e4e;
  String proyecto = input.proyecto;
  if (input.pedido.isEmpty) {
    return '00000000';
  }
  List<String> partes = input.pedido.replaceAll('E', '').split('|');
  String mes = partes[0];
  List<String> segundaParte = partes[1].split('-');
  String ano = segundaParte[0];
  String quincena = segundaParte[1];

  return '20$ano$mes$quincena$proyecto$cto$e4e';
}
