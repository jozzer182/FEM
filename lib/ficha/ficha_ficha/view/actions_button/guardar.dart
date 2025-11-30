// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:fem_app/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'guardar_detectados.dart';
import 'guardar_razon.dart';
import 'guardar_sin_cambios.dart';
import 'guardar_validacion.dart';

class BotonGuardarFicha extends StatefulWidget {
  const BotonGuardarFicha({super.key});

  @override
  State<BotonGuardarFicha> createState() => _BotonGuardarFichaState();
}

class _BotonGuardarFichaState extends State<BotonGuardarFicha> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            // crear validacion para fficha, ya que la que sigue es para pedidos

            //Validar que no falte información
            String validacion = BlocProvider.of<MainBloc>(context)
                .fichaFichaController()
                .validar;
            if (validacion.isNotEmpty) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return FichaGuardarValidacion(validacion: validacion);
                  });
              return;
            }
            //motor de detección de cambios
            bool hayCambios = BlocProvider.of<MainBloc>(context)
                .fichaFichaController()
                .cambios
                .hayCambios;

            if (!hayCambios) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return const FichaGuardarSinCambios();
                  });
              return;
            }

            String cambios = BlocProvider.of<MainBloc>(context)
                .fichaFichaController()
                .cambios
                .cambios;

            // if (cambios.isNotEmpty) {
            bool? deseaContinuar = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return FichaGuardarCambiosDetectados(cambios: cambios);
                });

            if (deseaContinuar == null || !deseaContinuar) {
              BlocProvider.of<MainBloc>(context)
                  .fichaFichaController()
                  .lista
                  .clearLibresControlados;
              return;
            }

            //Especifique un mensaje de la razon del cambio
            bool? razonAgregada = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return const FichaAgregarComentarioGuardar();
                });

            if (razonAgregada == null || !razonAgregada) {
              BlocProvider.of<MainBloc>(context)
                  .fichaFichaController()
                  .lista
                  .clearLibresControlados;
              return;
            }

            while (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            BlocProvider.of<MainBloc>(context)
                .fichaFichaController()
                .guardar
                .guardar;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Guardar'),
        );
      },
    );
  }
}
