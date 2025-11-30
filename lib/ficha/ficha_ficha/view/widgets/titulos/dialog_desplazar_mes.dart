import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/main_bloc.dart';
import '../../../../../resources/constant/meses.dart';

class DialogDesplazar extends StatefulWidget {
  final String mes;
  const DialogDesplazar({
    required this.mes,
    super.key,
  });

  @override
  State<DialogDesplazar> createState() => _DialogDesplazarState();
}

class _DialogDesplazarState extends State<DialogDesplazar> {
  @override
  void initState() {
    context.read<MainBloc>().fichaFichaController().setMesOrigen(widget.mes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text('Desplazar Unidades'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Por favor seleccione el mes de destino.',
              ),
              const Gap(1),
              DropdownButtonFormField(
                items: meses
                    .sublist(meses.indexOf(widget.mes) + 1)
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (a) {
                  if (a == null) return;
                  context.read<MainBloc>().fichaFichaController().setMesDestino(a.toString());
                },
                decoration: InputDecoration(
                    labelText: 'Mes Destino', border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.read<MainBloc>().fichaFichaController().realizarDesplazamiento;
                // fichaReg.agendado
                //     .activoMes
                //     .set(mes);
                Navigator.of(context).pop();
              },
              child: Text('Desplazar'),
            ),
          ],
        );
      },
    );
  }
}
