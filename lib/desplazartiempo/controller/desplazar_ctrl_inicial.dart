import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../fem/model/fem_model.dart';
import '../model/desplazartiempo_model.dart';

class DesplazamientoTiempoInicial {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo? desplazarTiempo;

  DesplazamientoTiempoInicial(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo;
  }

  void llenarFichas(String filter) {
    if (desplazarTiempo == null) return;
    limpiarfichas;
    Fem fem = state().fem!;
    //llenar fichas
    desplazarTiempo!.f2024Modificada = fem.f2024
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2024 = fem.f2024
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2025Modificada = fem.f2025
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2025 = fem.f2025
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2026Modificada = fem.f2026
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2026 = fem.f2026
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2027Modificada = fem.f2027
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2027 = fem.f2027
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2028Modificada = fem.f2028
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    desplazarTiempo!.f2028 = fem.f2028
        .where((element) => element.e4e.contains(filter))
        .map((e) => e.copyWith())
        .toList();
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void get limpiarfichas {
    if (desplazarTiempo == null) return;
    desplazarTiempo!.f2024Modificada = [];
    desplazarTiempo!.f2024 = [];
    desplazarTiempo!.f2025Modificada = [];
    desplazarTiempo!.f2025 = [];
    desplazarTiempo!.f2026Modificada = [];
    desplazarTiempo!.f2026 = [];
    desplazarTiempo!.f2027Modificada = [];
    desplazarTiempo!.f2027 = [];
    desplazarTiempo!.f2028Modificada = [];
    desplazarTiempo!.f2028 = [];
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }
}
