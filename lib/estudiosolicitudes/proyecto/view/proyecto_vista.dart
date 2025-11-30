import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../bloc/main_bloc.dart';
import '../../general/model/estudiosol_reg.dart';
import '../model/proyecto_model.dart';
import 'confirm_dialog.dart';

class ProyectoWidget extends StatefulWidget {
  final EstudioProyecto proyecto;
  final String filter;
  const ProyectoWidget({
    required this.proyecto,
    required this.filter,
    super.key,
  });

  @override
  State<ProyectoWidget> createState() => _ProyectoWidgetState();
}

class _ProyectoWidgetState extends State<ProyectoWidget> {
  String proyecto = '';
  String filter = '';
  // List<EstudioSolReg> list = [];

  @override
  void initState() {
    proyecto = widget.proyecto.proyecto;
    filter = widget.filter;
    // list = widget.proyecto.list;
    // print('list: $list');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<EstudioSolReg> list = widget.proyecto.list;
    // if (filter.isNotEmpty) {
    //   list = list.where((e) => e.e4e.contains(filter)).toList();
    //   if (list.isEmpty) {
    //     return const SizedBox();
    //   }
    // } 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            proyecto,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color:  Theme.of(context).colorScheme.secondary,
            ),
          ),
          const Gap(5),
          for (EstudioSolReg reg in list)
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text('${reg.year}'),
                ),
                Expanded(
                  flex: 2,
                  child: Text(reg.circuito),
                ),
                Expanded(
                  flex: 1,
                  child: Text(reg.e4e),
                ),
                Expanded(
                  flex: 4,
                  child: Text(reg.descripcion),
                ),
                Expanded(
                  flex: 6,
                  child: Text(reg.cambio),
                ),
                Expanded(
                  flex: 4,
                  child: Text(reg.comentario1),
                ),
                SizedBox(
                  width: 35,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      context
                          .read<MainBloc>()
                          .estudioSolController()
                          .setSolicitudEnviar(reg);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ConfirmDialogProyecto(
                            aprobar: true,
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.check_circle),
                  ),
                ),
                SizedBox(
                  width: 35,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      context
                          .read<MainBloc>()
                          .estudioSolController()
                          .setSolicitudEnviar(reg);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ConfirmDialogProyecto(
                            aprobar: false,
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.cancel),
                  ),
                ),
                SizedBox(
                  width: 35,
                  child: Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
