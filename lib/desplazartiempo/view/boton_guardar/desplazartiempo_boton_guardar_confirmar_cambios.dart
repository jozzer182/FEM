import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/main_bloc.dart';

class DesplazarGuardarCambiosDetectados extends StatelessWidget {
  const DesplazarGuardarCambiosDetectados({
    super.key,
    required this.cambios,
  });

  final String cambios;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cambios detectados'),
      content: Text(cambios),
      actions: [
        TextButton(
          onPressed: () {
            BlocProvider.of<MainBloc>(context)
                .desplazarTiempoController()
                .cambios
                .setCambio(cambios);
            Navigator.pop(context, true);
          },
          child: const Text('Continuar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
