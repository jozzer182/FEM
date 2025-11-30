import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/resources/titulo.dart';

import '../../bloc/main_bloc.dart';
import '../../oe/model/oe_model.dart';
import 'analisiscodigo_page_table_an.dart';

class TablaOe extends StatefulWidget {
  final String filter;
  final DateTime fechaSeleccionada;
  const TablaOe({
    super.key,
    required this.filter,
    required this.fechaSeleccionada,
  });

  @override
  State<TablaOe> createState() => _TablaOeState();
}

class _TablaOeState extends State<TablaOe> {
  int endList = 20;
  // DateTime fechaActual = DateTime.now();
  // DateTime hoy = DateTime(fechaActual.year, fechaActual.month, 1);
  DateTime hoy = DateTime.now();

  void setEndList() {
    setState(() {
      endList += 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    // DateTime hoy = DateTime(fechaActual.year, fechaActual.month, 1);
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        List<Widget> titles = [
          for (ToCelda title in state.oe!.titles)
            Expanded(
              flex: title.flex,
              child: Text(
                title.valor,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ];
        if (widget.filter.length != 6) {
          return TableAn(
              key: UniqueKey(),
              onEndList: setEndList,
              endList: 0,
              title: 'Órdenes de Entrega',
              titles: titles,
              children: const [
                Text(
                  'Ingrese un código E4E de 6 dígitos para ver información',
                  textAlign: TextAlign.center,
                )
              ]);
        }
        // print('hoy: $hoy');
        // print('widget.fechaSeleccionada: ${widget.fechaSeleccionada}');

        if (state.oe == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<OeSingle> oeList = state.oe!.oeList;
        oeList = oeList
            .where((oe) =>
                oe.e4e.contains(widget.filter) &&
                DateTime.parse(oe.fecha).difference(hoy).inDays >= 0
&&
                DateTime.parse(oe.fecha).microsecondsSinceEpoch <=
                    widget.fechaSeleccionada.microsecondsSinceEpoch
                )
            .toList();
        double total = 0;
        for (OeSingle oe in oeList) {
          total += double.parse(oe.ctd);
        }
        context.read<MainBloc>().analisisCodigoController().setTotalOe(total.toInt());
        int originalLength = oeList.length;
        if (oeList.length > endList) {
          oeList = oeList.sublist(0, endList);
        }
        return TableAn(
          key: UniqueKey(),
          onEndList: setEndList,
          endList: originalLength,
          title: 'Órdenes de Entrega${total == 0 ? '' : ' - Total: $total'}',
          titles: titles,
          children: [
            for (OeSingle oe in oeList)
              Row(
                children: [
                  for (ToCelda celda in oe.celdas)
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
          ],
        );
      },
    );
  }
}
