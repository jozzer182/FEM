import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_bloc.dart';
import '../../fem/model/fem_model_single_fem.dart';
import 'desplazartiempo_page.dart';
import 'desplazartiempo_ficha_fila.dart';

class VistaFichaDesplazartiempo extends StatefulWidget {
  final FichaAno fichaAno;
  const VistaFichaDesplazartiempo({
    required this.fichaAno,
    super.key,
  });

  @override
  State<VistaFichaDesplazartiempo> createState() =>
      _VistaFichaDesplazartiempoState();
}

class _VistaFichaDesplazartiempoState extends State<VistaFichaDesplazartiempo> {
  final ScrollController _controller = ScrollController();
  int endList = 50;
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
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        final fichaAno = widget.fichaAno;
        List<SingleFEM> ficha = [];
        if (state.desplazarTiempo == null) {
          return const Center(
            child: Text('No hay datos para este año'),
          );
        }
        bool soloNuevo = state.desplazarTiempo!.soloNuevo;
        if (fichaAno == FichaAno.f2024) {
          ficha = state.desplazarTiempo!.f2024Modificada;
        }
        if (fichaAno == FichaAno.f2025) {
          ficha = state.desplazarTiempo!.f2025Modificada;
        }
        if (fichaAno == FichaAno.f2026) {
          ficha = state.desplazarTiempo!.f2026Modificada;
        }
        if (fichaAno == FichaAno.f2027) {
          ficha = state.desplazarTiempo!.f2027Modificada;
        }
        if (fichaAno == FichaAno.f2028) {
          ficha = state.desplazarTiempo!.f2028Modificada;
        }
        if (ficha.isEmpty) {
          return const Center(
            child: Text('No hay datos para este año'),
          );
        }
        if (soloNuevo) {
          ficha = ficha.where((e) => e.estado == 'nuevo').toList();
        }

        List<SingleFEM> fichaToShow = [];
        if (ficha.length > endList) {
          fichaToShow = ficha.sublist(0, endList);
        } else {
          fichaToShow = ficha;
        }

        return ListView.builder(
          controller: _controller,
          itemCount: fichaToShow.length,
          itemBuilder: (context, index) {
            final SingleFEM fem = fichaToShow[index];
            return VistaFichaFilaDesplazarTiempo(
              fem: fem,
              ano: fichaAno.toString().substring(fichaAno.toString().length - 4),
            );
          },
        );
      },
    );
  }
}
