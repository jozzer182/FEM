import 'package:fem_app/desplazartiempo/model/desplazartiempo_model.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import 'desplazar_ctrl_cambios.dart';
import 'desplazar_ctrl_destinatarios.dart';
import 'desplazar_ctrl_inicial.dart';
import 'desplazar_ctrl_lista.dart';
import 'guardar/desplazar_ctrl_guardar.dart';

class DesplazarTiempoController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo? desplazarTiempo;

  DesplazarTiempoController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo;
  }

  DesplazamientoTiempoInicial get inicial => DesplazamientoTiempoInicial(bl);
  DesplazarCtrlLista get lista => DesplazarCtrlLista(bl);
  DesplazarCtrlCambios get cambios => DesplazarCtrlCambios(bl);
  DesplazarCtrlGuardar get guardar => DesplazarCtrlGuardar(bl);
  DesplazamientoCtrlDestinatarios get destinatarios =>
      DesplazamientoCtrlDestinatarios(bl);
}
