import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';

import '../../../pdis/model/pdis_model.dart';
import '../../model/fem_model_single_fem.dart';

class SelectPdiAllPage extends StatefulWidget {
  final String year;
  final List<SingleFEM> dataTable;

  const SelectPdiAllPage({
    super.key,
    required this.year,
    required this.dataTable,
  });

  @override
  State<SelectPdiAllPage> createState() => _SelectPdiAllPageState();
}

class _SelectPdiAllPageState extends State<SelectPdiAllPage> {
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
              // controller: busqueda,
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
                List<PdisSingle> pdisList = state.pdis!.pdisListSearch;
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
                        for (SingleFEM singleFEM in widget.dataTable) {
                          context.read<MainBloc>().add(
                                ModFemList(
                                  year: widget.year,
                                  singleFEM: singleFEM,
                                  field: 'PDI',
                                  value: pdisList[index].lote,
                                ),
                              );
                          context.read<MainBloc>().add(
                                ModFemDB(
                                  singleFEM: singleFEM,
                                  year: widget.year,
                                ),
                              );
                        }
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
