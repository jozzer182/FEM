import 'package:fem_app/mm60/model/mm60_model.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../fem/model/fem_model_single_fem.dart';
import '../../fem/model/fem_model_single_fem_enum.dart';
import '../model/desplazartiempo_model.dart';

class DesplazarCtrlLista {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo? desplazarTiempo;
  DesplazarCtrlLista(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo;
  }

  void agregar(String ano, String e4e) {
    if (desplazarTiempo == null) return;
    List<SingleFEM> fichaModifcada = [];
    if (ano == '2024') fichaModifcada = desplazarTiempo!.f2024Modificada;
    if (ano == '2025') fichaModifcada = desplazarTiempo!.f2025Modificada;
    if (ano == '2026') fichaModifcada = desplazarTiempo!.f2026Modificada;
    if (ano == '2027') fichaModifcada = desplazarTiempo!.f2027Modificada;
    if (ano == '2028') fichaModifcada = desplazarTiempo!.f2028Modificada;

    int index = fichaModifcada.length;
    SingleFEM fem = SingleFEM.fromInit(index);
    fem.year = ano;
    fem.estado = 'nuevo';
    fem.e4e = e4e;
    fem.descripcion = state()
        .mm60!
        .mm60List
        .firstWhere(
          (e) => e.material == e4e,
          orElse: Mm60Single.fromInit,
        )
        .descripcion;
    String miniyear = ano.substring(2);
    fem.estdespacho =
        '[{"01|$miniyear-1":"0","01|$miniyear-2":"0","02|$miniyear-1":"0","02|$miniyear-2":"0","03|$miniyear-1":"0","03|$miniyear-2":"0","04|$miniyear-1":"0","04|$miniyear-2":"0","05|$miniyear-1":"0","05|$miniyear-2":"0","06|$miniyear-1":"0","06|$miniyear-2":"0","07|$miniyear-1":"0","07|$miniyear-2":"0","08|$miniyear-1":"0","08|$miniyear-2":"0","09|$miniyear-1":"0","09|$miniyear-2":"0","10|$miniyear-1":"0","10|$miniyear-2":"0","11|$miniyear-1":"0","11|$miniyear-2":"0","12|$miniyear-1":"0","12|$miniyear-2":"0"}]';
    fichaModifcada.add(fem);
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void eliminar(String ano) {
    if (desplazarTiempo == null) return;
    List<SingleFEM> fichaModifcada = [];
    if (ano == '2024') fichaModifcada = desplazarTiempo!.f2024Modificada;
    if (ano == '2025') fichaModifcada = desplazarTiempo!.f2025Modificada;
    if (ano == '2026') fichaModifcada = desplazarTiempo!.f2026Modificada;
    if (ano == '2027') fichaModifcada = desplazarTiempo!.f2027Modificada;
    if (ano == '2028') fichaModifcada = desplazarTiempo!.f2028Modificada;

    List<SingleFEM> ficha = [];
    if (ano == '2024') ficha = desplazarTiempo!.f2024;
    if (ano == '2025') ficha = desplazarTiempo!.f2025;
    if (ano == '2026') ficha = desplazarTiempo!.f2026;
    if (ano == '2027') ficha = desplazarTiempo!.f2027;
    if (ano == '2028') ficha = desplazarTiempo!.f2028;

    bool tamanoJusto = fichaModifcada.length > ficha.length;

    if (fichaModifcada.isNotEmpty && tamanoJusto) {
      fichaModifcada.removeLast();
      emit(state().copyWith(desplazarTiempo: desplazarTiempo));
    }
  }

  void limpiar(String ano) {
    if (desplazarTiempo == null) return;
    List<SingleFEM> fichaModifcada = [];

    if (ano == '2024') fichaModifcada = desplazarTiempo!.f2024Modificada;
    if (ano == '2025') fichaModifcada = desplazarTiempo!.f2025Modificada;
    if (ano == '2026') fichaModifcada = desplazarTiempo!.f2026Modificada;
    if (ano == '2027') fichaModifcada = desplazarTiempo!.f2027Modificada;
    if (ano == '2028') fichaModifcada = desplazarTiempo!.f2028Modificada;

    List<SingleFEM> ficha = [];
    if (ano == '2024') ficha = desplazarTiempo!.f2024;
    if (ano == '2025') ficha = desplazarTiempo!.f2025;
    if (ano == '2026') ficha = desplazarTiempo!.f2026;
    if (ano == '2027') ficha = desplazarTiempo!.f2027;
    if (ano == '2028') ficha = desplazarTiempo!.f2028;

    print('fichaModifcada.length: ${fichaModifcada.length}');
    print('ficha.length: ${ficha.length}');

    fichaModifcada = ficha.map((e) => e.copyWith()).toList();
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void get solonuevo {
    if (desplazarTiempo == null) return;
    desplazarTiempo!.soloNuevo = !desplazarTiempo!.soloNuevo;
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void modificarCtd({
    required String ano,
    required String id,
    required String value,
    required String campo,
  }) {
    if (desplazarTiempo == null) return;
    List<SingleFEM> fichaModifcada = [];
    if (ano == '2024') fichaModifcada = desplazarTiempo!.f2024Modificada;
    if (ano == '2025') fichaModifcada = desplazarTiempo!.f2025Modificada;
    if (ano == '2026') fichaModifcada = desplazarTiempo!.f2026Modificada;
    if (ano == '2027') fichaModifcada = desplazarTiempo!.f2027Modificada;
    if (ano == '2028') fichaModifcada = desplazarTiempo!.f2028Modificada;

    SingleFEM fem = fichaModifcada.firstWhere((e) => e.id == id);

    fem.setCantidad(
      campo: campo,
      value: value,
    );

    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void modificarEnum({
    required String ano,
    required String id,
    required String value,
    required TipoFem tipoFem,
  }) {
    if (desplazarTiempo == null) return;
    List<SingleFEM> fichaModifcada = [];
    if (ano == '2024') fichaModifcada = desplazarTiempo!.f2024Modificada;
    if (ano == '2025') fichaModifcada = desplazarTiempo!.f2025Modificada;
    if (ano == '2026') fichaModifcada = desplazarTiempo!.f2026Modificada;
    if (ano == '2027') fichaModifcada = desplazarTiempo!.f2027Modificada;
    if (ano == '2028') fichaModifcada = desplazarTiempo!.f2028Modificada;

    SingleFEM fem = fichaModifcada.firstWhere((e) => e.id == id);

    fem.setWithEnum(
      tipoFem: tipoFem,
      value: value,
    );

    // postEval(fem);

    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void get clearNuevosCambios {
    if (desplazarTiempo == null) return;
    List<List<SingleFEM>> fichasNuevas = desplazarTiempo!.allFEMModificada;
    List<List<SingleFEM>> fichasCambios = desplazarTiempo!.allFEMCambios;
    for (int j = 0; j < fichasNuevas.length; j++) {
      List<SingleFEM> fichaNueva = fichasNuevas[j];
      List<SingleFEM> fichaCambios = fichasCambios[j];
      fichaNueva.clear();
      fichaCambios.clear();
    }
    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }

  void agregarRazon(String razon) {
    String persona = state().user!.email;
    String fecha = DateTime.now().toString();

    desplazarTiempo!.razon = razon;

    void actualizarFichaReg(List<SingleFEM> fichas) {
      for (SingleFEM fichaReg in fichas) {
        fichaReg.log.razon = razon;
        fichaReg.log.persona = persona;
        fichaReg.log.fecha = fecha;
        fichaReg.fechacambio = fecha;
        fichaReg.solicitante = persona;
      }
    }

    List<List<SingleFEM>> fichasNuevas = desplazarTiempo!.allFEMNuevos;
    List<List<SingleFEM>> fichasCambios = desplazarTiempo!.allFEMCambios;

    for (int j = 0; j < fichasNuevas.length; j++) {
      List<SingleFEM> fichaNueva = fichasNuevas[j];
      if (fichaNueva.isNotEmpty) actualizarFichaReg(fichaNueva);
      List<SingleFEM> fichaCambios = fichasCambios[j];
      if (fichaCambios.isNotEmpty) actualizarFichaReg(fichaCambios);
    }

    emit(state().copyWith(desplazarTiempo: desplazarTiempo));
  }
}
