// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/main_bloc.dart';
import '../dialogs/solpe_doc_destinatarios.dart';
import '../dialogs/solpe_doc_rechazar_comment.dart';

class SolPeDocRechazarButton extends StatefulWidget {
  const SolPeDocRechazarButton({Key? key}) : super(key: key);

  @override
  State<SolPeDocRechazarButton> createState() => _SolPeDocRechazarButtonState();
}

class _SolPeDocRechazarButtonState extends State<SolPeDocRechazarButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            bool? deseaContinuar = await showDialog<bool>(
              context: context,
              builder: (context) {
                return SolPeDocRechazarComentario();
              },
            );
            if (deseaContinuar == null || !deseaContinuar) {
              return;
            }

            //Destinatarios
            deseaContinuar = await showDialog<bool>(
              context: context,
              builder: (context) {
                return EmailDestinatarios();
              },
            );
            
            if (deseaContinuar == null || !deseaContinuar) {
              return;
            }
            while (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            context.read<MainBloc>().solPeDocController.enviar.enviar("Rechazado");
          },
          child: const Text('Rechazar'),
        );
      },
    );
  }
}
