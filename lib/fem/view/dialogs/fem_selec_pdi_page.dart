import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';

import '../../../pdis/model/pdis_model.dart';
import '../../model/fem_model_single_fem.dart';

class SelectPdiPage extends StatefulWidget {
  final String year;
  final SingleFEM singleFEM;

  const SelectPdiPage({
    super.key,
    required this.year,
    required this.singleFEM,
  });

  @override
  State<SelectPdiPage> createState() => _SelectPdiPageState();
}

class _SelectPdiPageState extends State<SelectPdiPage> {
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
                      title: Text(
                          '${pdisList[index].almacen} ${pdisList[index].lote}'),
                      onTap: () {
                        context.read<MainBloc>().add(
                              ModFemList(
                                year: widget.year,
                                singleFEM: widget.singleFEM,
                                field: 'PDI',
                                value: pdisList[index].lote,
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
          child: const Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
