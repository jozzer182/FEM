// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/main_bloc.dart';
import 'dialog_paste_excel.dart';

class FichaBotonPegarExcel extends StatefulWidget {
  const FichaBotonPegarExcel({super.key});

  @override
  State<FichaBotonPegarExcel> createState() => _FichaBotonPegarExcelState();
}

class _FichaBotonPegarExcelState extends State<FichaBotonPegarExcel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        // List<NuevoIngresoBSingle> nuevoIngresoList =
        //     state.nuevoIngresoB?.nuevoIngresoList ?? [];
        return ElevatedButton(
          child: const Text('Pegar datos de Excel'),
          onPressed: () async {
            bool seLogroPegar = await context
                .read<MainBloc>()
                .fichaFichaController()
                .ctrlFichaPegarExcel
                .seLogroPegar;
            if (!seLogroPegar) {
              showDialog(
                context: context,
                builder: (context) {
                  return const PasteExcelDialog();
                },
              );
            }
          },
        );
      },
    );
  }
}
