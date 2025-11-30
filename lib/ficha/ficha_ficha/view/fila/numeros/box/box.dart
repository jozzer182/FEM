import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_cambios.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_disponibilidad.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_oficial.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_riesgo.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_solicitado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/main_bloc.dart';
import '../../../../model/ficha__ficha_model.dart';
import '../../../../model/ficha_reg/reg.dart';
import '../numeros_dialogo.dart';
import 'box_number_show.dart';
import 'box_number_edit.dart';
import 'box_agendado.dart';

class BoxNumber extends StatefulWidget {
  final String mes;
  final FichaReg fichaReg;
  const BoxNumber({
    required this.mes,
    required this.fichaReg,
    super.key,
  });

  @override
  State<BoxNumber> createState() => _BoxNumberState();
}

class _BoxNumberState extends State<BoxNumber> {
  double largoTexto = 1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        FFicha fficha = state.ficha!.fficha;
        bool edit = fficha.editar;
        bool verDinero = fficha.verDinero;
        bool versionActiva = widget.fichaReg.version.get(widget.mes);
        return Expanded(
          flex: 1,
          child: InkWell(
            onDoubleTap: () {
              showDialog(
                context: context,
                builder: (context) => NumerosDialogo(
                  mes: widget.mes,
                  fichaReg: widget.fichaReg,
                ),
              );
            },
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => NumerosDialogo(
                  mes: widget.mes,
                  fichaReg: widget.fichaReg,
                ),
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: versionActiva
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (verDinero)
                    const SizedBox()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BoxOficial(
                          fichaReg: widget.fichaReg,
                          mes: widget.mes,
                        ),
                        BoxRiesgo(
                          fichaReg: widget.fichaReg,
                          mes: widget.mes,
                        ),
                      ],
                    ),
                  if (edit)
                    BoxNumberEdit(
                      mes: widget.mes,
                      fichaReg: widget.fichaReg,
                    )
                  else
                    BoxNumberShow(
                      mes: widget.mes,
                      fichaReg: widget.fichaReg,
                    ),
                  if (verDinero)
                    const SizedBox()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BoxAgendado(
                          fichaReg: widget.fichaReg,
                          mes: widget.mes,
                        ),
                        BoxDisponibilidad(
                          fichaReg: widget.fichaReg,
                          mes: widget.mes,
                        ),
                      ],
                    ),
                  if (verDinero)
                    const SizedBox()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BoxSolicitado(
                          fichaReg: widget.fichaReg,
                          mes: widget.mes,
                        ),
                        BoxCambios(
                          fichaReg: widget.fichaReg,
                          mes: widget.mes,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
