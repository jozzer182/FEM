import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_bloc.dart';
import '../../versiones/model/versiones_model.dart';
import 'analisiscodigo_page_table_an.dart';

class TablaOtros extends StatefulWidget {
  final String filter;
  final DateTime fechaSeleccionada;
  const TablaOtros({
    required this.filter,
    required this.fechaSeleccionada,
    super.key,
  });

  @override
  State<TablaOtros> createState() => _TablaOtrosState();
}

class _TablaOtrosState extends State<TablaOtros> {
  int endList = 20;
  DateTime hoy = DateTime.now();
  int mesFinSeleccionado = 12;
  int mesInicioSeleccionado = 1;

  void setEndList() {
    setState(() {
      endList += 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (widget.filter.length != 6) {
          return TableAn(
              key: UniqueKey(),
              onEndList: setEndList,
              endList: 0,
              title: 'ORA & CE',
              titles: [
                for (String key in state.versiones!.itemsAndFlex.keys)
                  Expanded(
                    flex: state.versiones!.itemsAndFlex[key][0],
                    child: Text(
                      state.versiones!.itemsAndFlex[key][1],
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
        if (state.versiones == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<VersionesSingle> verList = [];
        int total = 0;
        // print('beforefilter 2024');
        List<VersionesSingle> v2024 = state.versiones!.v2024;
        List<VersionesSingle> v2024Filtered = v2024
            .where(
              (ver) =>
                  ver.e4e.contains(widget.filter) &&
                  !ver.unidad.toLowerCase().startsWith("pm") &&
                  ver.isNotEmptyBetween(
                    hoy.month,
                    anoSeleccionado == 2024 ? mesFinSeleccionado : 12,
                  ),
            )
            .toList();
        if (hoy.year == 2024 && v2024Filtered.isNotEmpty) {
          verList += [...v2024Filtered];
          total += v2024Filtered
              .map((fem) => fem.between(
                  hoy.month, anoSeleccionado == 2024 ? mesFinSeleccionado : 12))
              .reduce((value, element) => value + element);
        }
        // print('after 2024');
        if (hoy.year == 2025 ||
            widget.fechaSeleccionada.year >= 2025 &&
                state.versiones!.v2025.isNotEmpty) {
          verList += [
            ...state.versiones!.v2025.where((ver) =>
                ver.e4e.contains(widget.filter) &&
                !ver.unidad.toLowerCase().startsWith("pm") &&
                ver.isNotEmptyBetween(hoy.year == 2025 ? hoy.month : 1,
                    anoSeleccionado == 2025 ? mesFinSeleccionado : 12))
          ];
          total += state.versiones!.v2025
              .where((ver) =>
                  ver.e4e.contains(widget.filter) &&
                  !ver.unidad.toLowerCase().startsWith("pm") &&
                  ver.isNotEmptyBetween(hoy.year == 2025 ? hoy.month : 1,
                      anoSeleccionado == 2025 ? mesFinSeleccionado : 12))
              .map((fem) => fem.between(hoy.year == 2025 ? hoy.month : 1,
                  anoSeleccionado == 2025 ? mesFinSeleccionado : 12))
              .reduce((value, element) => value + element);
        }
        if (hoy.year == 2026 ||
            widget.fechaSeleccionada.year >= 2026 &&
                state.versiones!.v2026.isNotEmpty) {
          verList += [
            ...state.versiones!.v2026.where((ver) =>
                ver.e4e.contains(widget.filter) &&
                !ver.unidad.toLowerCase().startsWith("pm") &&
                ver.isNotEmptyBetween(hoy.year == 2026 ? hoy.month : 1,
                    anoSeleccionado == 2026 ? mesFinSeleccionado : 12))
          ];
          total += state.versiones!.v2026
              .where((ver) =>
                  ver.e4e.contains(widget.filter) &&
                  !ver.unidad.toLowerCase().startsWith("pm") &&
                  ver.isNotEmptyBetween(hoy.year == 2026 ? hoy.month : 1,
                      anoSeleccionado == 2026 ? mesFinSeleccionado : 12))
              .map((fem) => fem.between(hoy.year == 2026 ? hoy.month : 1,
                  anoSeleccionado == 2026 ? mesFinSeleccionado : 12))
              .reduce((value, element) => value + element);
        }
        if (hoy.year == 2027 ||
            widget.fechaSeleccionada.year >= 2027 &&
                state.versiones!.v2027.isNotEmpty) {
          verList += [
            ...state.versiones!.v2027.where((ver) =>
                ver.e4e.contains(widget.filter) &&
                !ver.unidad.toLowerCase().startsWith("pm") &&
                ver.isNotEmptyBetween(hoy.year == 2027 ? hoy.month : 1,
                    anoSeleccionado == 2027 ? mesFinSeleccionado : 12))
          ];
          total += state.versiones!.v2027
              .where((ver) =>
                  ver.e4e.contains(widget.filter) &&
                  !ver.unidad.toLowerCase().startsWith("pm") &&
                  ver.isNotEmptyBetween(hoy.year == 2027 ? hoy.month : 1,
                      anoSeleccionado == 2027 ? mesFinSeleccionado : 12))
              .map((fem) => fem.between(hoy.year == 2027 ? hoy.month : 1,
                  anoSeleccionado == 2027 ? mesFinSeleccionado : 12))
              .reduce((value, element) => value + element);
        }
        if (hoy.year == 2028 ||
            widget.fechaSeleccionada.year >= 2028 &&
                state.versiones!.v2028.isNotEmpty) {
          verList += [
            ...state.versiones!.v2028.where((ver) =>
                ver.e4e.contains(widget.filter) &&
                !ver.unidad.toLowerCase().startsWith("pm") &&
                ver.isNotEmptyBetween(hoy.year == 2028 ? hoy.month : 1,
                    anoSeleccionado == 2028 ? mesFinSeleccionado : 12))
          ];
          total += state.versiones!.v2028
              .where((ver) =>
                  ver.e4e.contains(widget.filter) &&
                  !ver.unidad.toLowerCase().startsWith("pm") &&
                  ver.isNotEmptyBetween(hoy.year == 2028 ? hoy.month : 1,
                      anoSeleccionado == 2028 ? mesFinSeleccionado : 12))
              .map((fem) => fem.between(hoy.year == 2028 ? hoy.month : 1,
                  anoSeleccionado == 2028 ? mesFinSeleccionado : 12))
              .reduce((value, element) => value + element);
        }
        // print('after 2028');
        // print('verList.length: ${verList.length}');
        // print('verList: $verList');
        // print('total: $total');
        context
            .read<MainBloc>()
            .analisisCodigoController()
            .setTotalOraCe(total.toInt());
        int originalLength = verList.length;
        if (verList.length > endList) {
          verList = verList.sublist(0, endList);
        }
        Color? colorTexto;
        int count = 0;
        return TableAn(
          // key: UniqueKey(),
          onEndList: setEndList,
          endList: originalLength,
          title: 'ORA & CE${total == 0 ? '' : ' - Total: $total'}',
          titles: [
            for (String key in state.versiones!.itemsAndFlex.keys)
              Builder(builder: (context) {
                if (state.versiones!.itemsAndFlex[key][1] == mesfinW0 ||
                    state.versiones!.itemsAndFlex[key][1] == mesInicioW0) {
                  colorTexto = Theme.of(context).colorScheme.primary;
                  count++;
                } else if (count == 2 || (mesfinW0 == mesInicioW0)) {
                  colorTexto = null;
                }
                return Expanded(
                  flex: state.versiones!.itemsAndFlex[key][0],
                  child: Text(
                    state.versiones!.itemsAndFlex[key][1],
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
            for (VersionesSingle oe in verList)
              Row(
                children: [
                  for (String key in oe.mapWTotal.keys)
                    Expanded(
                      flex: oe.mapWTotal[key][0],
                      child: Text(
                        oe.mapWTotal[key][1],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}
