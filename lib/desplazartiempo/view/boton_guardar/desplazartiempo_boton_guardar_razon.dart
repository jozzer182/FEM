import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/main_bloc.dart';

class DesplazarAgregarComentarioGuardar extends StatelessWidget {
  const DesplazarAgregarComentarioGuardar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        String razon = state.desplazarTiempo!.razon;
        bool valido = razon.length >= 10;
        return AlertDialog(
          title: const Text('Razón del cambio'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Especifique la razón del cambio',
              border: const OutlineInputBorder(),
              errorText:
                  valido ? null : 'La razón debe tener al menos 10 caracteres',
            ),
            onChanged: (value) => BlocProvider.of<MainBloc>(context)
                .desplazarTiempoController()
                .lista
                .agregarRazon(value),
          ),
          actions: [
            TextButton(
              onPressed: valido
                  ? () {
                      Navigator.pop(context, true);
                    }
                  : null,
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
