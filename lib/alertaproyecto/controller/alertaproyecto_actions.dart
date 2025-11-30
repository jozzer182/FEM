import 'package:fem_app/alertaproyecto/model/alertaproyecto_model.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';

onLoadAlertaProyectos(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  AlertaProyectos alertaProyectos = AlertaProyectos();
  try {
    await alertaProyectos.obtener();
    emit(state().copyWith(alertaProyectos: alertaProyectos));
  } catch (e) {
    bl.errorCarga("AlertaProyectos", e);
  }
}
