import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/main_bloc.dart';

class ConfirmDialogProyecto extends StatefulWidget {
  final bool aprobar;
  const ConfirmDialogProyecto({
    required this.aprobar,
    super.key,
  });

  @override
  State<ConfirmDialogProyecto> createState() => _ConfirmDialogProyectoState();
}

class _ConfirmDialogProyectoState extends State<ConfirmDialogProyecto> {
  String accion = '';
  String comentario = '';
  @override
  void initState() {
    accion = widget.aprobar ? 'aprobar' : 'rechazar';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Esta seguro que desea $accion?'),
      content: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Comentario para confirmar',
          errorText: comentario.length > 10? null:'comentario requerido (10 caracteres min)',
        ),
        onChanged: (value) {
          setState(() {
            comentario = value;
          });
          context
              .read<MainBloc>()
              .estudioSolController()
              .setComentario(value);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: 
          comentario.length <= 10
              ? null:
          () {
            context
                .read<MainBloc>()
                .estudioSolController()
                .enviarSolicitud(widget.aprobar);

            Navigator.of(context).pop();
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
