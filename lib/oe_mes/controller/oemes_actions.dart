import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/oemes_model.dart';

onLoadOeMes(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  OeMes oeMes = OeMes();
  try {
    await oeMes.obtener();
    emit(state().copyWith(oeMes: oeMes));
  } catch (e) {
    bl.errorCarga("OeMes", e);
  }
}
