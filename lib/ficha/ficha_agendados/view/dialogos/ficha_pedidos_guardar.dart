import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/main_bloc.dart';

class FichaPedidosGuardar extends StatefulWidget {
  const FichaPedidosGuardar({super.key});

  @override
  State<FichaPedidosGuardar> createState() => _FichaPedidosGuardarState();
}

class _FichaPedidosGuardarState extends State<FichaPedidosGuardar> {
  var controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Comentario Obligatorio'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Por favor especifique las razones del cambio'),
          const Gap(20),
          TextFormField(
            controller: controller,
            onChanged: (value) {
              BlocProvider.of<MainBloc>(context)
                  .fichaPedidosController()
                  .agregarRazon(value);
            },
            decoration: InputDecoration(
              labelText: 'Comentario',
              border: const OutlineInputBorder(),
              errorText: controller.text.length < 10
              ? "El comentario debe tener al menos 10 caracteres"
              :  null,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: controller.text.length < 10
              ? null
              : () {
                  BlocProvider.of<MainBloc>(context)
                      .fichaPedidosController()
                      .guardar();
                  Navigator.pop(context);
                },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
