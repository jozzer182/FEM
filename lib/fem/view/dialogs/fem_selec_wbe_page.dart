import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/plataforma/model/plataforma_model.dart';

import '../../model/fem_model_single_fem.dart';

class SelectWbePage extends StatefulWidget {
  final String year;
  final SingleFEM singleFEM;
  const SelectWbePage({super.key, required this.year, required this.singleFEM});

  @override
  State<SelectWbePage> createState() => _SelectWbePageState();
}

class _SelectWbePageState extends State<SelectWbePage> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar WBE'),
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
                if (state.plataforma == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<PlataformaSingle> plataformaList = state
                    .plataforma!.plataformaList;
                plataformaList = plataformaList
                    .where((e) => e.material == widget.singleFEM.e4e && e.wbe.contains(filter))
                    .toList();
                return ListView.builder(
                  itemCount: plataformaList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          '${plataformaList[index].proyecto} ${plataformaList[index].wbe}'),
                      onTap: () {
                        context.read<MainBloc>().add(
                              ModFemList(
                                year: widget.year,
                                singleFEM: widget.singleFEM,
                                field: 'WBE',
                                value: plataformaList[index].wbe,
                              ),
                            );
                        context.read<MainBloc>().add(
                              ModFemList(
                                year: widget.year,
                                singleFEM: widget.singleFEM,
                                field: 'proyecto',
                                value: plataformaList[index].proyecto,
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
