import 'package:fem_app/fem/model/fem_model_single_fem.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../model/desplazartiempo_model.dart';

class DesplazarCtrlGuardarValidar {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo desplazarTiempo;

  DesplazarCtrlGuardarValidar(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo!;
  }

  String get validar {
    String mensaje = '';
    List<List<SingleFEM>> fichaNuevos = desplazarTiempo.allFEMModificada;
    for (int i = 0; i < fichaNuevos.length; i++) {
      List<SingleFEM> fichaNuevo = fichaNuevos[i];
      if (fichaNuevo.isNotEmpty) {
        for (SingleFEM singleFEM in fichaNuevo) {
          if (singleFEM.estado != 'nuevo') {
            continue;
          }
          String errores = '';
          if (singleFEM.proyecto.isEmpty)
            errores +=
                'año: ${2024 + i}, PROYECTO:${singleFEM.proyecto}\n';
          if (singleFEM.pm.isEmpty)
            errores +=
                'año: ${2024 + i}, proyecto:${singleFEM.proyecto} PM: ${singleFEM.pm}\n';
          if (singleFEM.unidad.isEmpty)
            errores +=
                'año: ${2024 + i}, proyecto:${singleFEM.proyecto}, UNIDAD: ${singleFEM.unidad}\n';
          if (singleFEM.e4e.isEmpty)
            errores +=
                'año: ${2024 + i}, proyecto:${singleFEM.proyecto} E4E: ${singleFEM.e4e}\n';
          if (singleFEM.descripcion.isEmpty)
            errores +=
                'año: ${2024 + i}, proyecto:${singleFEM.proyecto} DESCRIPCION: ${singleFEM.descripcion}\n';

          mensaje += errores;
        }
      }
    }
    return mensaje;
  }
}
