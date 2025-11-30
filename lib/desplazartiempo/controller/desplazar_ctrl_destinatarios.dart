import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/desplazartiempo_model.dart';

class DesplazamientoCtrlDestinatarios {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo? desplazarTiempo;

  DesplazamientoCtrlDestinatarios(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo;
  }

  void get initDestinatarios {
     final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (desplazarTiempo == null) return;
    desplazarTiempo!.para = [
      ...desplazarTiempo!.allFEMNuevos.expand((e) => e.map((e) => e.pm.toUpperCase())).toList(),
      ...desplazarTiempo!.allFEMNuevos.expand((e) => e.map((e) => e.solicitante.toUpperCase())).toList(),
      ...desplazarTiempo!.allFEMCambios.expand((e) => e.map((e) => e.pm.toUpperCase())).toList(),
      ...desplazarTiempo!.allFEMCambios.expand((e) => e.map((e) => e.solicitante.toUpperCase())).toList(),
    ].toSet().toList();
    desplazarTiempo!.para.removeWhere((element) => !regex.hasMatch(element));
    desplazarTiempo!.para.sort();
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void agregarDestinatario(String destinatario) {
    if (desplazarTiempo == null) return;
    desplazarTiempo!.para.add(destinatario);
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void eliminarDestinatario(String destinatario) {
    if (desplazarTiempo == null) return;
    desplazarTiempo!.para.remove(destinatario);
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }
}
