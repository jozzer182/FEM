import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/oe_model.dart';

onLoadOe(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Oe oe = Oe();
  try {
    await oe.obtener();
    emit(state().copyWith(oe: oe));
  } catch (e) {
    bl.errorCarga("Oe", e);
  }
}
