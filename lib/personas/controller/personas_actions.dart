import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/personas_model.dart';

onLoadPersonas(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Personas personas = Personas();
  try {
    await personas.obtener();
    emit(state().copyWith(personas: personas));
  } catch (e) {
    bl.errorCarga("Personas", e);
  }
}
