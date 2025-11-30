import 'package:fem_app/codigosoficiales/model/codigosoficiales_model.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';

onLoadCodigosOficiales(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  CodigosOficiales codigosOficiales = CodigosOficiales();
  try {
    await codigosOficiales.obtener();
    emit(state().copyWith(codigosOficiales: codigosOficiales));
  } catch (e) {
    bl.errorCarga("CodigosOficiales", e);
  }
}
