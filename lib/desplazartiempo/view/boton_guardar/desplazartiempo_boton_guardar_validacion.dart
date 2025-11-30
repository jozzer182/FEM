import 'package:flutter/material.dart';

class DesplazarGuardarValidacion extends StatelessWidget {
  const DesplazarGuardarValidacion({
    super.key,
    required this.validacion,
  });

  final String validacion;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Falta información'),
      content: Text(validacion),
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
