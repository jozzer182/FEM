import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/wbe_model.dart';

onLoadWbe(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Wbe wbe = Wbe();
  try {
    await wbe.obtener();
    emit(state().copyWith(wbe: wbe));
  } catch (e) {
    bl.errorCarga("Wbe", e);
  }
}
