import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/mm60_model.dart';

onLoadMm60(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Mm60 mm60 = Mm60();
  try {
    await mm60.obtener();
    emit(state().copyWith(mm60: mm60));
  } catch (e) {
    bl.errorCarga("Mm60", e);
  }
}
