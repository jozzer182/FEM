import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/main_bloc.dart';
import '../../../../model/ficha_reg/reg.dart';
import '../../../../model/ficha_reg/reg_enum.dart';

class WbeFichaPorCrearDialog extends StatefulWidget {
  final FichaReg fichaReg;
  const WbeFichaPorCrearDialog({
    required this.fichaReg,
    super.key,
  });

  @override
  State<WbeFichaPorCrearDialog> createState() => _WbeFichaPorCrearDialogState();
}

class _WbeFichaPorCrearDialogState extends State<WbeFichaPorCrearDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        bool value = widget.fichaReg.wbe.startsWith('Por Crear');
        return Column(
          children: [
            const Text('Tenga en cuenta que:'),
            const Text(
              '1. Debe actualizar la WBE una vez la tenga y este creada en sistema.',
            ),
            const Text(
              '2. Si no se tiene WBE, se podría entorpecer el proceso de nacionalización, por ende la causación del material.',
            ),
            const Text(
              '3. Si no se tiene WBE y el material entra a bodega, no podrá ser asignado al proyecto y quedará en status "Libre utilización".',
            ),
            const Text(
              '4. Si este espacio esta seleccionado, no se despachará ningún pedido.',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: value,
                  onChanged: (newBool) {
                    if (newBool == null) return;
                    if (newBool) {
                      context
                          .read<MainBloc>()
                          .fichaFichaController()
                          .campoDescripcion(
                            item: widget.fichaReg.item,
                          )
                          .cambiar(
                            tipo: TipoRegFicha.wbe,
                            value:
                                'Por Crear - ${DateTime.now()} - ${state.user!.email}',
                          );
                    } else {
                      context
                          .read<MainBloc>()
                          .fichaFichaController()
                          .campoDescripcion(
                            item: widget.fichaReg.item,
                          )
                          .cambiar(
                            tipo: TipoRegFicha.wbe,
                            value: '',
                          );
                    }
                  },
                ),
                const Text('Wbe por crear (Entiendo y Acepto)'),
              ],
            ),
          ],
        );
      },
    );
  }
}
