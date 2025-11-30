import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/main_bloc.dart';
import '../model/ficha_solicitados_single_model.dart';

class DialogEliminarSolicitado extends StatelessWidget {
  final SolicitadoSingle solicitado;
  const DialogEliminarSolicitado({
    required this.solicitado,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar'),
      content: const Text('¿Está seguro que desea eliminar este solicitado?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            context
                .read<MainBloc>()
                .fichaSolicitadosController()
                .eliminar(
                  solicitado,
                );
            Navigator.of(context).pop();
          },
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}
