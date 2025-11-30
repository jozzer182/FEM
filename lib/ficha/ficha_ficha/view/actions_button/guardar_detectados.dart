import 'package:flutter/material.dart';

class FichaGuardarCambiosDetectados extends StatelessWidget {
  const FichaGuardarCambiosDetectados({
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