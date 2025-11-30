import 'package:fem_app/codigoshabilitados/model/codigoshabilitados_model.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';

onCrearCodigosHabilitados(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  CodigosHabilitados codigosHabilitados = CodigosHabilitados();
  try {
    await codigosHabilitados.crear(
      codigosAdicionales: state().codigosAdicionales!,
      codigosOficiales: state().codigosOficiales!,
    );
    emit(state().copyWith(codigosHabilitados: codigosHabilitados));
  } catch (e) {
    bl.errorCarga("CodigosHabilitados", e);
  }
}
