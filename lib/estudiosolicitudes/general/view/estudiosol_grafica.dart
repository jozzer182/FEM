import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/main_bloc.dart';
import '../../../disponibilidad/model/disponibilidad_model.dart';
import '../../../disponibilidadgrafica/view/line_chart_disponibilidad.dart';
import '../../../plataforma_mb51/controller/plataforma_mb51_controller.dart';

class GraficaDisponibleEstudiosol extends StatefulWidget {
  final String filterE4e;

  const GraficaDisponibleEstudiosol({
    required this.filterE4e,
    super.key,
  });

  @override
  State<GraficaDisponibleEstudiosol> createState() =>
      _GraficaDisponibleEstudiosolState();
}

class _GraficaDisponibleEstudiosolState
    extends State<GraficaDisponibleEstudiosol> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state.disponibilidad == null ||
            state.disponibilidad!.anoList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        DateTime fechaActual = DateTime.now();
        fechaActual = DateTime(fechaActual.year, fechaActual.month, 1);
        int anoActual = fechaActual.year;
        int anoSiguiente = anoActual + 1;
        List<String> e4eList = obtenerE4E(
          years: [anoActual, anoSiguiente],
          fem: state.fem!,
          versiones: state.versiones!,
          plataformaByE4e: state.plataforma!.plataformaByE4e,
          oeE4eList: state.oe!.e4eList,
        );
        if (widget.filterE4e.length != 6 || !e4eList.contains(widget.filterE4e)) {
          return const Center(
            child: Text('Ingrese un código E4E válido'),
          );
        }
        List<List<int>> spots = state.disponibilidad!.anoList
            .firstWhere((e) => e.e4e == widget.filterE4e)
            .disponibilidadList;
        // print('obtenerMesesInt: ${obtenerMesesInt}');
        // print('state.plataformaMb51 ${state.plataformaMb51}');
        for (int mes in obtenerMesesInt) {
          // print('mes: $mes');
          // print(
          //     'mb51: ${state.plataformaMb51!.meses.firstWhere((e) => e.mes == (mes + 1).toString().padLeft(2, '0')).totalE4e(filter)}');
          spots[mes - 1][9] = -state.plataformaMb51!.meses
                  .firstWhere(
                      (e) => e.mes == (mes + 1).toString().padLeft(2, '0'))
                  .totalE4e(widget.filterE4e) +
              spots[mes][9];
        }
        // print('spots: $spots');

        return LineChartDisponibilidad(spots: spots);
      },
    );
  }
}
