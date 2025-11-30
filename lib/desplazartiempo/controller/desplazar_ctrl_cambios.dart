import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../fem/model/fem_model_single_fem.dart';
import '../../motor_detector_cambios/motor_detector_cambios.dart';
import '../model/desplazartiempo_model.dart';

class DesplazarCtrlCambios {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo desplazarTiempo;
  DesplazarCtrlCambios(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo!;
  }

  bool get hayCambios {
    List<List<SingleFEM>> fichasModificada = desplazarTiempo.allFEMModificada;
    List<List<SingleFEM>> fichasOriginal = desplazarTiempo.allFEM;
    for (int j = 0; j < fichasModificada.length; j++) {
      List<SingleFEM> fichaModificada = fichasModificada[j];
      List<SingleFEM> fichaOriginal = fichasOriginal[j];
      if (fichaModificada.length != fichaOriginal.length) {
        return true;
      }
      for (var i = 0; i < fichaModificada.length; i++) {
        if (fichaModificada[i] != fichaOriginal[i]) {
          return true;
        }
      }
    }
    return false;
  }

  String get cambios {
    String mensaje = '';
    String cambio = '';
    List<List<SingleFEM>> fichasModificada = desplazarTiempo.allFEMModificada;
    List<List<SingleFEM>> fichasOriginal = desplazarTiempo.allFEM;
    for (int j = 0; j < fichasModificada.length; j++) {
      var fichaModificada = fichasModificada[j];
      var fichaOriginal = fichasOriginal[j];
      for (var i = 0; i < fichaOriginal.length; i++) {
        if (fichaModificada[i] != fichaOriginal[i]) {
          String cambio = detectorCambios(
            newFEM: fichaModificada[i],
            oldFEM: fichaOriginal[i],
          );
          if (cambio.isNotEmpty) {
            mensaje +=
                '${j + 2024} - ${fichaModificada[i].proyecto} - $cambio \n';
            cambio +=
                '${j + 2024} - ${fichaModificada[i].proyecto} - ${fichaModificada[i].e4e} - ${fichaModificada[i].descripcion} - $cambio \n';
          }
          _addLibreControlado(fichaModificada[i], cambio, j);
          _addEliminado(fichaOriginal[i], cambio, j);
        }
      }
      if (fichaModificada.length > fichaOriginal.length) {
        for (var i = fichaOriginal.length; i < fichaModificada.length; i++) {
          mensaje += '${j + 2024} - ${fichaModificada[i].proyecto} - Nuevo\n';
          cambio +=
              '${j + 2024} - ${fichaModificada[i].proyecto} - ${fichaModificada[i].e4e} - ${fichaModificada[i].descripcion} - Nuevo \n';

          _addLibreControlado(fichaModificada[i], 'Nuevo', j);
        }
      }
      desplazarTiempo.cambios = cambio;
      emit(state().copyWith(desplazarTiempo: desplazarTiempo));
    }
    return mensaje;
  }

  void _addLibreControlado(SingleFEM singleFEM, String cambio, int j) {
    singleFEM.log.cambio = cambio;
    if (j == 0) desplazarTiempo.f2024Nuevos.add(singleFEM);
    if (j == 1) desplazarTiempo.f2025Nuevos.add(singleFEM);
    if (j == 2) desplazarTiempo.f2026Nuevos.add(singleFEM);
    if (j == 3) desplazarTiempo.f2027Nuevos.add(singleFEM);
    if (j == 4) desplazarTiempo.f2028Nuevos.add(singleFEM);
  }

  void _addEliminado(SingleFEM singleFEM, String cambio, int j) {
    singleFEM.log.cambio = cambio;
    if (j == 0) desplazarTiempo.f2024Cambios.add(singleFEM);
    if (j == 1) desplazarTiempo.f2025Cambios.add(singleFEM);
    if (j == 2) desplazarTiempo.f2026Cambios.add(singleFEM);
    if (j == 3) desplazarTiempo.f2027Cambios.add(singleFEM);
    if (j == 4) desplazarTiempo.f2028Cambios.add(singleFEM);
  }

  void setCambio(String cambios) {
    desplazarTiempo.cambios = cambios;
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }
}
