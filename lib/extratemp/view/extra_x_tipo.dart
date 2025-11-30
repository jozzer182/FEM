import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';

class SelectTypePageX extends StatefulWidget {
  final int index;

  SelectTypePageX({
    super.key,
    required this.index,
  });

  @override
  State<SelectTypePageX> createState() => _SelectTypePageXState();
}

class _SelectTypePageXState extends State<SelectTypePageX> {
  List<String> opciones = ["PDI", "PLATAFORMA"];
  List<String> subtitle = [
    "Se enviarán al pdi, transporte a cargo del logística.",
    "Se deben recoger en plataforma, transporte a cargo del Funcional-Contrato, especial para equipos de gran tamaño, peso o muy específicos (series-marcas).",
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Seleccionar tipo envío'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: 300,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Builder(builder: (context) {
                    switch (opciones[index]) {
                      case 'PDI':
                        return Icon(Icons.add_box_sharp);
                      case 'PLATAFORMA':
                        return Icon(Icons.train);
                      default:
                        return Icon(Icons.add_box_sharp);
                    }
                  }),
                  title: Text('${opciones[index]}'),
                  subtitle: Text('${subtitle[index]}'),
                  onTap: () {
                    context.read<MainBloc>().add(
                          ModNuevo(
                            tabla: 'extraList',
                            campo: 'tipoenvio',
                            valor: opciones[index],
                            index: widget.index,
                          ),
                        );
                    Navigator.pop(context);
                  },
                );
              },
            ),
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
