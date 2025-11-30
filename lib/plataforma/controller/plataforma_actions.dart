// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/plataforma_model.dart';

Future onLoadPlataforma(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Plataforma plataforma = Plataforma();
  try {
    await plataforma.obtener();
    emit(state().copyWith(plataforma: plataforma));
  } catch (e) {
    bl.errorCarga("Plataforma", e);
  }
}
