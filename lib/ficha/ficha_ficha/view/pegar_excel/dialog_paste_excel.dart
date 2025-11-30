import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:gap/gap.dart';
import 'dart:convert';
import 'dart:html' as html;

class PasteExcelDialog extends StatefulWidget {
  const PasteExcelDialog({super.key});

  @override
  State<PasteExcelDialog> createState() => _PasteExcelDialogState();
}

class _PasteExcelDialogState extends State<PasteExcelDialog>
    with TickerProviderStateMixin {
  late FlutterGifController controller;

  @override
  void initState() {
    controller = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.repeat(
        min: 0,
        max: 400,
        period: const Duration(milliseconds: 6000),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pegar datos de Excel'),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GifImage(
              image: const AssetImage('images/CopyPasteFEM2.gif'),
              controller: controller,
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                const String csvContent =
                    'e4e;cto;wbe;pdi;comentario;1;2;3;4;5;6;7;8;9;10;11;12';

                // Paso 2: Convertir el String a un Blob
                final bytes = utf8.encode(csvContent);
                final blob = html.Blob([bytes], 'text/csv');
                final url = html.Url.createObjectUrlFromBlob(blob);

                // Paso 3: Crear un enlace y descargar el archivo
                html.AnchorElement(href: url)
                  ..setAttribute("download", "Plantilla Ficha FEM.csv")
                  ..click();

                // Limpieza: Revocar el URL creado para liberar recursos
                html.Url.revokeObjectUrl(url);
              },
              child: const Text('Descargar Plantilla'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
