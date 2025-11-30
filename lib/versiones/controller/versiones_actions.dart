import 'package:fem_app/resources/future_group_add.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/versiones_model.dart';

onLoadVersiones(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Versiones versiones = Versiones();
  List<String> versionesL = [
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
  ];
  FutureGroupDelayed futureGroupVersion = FutureGroupDelayed();
  for (String version in versionesL) {
    futureGroupVersion.addF(obtenerVersion(version, versiones, bl));
  }
  futureGroupVersion.close();
  try {
    await futureGroupVersion.future;
    emit(state().copyWith(versiones: versiones));
  } catch (e) {
    bl.errorCarga("Versiones", e);
  }
}

Future obtenerVersion(
  String version,
  Versiones versiones,
  Bl bl,
) async {
  try {
    await versiones.obtener(version);
  } catch (e) {
    bl.errorCarga(version, e);
  }
}
