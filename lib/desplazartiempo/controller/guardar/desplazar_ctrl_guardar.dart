import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../resources/future_group_add.dart';
import '../../model/desplazartiempo_model.dart';
import 'desplazar_ctrl_guardar_eliminados.dart';
import 'desplazar_ctrl_guardar_libres.dart';
import 'desplazar_ctrl_guardar_notificacionfem.dart';
import 'desplazar_ctrl_guardar_validar.dart';

class DesplazarCtrlGuardar {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo? desplazarTiempo;

  DesplazarCtrlGuardar(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo;
  }

  Future<void> get guardar async {
    bl.startLoading;
    bl.mensajeFlotante(message: 'Por favor espere a que se recargue la página');
    FutureGroupDelayed fg = FutureGroupDelayed();
    fg.add(guardarNotificacionFem.enviar);
    if (desplazarTiempo!.allFEMNuevos.any((e) => e.isNotEmpty)) {
      fg.add(guardarLibres.enviar);
    }
    if (desplazarTiempo!.allFEMCambios.any((e) => e.isNotEmpty)) {
      fg.add(guardarEliminados.enviar);
    }
    fg.close();
    await fg.future;
    bl.stopLoading;
    bl.recargar;
  }

  DesplazarCtrlGuardarLibres get guardarLibres =>
      DesplazarCtrlGuardarLibres(bl);

  DesplazarCtrlGuardarEliminados get guardarEliminados =>
      DesplazarCtrlGuardarEliminados(bl);

  DesplazarCtrlGuardarNotificacionFem get guardarNotificacionFem =>
      DesplazarCtrlGuardarNotificacionFem(bl);
  
  DesplazarCtrlGuardarValidar get validar =>
      DesplazarCtrlGuardarValidar(bl);
}
