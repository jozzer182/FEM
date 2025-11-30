import 'package:localstorage/localstorage.dart';
import 'package:fem_app/bloc/main_bloc.dart';

import 'main__bl.dart';

onCargar2023(
  Cargar2023 event,
  emit,
  MainState Function() state,
) async {
  LocalStorage storage = LocalStorage('cargar2023.json');
  await storage.ready;
  storage.setItem('cargar', event.cargar);
  emit(state().copyWith(cargar2023: event.cargar));
}

onCargar2023Loader(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  LocalStorage storage = LocalStorage('cargar2023.json');
  await storage.ready;
  bool? cargar = storage.getItem('cargar');
  emit(state().copyWith(cargar2023: cargar));
}
