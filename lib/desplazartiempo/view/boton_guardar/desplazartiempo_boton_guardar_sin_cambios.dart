import 'package:flutter/material.dart';

class DesplazarGuardarSinCambios extends StatelessWidget {
  const DesplazarGuardarSinCambios({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No hay cambios'),
      content: const Text('No se han detectado cambios.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}