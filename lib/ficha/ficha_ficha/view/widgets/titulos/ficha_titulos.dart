// import 'package:fem_app/ficha/main/ficha/model/ficha_model.dart';
import 'package:fem_app/resources/constant/meses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/main_bloc.dart';
import '../../../../../resources/numero_precio.dart';
import '../../../../ficha_resumen/model/ficha__resumen_model.dart';
import '../../../model/ficha_reg/reg.dart';
import 'dialog_desplazar_mes.dart';

class FichaTitulosMeses extends StatelessWidget {
  const FichaTitulosMeses({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> middleMonths = ["05", "06", "07", "08"];
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        FichaReg fichaReg = state.ficha!.fficha.ficha.first;
        // bool versionActiva = fichaReg.version.get(widget.mes);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  FResumen resumen = state.ficha!.resumen;
                  String porcentaje =
                      ' (${(100 * resumen.total / resumen.budgetMaterial).toStringAsFixed(0)}%)';

                  return Expanded(
                    flex: 8,
                    child: RichText(
                      text: TextSpan(
                        text: 'Valor Ficha: ',
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: uSFormat.format(resumen.total),
                          ),
                          TextSpan(
                            text: porcentaje,
                            style: resumen.total > resumen.budgetMaterial
                                ? const TextStyle(color: Colors.red)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Gap(2),
              Expanded(
                flex: 12,
                child: Row(
                  children: [
                    for (String mes in meses)
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: InkWell(
                                  onDoubleTap:
                                      !fichaReg.agendado.activoMes.get(mes) ||
                                              mes == '12' || !state.ficha!.fficha.editar
                                          ? null
                                          : () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return DialogDesplazar(
                                                    mes: mes,
                                                  );
                                                },
                                              );
                                            },
                                  child: Text(
                                    mes,
                                    style: TextStyle(
                                      color: middleMonths.contains(mes)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      fontWeight: FontWeight.bold,
                                      decoration:
                                          fichaReg.agendado.activoMes.get(mes)
                                              ? TextDecoration.none
                                              : TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(1),
                          ],
                        ),
                      ),
                    const Gap(1),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'T',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
