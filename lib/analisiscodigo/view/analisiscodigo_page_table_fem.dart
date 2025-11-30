import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_bloc.dart';

import '../../fem/model/fem_model_single_fem.dart';
import 'analisiscodigo_page_table_an.dart';

class TablaFem extends StatefulWidget {
  final String filter;
  final DateTime fechaSeleccionada;
  const TablaFem({
    super.key,
    required this.filter,
    required this.fechaSeleccionada,
  });

  @override
  State<TablaFem> createState() => _TablaFemState();
}

class _TablaFemState extends State<TablaFem> {
  int endList = 20;
  DateTime hoy = DateTime.now();
  int mesFinSeleccionado = 12;
  int mesInicioSeleccionado = 1;

  @override
  void initState() {
    super.initState();
  }

  void setEndList() => setState(() {
        endList += 20;
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (widget.filter.length != 6) {
          return TableAn(
              key: UniqueKey(),
              onEndList: setEndList,
              endList: 0,
              title: 'FEM',
              titles: [
                for (String key in state.fem!.mapToTitles.keys)
                  Expanded(
                    flex: state.fem!.mapToTitles[key][0],
                    child: Text(
                      state.fem!.mapToTitles[key][1],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
              children: const [
                Text(
                  'Ingrese un código E4E de 6 dígitos para ver información',
                  textAlign: TextAlign.center,
                )
              ]);
        }
        String mesfinW0 = '12';
        String mesInicioW0 = hoy.month.toString().padLeft(2, '0');
        if (widget.fechaSeleccionada.year == DateTime.now().year) {
          mesFinSeleccionado = widget.fechaSeleccionada.month;
          mesfinW0 = mesFinSeleccionado.toString().padLeft(2, '0');
        }
        if (widget.fechaSeleccionada.year != DateTime.now().year) {
          mesInicioW0 = '01';
        }
        int anoSeleccionado = widget.fechaSeleccionada.year;
        if (state.fem == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<SingleFEM> femList = [];
        int total = 0;
        // print('fechaSeleccionada: ${widget.fechaSeleccionada}');
        // print('mesFinSeleccionado: $mesFinSeleccionado');
        if (hoy.year == 2024) {
          int mesFin = anoSeleccionado == 2024 ? mesFinSeleccionado : 12;
          List<SingleFEM> f2024 = state.fem!.f2024;
          List<SingleFEM> f2024Filtered = f2024
              .where((fem) =>
                  fem.e4e.contains(widget.filter) &&
                  fem.isNotEmptyBetweenThisYear(hoy.month, mesFin, hoy.day))
              .toList();
          if (f2024Filtered.isNotEmpty) {
            femList += [...f2024Filtered];
            total += f2024Filtered
                .map((fem) => fem.betweenThisYear(hoy.month, mesFin, hoy.day))
                .reduce((value, element) => value + element);
          }
        }
        if (hoy.year == 2025 || widget.fechaSeleccionada.year >= 2025) {
          int mesFin = anoSeleccionado == 2025 ? mesFinSeleccionado : 12;
          List<SingleFEM> f2025 = state.fem!.f2025;
          if (hoy.year == 2025) {
            List<SingleFEM> f2025Filtered = f2025
                .where((fem) =>
                    fem.e4e.contains(widget.filter) &&
                    fem.isNotEmptyBetweenThisYear(hoy.month, mesFin, hoy.day))
                .toList();
            if (f2025Filtered.isNotEmpty) {
              int mesInicio = hoy.year == 2025 ? hoy.month : 1;
              femList += [...f2025Filtered];
              total += femList
                  .map((fem) => fem.betweenThisYear(mesInicio, mesFin, hoy.day))
                  .reduce((value, element) => value + element);
            }
          } else {
            List<SingleFEM> f2025Filtered = f2025
                .where((fem) =>
                    fem.e4e.contains(widget.filter) &&
                    fem.isNotEmptyBetween(1, mesFin))
                .toList();
            if (f2025Filtered.isNotEmpty) {
              femList += [...f2025Filtered];
              total += femList
                  .map((fem) => fem.between(1, mesFin))
                  .reduce((value, element) => value + element);
            }
          }
        }
        if (hoy.year == 2026 ||
            widget.fechaSeleccionada.year >= 2026 &&
                state.fem!.f2026.isNotEmpty) {
          int mesFin = anoSeleccionado == 2026 ? mesFinSeleccionado : 12;
          List<SingleFEM> f2026 = state.fem!.f2026;
          if (hoy.year == 2026) {
            List<SingleFEM> f2026Filtered = f2026
                .where((fem) =>
                    fem.e4e.contains(widget.filter) &&
                    fem.isNotEmptyBetweenThisYear(hoy.month, mesFin, hoy.day))
                .toList();
            if (f2026Filtered.isNotEmpty) {
              int mesInicio = hoy.year == 2026 ? hoy.month : 1;
              femList += [...f2026Filtered];
              total += femList
                  .map((fem) => fem.betweenThisYear(mesInicio, mesFin, hoy.day))
                  .reduce((value, element) => value + element);
            }
          } else {
            List<SingleFEM> f2026Filtered = f2026
                .where((fem) =>
                    fem.e4e.contains(widget.filter) &&
                    fem.isNotEmptyBetween(1, mesFin))
                .toList();
            if (f2026Filtered.isNotEmpty) {
              femList += [...f2026Filtered];
              total += femList
                  .map((fem) => fem.between(1, mesFin))
                  .reduce((value, element) => value + element);
            }
          }
        }
        if (hoy.year == 2027 ||
            widget.fechaSeleccionada.year >= 2027 &&
                state.fem!.f2027.isNotEmpty) {
          int mesFin = anoSeleccionado == 2027 ? mesFinSeleccionado : 12;
          List<SingleFEM> f2027 = state.fem!.f2027;
          if (hoy.year == 2027) {
            List<SingleFEM> f2027Filtered = f2027
                .where((fem) =>
                    fem.e4e.contains(widget.filter) &&
                    fem.isNotEmptyBetweenThisYear(hoy.month, mesFin, hoy.day))
                .toList();
            if (f2027Filtered.isNotEmpty) {
              int mesInicio = hoy.year == 2027 ? hoy.month : 1;
              femList += [...f2027Filtered];
              total += femList
                  .map((fem) => fem.betweenThisYear(mesInicio, mesFin, hoy.day))
                  .reduce((value, element) => value + element);
            }
          } else {
            List<SingleFEM> f2027Filtered = f2027
                .where((fem) =>
                    fem.e4e.contains(widget.filter) &&
                    fem.isNotEmptyBetween(1, mesFin))
                .toList();
            if (f2027Filtered.isNotEmpty) {
              femList += [...f2027Filtered];
              total += femList
                  .map((fem) => fem.between(1, mesFin))
                  .reduce((value, element) => value + element);
            }
          }
        }
        if (hoy.year == 2028 ||
            widget.fechaSeleccionada.year >= 2028 &&
                state.fem!.f2028.isNotEmpty) {
          int mesFin = anoSeleccionado == 2028 ? mesFinSeleccionado : 12;
          List<SingleFEM> f2028 = state.fem!.f2028;
          if (hoy.year == 2028) {
            List<SingleFEM> f2028Filtered = f2028
                .where((fem) =>
                    fem.e4e.contains(widget.filter) &&
                    fem.isNotEmptyBetweenThisYear(hoy.month, mesFin, hoy.day))
                .toList();
            if (f2028Filtered.isNotEmpty) {
              int mesInicio = hoy.year == 2028 ? hoy.month : 1;
              femList += [...f2028Filtered];
              total += femList
                  .map((fem) => fem.betweenThisYear(mesInicio, mesFin, hoy.day))
                  .reduce((value, element) => value + element);
            }
          } else {
            List<SingleFEM> f2028Filtered = f2028
                .where((fem) =>
                    fem.e4e.contains(widget.filter) &&
                    fem.isNotEmptyBetween(1, mesFin))
                .toList();
            if (f2028Filtered.isNotEmpty) {
              femList += [...f2028Filtered];
              total += femList
                  .map((fem) => fem.between(1, mesFin))
                  .reduce((value, element) => value + element);
            }
          }
        }

        int originalLength = femList.length;
        if (femList.length > endList) {
          femList = femList.sublist(0, endList);
        } else {
          femList = femList;
        }
        Color? colorTexto;
        int count = 0;
        context.read<MainBloc>().analisisCodigoController().setTotalFem(total);
        return TableAn(
          key: UniqueKey(),
          onEndList: setEndList,
          endList: originalLength,
          title:
              // 'FEM',
              'FEM${total == 0 ? '' : ' - Total: $total'}',
          titles: [
            for (String key in state.fem!.mapToTitles.keys)
              Builder(builder: (context) {
                if (state.fem!.mapToTitles[key][1] == mesfinW0 ||
                    state.fem!.mapToTitles[key][1] == mesInicioW0) {
                  colorTexto = Theme.of(context).colorScheme.primary;
                  count++;
                } else if (count == 2 || (mesfinW0 == mesInicioW0)) {
                  colorTexto = null;
                }
                return Expanded(
                  flex: state.fem!.mapToTitles[key][0],
                  child: Text(
                    state.fem!.mapToTitles[key][1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorTexto,
                    ),
                  ),
                );
              }),
          ],
          children: [
            for (SingleFEM fem in femList)
              Row(
                key: UniqueKey(),
                children: [
                  for (String key in fem.mapToTitles.keys)
                    Builder(builder: (context) {
                      if (key == 'm$mesInicioW0') {
                        int valor = 0;
                        if (fem
                            .toMap()['m${mesInicioW0}q2']
                            .toString()
                            .isNotEmpty) {
                          int q1 = fem.pedidoMapInt()['m${mesInicioW0}q1']!;
                          int q2 = fem.pedidoMapInt()['m${mesInicioW0}q2']!;
                          int qx = fem.pedidoMapInt()['m${mesInicioW0}qx']!;
                          valor = q1 + q2 + qx;
                          if (hoy.day >= 15) {
                            valor = q2 + qx;
                          }
                          // valor = fem.toMap()['m${mesInicioW0}q2'].toString();
                        }
                        return Expanded(
                          flex: fem.mapToTitles[key][0],
                          child: Text(
                            '$valor',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        flex: fem.mapToTitles[key][0],
                        child: Text(
                          fem.toMapMonthProject()[key].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      );
                    }),
                ],
              ),
          ],
        );
      },
    );
  }
}
