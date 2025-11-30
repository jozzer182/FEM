import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_cambios.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_disponibilidad.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_number_show.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_oficial.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_riesgo.dart';
import 'package:fem_app/ficha/ficha_ficha/view/fila/numeros/box/box_solicitado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/main_bloc.dart';
import '../../../model/ficha__ficha_model.dart';
import '../../../model/ficha_reg/reg.dart';
import 'box/box_agendado.dart';

class NumerosDialogo extends StatefulWidget {
  final String mes;
  final FichaReg fichaReg;
  const NumerosDialogo({
    required this.mes,
    required this.fichaReg,
    super.key,
  });

  @override
  State<NumerosDialogo> createState() => _NumerosDialogoState();
}

class _NumerosDialogoState extends State<NumerosDialogo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        FFicha fficha = state.ficha!.fficha;
        bool verDinero = fficha.verDinero;
        bool pedidoActivo = widget.fichaReg.agendado.activoMes.get(widget.mes);
        bool versionActiva = widget.fichaReg.version.get(widget.mes);

        return AlertDialog(
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${widget.fichaReg.e4e}\n',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: '${widget.fichaReg.descripcion}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mes: ${widget.mes}'),
              Text('Pedido Abierto: ${pedidoActivo ? 'Si' : 'No'}'),
              Text('Versión Abierta: ${versionActiva ? 'Si' : 'No'}'),
              Container(
                  height: 300,
                  width: 200,
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Oficial',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                BoxOficial(
                                  fichaReg: widget.fichaReg,
                                  mes: widget.mes,
                                  fontSize: 20,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Riesgo',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                BoxRiesgo(
                                  fichaReg: widget.fichaReg,
                                  mes: widget.mes,
                                  fontSize: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Ficha',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          BoxNumberShow(
                            fichaReg: widget.fichaReg,
                            mes: widget.mes,
                            fontSize: 30,
                          ),
                        ],
                      ),
                      if (verDinero)
                        const SizedBox()
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Agendado',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                BoxAgendado(
                                  fichaReg: widget.fichaReg,
                                  mes: widget.mes,
                                  fontSize: 20,
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Disponible',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                BoxDisponibilidad(
                                  fichaReg: widget.fichaReg,
                                  mes: widget.mes,
                                  fontSize: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (verDinero)
                        const SizedBox()
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Solicitado',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                BoxSolicitado(
                                  fichaReg: widget.fichaReg,
                                  mes: widget.mes,
                                  fontSize: 20,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Cambios',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                BoxCambios(
                                  fichaReg: widget.fichaReg,
                                  mes: widget.mes,
                                  fontSize: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
