import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/sustitutos_model.dart';

onLoadSustitutos(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Sustitutos sustitutos = Sustitutos();
  try {
    await sustitutos.obtener();
    emit(state().copyWith(sustitutos: sustitutos));
  } catch (e) {
    bl.errorCarga("Sustitutos", e);
  }
}
