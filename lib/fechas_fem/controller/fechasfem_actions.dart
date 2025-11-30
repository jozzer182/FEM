import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/fechasfem_model.dart';

onLoadFechasFEM(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  FechasFEM fechasFEM = FechasFEM();
  try {
    await fechasFEM.obtener();
    emit(state().copyWith(fechasFEM: fechasFEM));
  } catch (e) {
    bl.errorCarga("FechasFEM", e);
  }
}
