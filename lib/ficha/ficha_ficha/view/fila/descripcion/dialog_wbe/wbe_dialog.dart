import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../model/ficha_reg/reg.dart';
import 'wbe_dialog_existente.dart';
import 'wbe_dialog_inventario.dart';
import 'wbe_dialog_por_crear.dart';

class WbeDescripcionDialog extends StatefulWidget {
  final FichaReg fichaReg;
  const WbeDescripcionDialog({
    required this.fichaReg,
    super.key,
  });

  @override
  State<WbeDescripcionDialog> createState() => _WbeDescripcionDialogState();
}

enum WbeTipo { inventario, existente, porCrear }

class _WbeDescripcionDialogState extends State<WbeDescripcionDialog> {
  WbeTipo wbeView = WbeTipo.inventario;
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar WBE'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentedButton<WbeTipo>(
            segments: const <ButtonSegment<WbeTipo>>[
              ButtonSegment<WbeTipo>(
                value: WbeTipo.inventario,
                label: Text('Inventario'),
                icon: Icon(Icons.warehouse),
                tooltip: 'Material en inventario con WBE asignada',
              ),
              ButtonSegment<WbeTipo>(
                value: WbeTipo.existente,
                label: Text('Existente'),
                icon: Icon(Icons.currency_exchange),
                tooltip: 'Se informa un WBE para compra del material',
              ),
              ButtonSegment<WbeTipo>(
                value: WbeTipo.porCrear,
                label: Text('Por Crear'),
                icon: Icon(Icons.design_services),
                tooltip:
                    'Se requiere compra del material, pero aún no se tiene WBE',
              ),
            ],
            selected: <WbeTipo>{wbeView},
            onSelectionChanged: (Set<WbeTipo> newSelection) {
              setState(() {
                wbeView = newSelection.first;
              });
            },
          ),
          const Gap(10),
          if (wbeView == WbeTipo.inventario)
            WbeFichaInventarioDialog(
              fichaReg: widget.fichaReg,
            ),
          if (wbeView == WbeTipo.existente)
            WbeFichaExistenteDialog(
              fichaReg: widget.fichaReg,
            ),
          if (wbeView == WbeTipo.porCrear)
            WbeFichaPorCrearDialog(
              fichaReg: widget.fichaReg,
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
