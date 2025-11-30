import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/main_bloc.dart';
import '../../../../fem/model/fem_model_single_fem_enum.dart';
import '../../../../pdis/model/pdis_model.dart';

class PdisDescripcionAgendadosDialog extends StatefulWidget {
  final List<String> items;
  const PdisDescripcionAgendadosDialog({
    required this.items,
    super.key,
  });

  @override
  State<PdisDescripcionAgendadosDialog> createState() =>
      _PdisDescripcionAgendadosDialogState();
}

class _PdisDescripcionAgendadosDialogState
    extends State<PdisDescripcionAgendadosDialog> {
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
            width: 400,
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.pdis == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<PdisSingle> pdisList = state.pdis!.pdisList;
                pdisList = pdisList
                    .where((e) => e.toList().any((el) =>
                        el.toLowerCase().contains(filter.toLowerCase())))
                    .toList();
                return ListView.builder(
                  itemCount: pdisList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          '${pdisList[index].almacen}'),
                      // trailing: Text('${pdisList[index].}'),
                      subtitle: Text('${pdisList[index].lote}'),
                      onTap: () {
                              context
                                  .read<MainBloc>()
                                  .fichaPedidosController()
                                  .paraTodos(
                                    items: widget.items,
                                    tipo: TipoFem.pdi,
                                    value: pdisList[index].lote,
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
