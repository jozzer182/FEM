import 'package:fem_app/wbe/model/wbe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../../bloc/main_bloc.dart';
import '../../../../model/ficha_reg/reg.dart';
import '../../../../model/ficha_reg/reg_enum.dart';

class WbeFichaExistenteDialog extends StatefulWidget {
  final FichaReg fichaReg;
  const WbeFichaExistenteDialog({
    required this.fichaReg,
    super.key,
  });

  @override
  State<WbeFichaExistenteDialog> createState() =>
      _WbeFichaExistenteDialogState();
}

class _WbeFichaExistenteDialogState extends State<WbeFichaExistenteDialog> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 400,
          child: Text(
              'Se entiende que la WBE ha sido seleccionada para una compra futura del material, no podrá realizarse el despacho del mismo hacia terreno o un PDI, si requiere despacho seleccione una WBE de inventario.'),
        ),
        const Gap(10),
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
        const Gap(10),
        SizedBox(
          height: 300,
          width: 400,
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.plataforma == null) {
                return const Center(child: CircularProgressIndicator());
              }
              List<WbeSingle> wbeList = state.wbe!.wbeList;
              wbeList = wbeList
                  .where((e) => e.wbe.length == 22)
                  .where((e) => e.toList().any(
                      (el) => el.toLowerCase().contains(filter.toLowerCase())))
                  .toList();
              return ListView.builder(
                itemCount: wbeList.length,
                itemBuilder: (context, index) {
                  bool cierreTecnico = wbeList[index].status.contains('CTEC');
                  return ListTile(
                    textColor: cierreTecnico ? Colors.grey[200] : null,
                    title: Text(
                        '${wbeList[index].descripcion}\n${wbeList[index].proyecto} \n${wbeList[index].wbe}'),
                    subtitle: Text(
                      '${wbeList[index].status}',
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
                                  value:
                                      '${wbeList[index].wbe} (Compra - No Inventario)',
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
