import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/main_bloc.dart';
import '../../../../../../plataforma/model/plataforma_model.dart';
import '../../../../model/ficha_reg/reg.dart';
import '../../../../model/ficha_reg/reg_enum.dart';

class WbeFichaInventarioDialog extends StatefulWidget {
  final FichaReg fichaReg;
  const WbeFichaInventarioDialog({
    required this.fichaReg,
    super.key,
  });

  @override
  State<WbeFichaInventarioDialog> createState() =>
      _WbeFichaInventarioDialogState();
}

class _WbeFichaInventarioDialogState extends State<WbeFichaInventarioDialog> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  .where((e) => e.material == widget.fichaReg.e4e)
                  .where((e) => e.toList().any((el) => el.toLowerCase().contains(filter.toLowerCase())))
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
                                .fichaFichaController()
                                .campoDescripcion(
                                  item: widget.fichaReg.item,
                                )
                                .cambiar(
                                  tipo: TipoRegFicha.wbe,
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
    );
  }
}
