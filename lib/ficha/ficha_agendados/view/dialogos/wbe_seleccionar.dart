import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/main_bloc.dart';
import '../../../../../../plataforma/model/plataforma_model.dart';
import '../../../../fem/model/fem_model_single_fem.dart';
import '../../../../fem/model/fem_model_single_fem_enum.dart';

class WbeDescripcionAgendadosDialog extends StatefulWidget {
  final SingleFEM singleFEM;
  const WbeDescripcionAgendadosDialog({
    required this.singleFEM,
    super.key,
  });

  @override
  State<WbeDescripcionAgendadosDialog> createState() => _WbeDescripcionAgendadosDialogState();
}

class _WbeDescripcionAgendadosDialogState extends State<WbeDescripcionAgendadosDialog> {
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
            width: 400,
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.plataforma == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<PlataformaSingle> plataformaList =
                    state.plataforma!.plataformaList;
                plataformaList = plataformaList
                    .where((e) =>
                        e.material == widget.singleFEM.e4e &&
                        e.wbe.contains(filter))
                    .toList();
                return ListView.builder(
                  itemCount: plataformaList.length,
                  itemBuilder: (context, index) {
                    bool cierreTecnico =
                        plataformaList[index].status.contains('CTEC');
                    return ListTile(
                      textColor: cierreTecnico ? Colors.grey[200] : null,
                      title: Text(
                          '${plataformaList[index].proyecto} \n${plataformaList[index].wbe}'),
                      trailing: Text('${plataformaList[index].ctd}'),
                      subtitle: Text(
                        '${plataformaList[index].status}',
                        style: TextStyle(
                          color: cierreTecnico ? Colors.red[200] : null,
                        ),
                      ),
                      onTap: cierreTecnico
                          ? null
                          : () {
                              context
                                  .read<MainBloc>()
                                  .fichaPedidosController()
                                  .cambiarCampo(
                                    item: widget.singleFEM.item,
                                    tipo: TipoFem.wbe,
                                    value: plataformaList[index].wbe,
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
