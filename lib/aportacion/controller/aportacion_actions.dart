import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/aportacion_model.dart';

onLoadAportacion(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Aportacion aportacion = Aportacion();
  try {
    await aportacion.obtener();
    emit(state().copyWith(aportacion: aportacion));
  } catch (e) {
    bl.errorCarga("Aportacion", e);
  }
}
