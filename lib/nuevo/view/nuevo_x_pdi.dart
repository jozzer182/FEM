import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';

import '../../pdis/model/pdis_model.dart';

class SelectPdiNuevo extends StatefulWidget {
  final int index;
  final String table;

  const SelectPdiNuevo({
    super.key,
    required this.index,
    required this.table,
  });

  @override
  State<SelectPdiNuevo> createState() => _SelectPdiNuevoState();
}

class _SelectPdiNuevoState extends State<SelectPdiNuevo> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar PDI'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Búsqueda',
              ),
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 300,
            width: 300,
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.pdis == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<PdisSingle> pdisList = state.pdis!.pdisList;
                pdisList = pdisList
                    .where(
                      (e) => e.toList().any(
                            (el) => el.toLowerCase().contains(
                                  filter.toLowerCase(),
                                ),
                          ),
                    )
                    .toList();

                return ListView.builder(
                  itemCount: pdisList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(pdisList[index].almacen),
                      subtitle: Text(pdisList[index].lote),
                      onTap: () {
                        context.read<MainBloc>().add(
                                ModNuevo(
                                  tabla: widget.table,
                                  campo: 'pdi',
                                  valor: pdisList[index].lote,
                                  index: widget.index,
                                ),
                              );
                        Navigator.pop(context);
                      },
                    );
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
