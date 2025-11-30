import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';

import '../../model/fem_model_single_fem.dart';

class SelectTypePage extends StatefulWidget {
  final String year;
  final SingleFEM singleFEM;
  SelectTypePage({super.key, required this.year, required this.singleFEM});

  @override
  State<SelectTypePage> createState() => _SelectTypePageState();
}

class _SelectTypePageState extends State<SelectTypePage> {
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
                        return Icon(Icons.location_city);
                      case 'PLATAFORMA':
                        return Icon(Icons.train);
                      default:
                        return Icon(Icons.location_city);
                    }
                  }),
                  title: Text('${opciones[index]}'),
                  subtitle: Text('${subtitle[index]}'),
                  onTap: () {
                    context.read<MainBloc>().add(
                          ModFemList(
                            year: widget.year,
                            singleFEM: widget.singleFEM,
                            field: 'tipo',
                            value: opciones[index],
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
