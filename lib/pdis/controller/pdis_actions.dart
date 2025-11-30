import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/pdis_model.dart';

onLoadPdis(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Pdis pdis = Pdis();
  try {
    await pdis.obtener();
    emit(state().copyWith(pdis: pdis));
  } catch (e) {
    bl.errorCarga("Pdis", e);
  }
}
