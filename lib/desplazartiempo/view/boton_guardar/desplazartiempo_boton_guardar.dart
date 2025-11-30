// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/main_bloc.dart';
import 'desplazartiempo_boton_guardar_confirmar_cambios.dart';
import 'desplazartiempo_boton_guardar_destinatarios.dart';
import 'desplazartiempo_boton_guardar_razon.dart';
import 'desplazartiempo_boton_guardar_sin_cambios.dart';
import 'desplazartiempo_boton_guardar_validacion.dart';

class BotonGuardarDesplazarTiempo extends StatefulWidget {
  const BotonGuardarDesplazarTiempo({super.key});

  @override
  State<BotonGuardarDesplazarTiempo> createState() =>
      _BotonGuardarDesplazarTiempoState();
}

class _BotonGuardarDesplazarTiempoState
    extends State<BotonGuardarDesplazarTiempo> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        //1. Validar
        String validacion = BlocProvider.of<MainBloc>(context)
            .desplazarTiempoController()
            .guardar
            .validar
            .validar;
        if (validacion.isNotEmpty) {
          await showDialog(
              context: context,
              builder: (context) {
                return DesplazarGuardarValidacion(validacion: validacion);
              });
          return;
        }

        //2. Detectar cambios
        bool hayCambios = BlocProvider.of<MainBloc>(context)
            .desplazarTiempoController()
            .cambios
            .hayCambios;

        if (!hayCambios) {
          await showDialog(
              context: context,
              builder: (context) {
                return const DesplazarGuardarSinCambios();
              });
          return;
        }

        String cambios = BlocProvider.of<MainBloc>(context)
            .desplazarTiempoController()
            .cambios
            .cambios;

        //3. Confirmacion de Guardar
        bool? deseaContinuar = await showDialog<bool>(
          context: context,
          builder: (context) {
            return DesplazarGuardarCambiosDetectados(cambios: cambios);
          },
        );
        if (deseaContinuar == null || !deseaContinuar) {
          BlocProvider.of<MainBloc>(context)
              .desplazarTiempoController()
              .lista
              .clearNuevosCambios;
          return;
        }

        //4. Capturar razon de cambio
        bool? razonAgregada = await showDialog<bool>(
          context: context,
          builder: (context) {
            return const DesplazarAgregarComentarioGuardar();
          },
        );

        if (razonAgregada == null || !razonAgregada) {
          BlocProvider.of<MainBloc>(context)
              .desplazarTiempoController()
              .lista
              .clearNuevosCambios;
          return;
        }

        //5. Conformar correos de aviso
        BlocProvider.of<MainBloc>(context)
            .desplazarTiempoController()
            .destinatarios
            .initDestinatarios;

        bool? destinatariosElegidos = await showDialog<bool>(
          context: context,
          builder: (context) {
            return const DesplazarDestinatarios();
          },
        );

        //6. Guardar
        if (destinatariosElegidos == null || !destinatariosElegidos) {
          return;
        }

        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        BlocProvider.of<MainBloc>(context)
            .desplazarTiempoController()
            .guardar
            .guardar;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Color de fondo del botón
      ),
      child: const Text('Guardar'),
    );
  }
}
