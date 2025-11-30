import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/main_bloc.dart';

class SolPeDocRechazarComentario extends StatefulWidget {
  const SolPeDocRechazarComentario({
    super.key,
  });

  @override
  State<SolPeDocRechazarComentario> createState() =>
      _SolPeDocRechazarComentarioState();
}

class _SolPeDocRechazarComentarioState
    extends State<SolPeDocRechazarComentario> {
  String razon = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        // String razon = state.solPeDoc!.razon;
        bool valido = razon.length >= 10;
        return AlertDialog(
          title: const Text('Razón del rechazo'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Especifique la razón del rechazo',
              border: const OutlineInputBorder(),
              errorText:
                  valido ? null : 'La razón debe tener al menos 10 caracteres',
            ),
            onChanged: (value) => setState(() {
              razon = value;
            }),
            // onChanged: (value) => BlocProvider.of<MainBloc>(context)
            //     .solPeDocController
            //     .setRazon(razon),
          ),
          actions: [
            TextButton(
              onPressed: valido
                  ? () {
                      BlocProvider.of<MainBloc>(context)
                          .solPeDocController
                          .setRazon(razon);
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
