import 'package:bloc/bloc.dart';
import 'package:fem_app/disponibilidad/controller/disponibilidad_controller.dart';
import 'package:flutter/material.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/resources/future_group_add.dart';

import '../../bloc/main__bl.dart';
import '../model/fem_model.dart';
import '../model/fem_model_single_fem.dart';

onLoadFEM(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  bl.startLoadingFEM;
  Fem fem = Fem();
  FutureGroupDelayed futureGroupFEM = FutureGroupDelayed();

  List<String> years = [
    // "2024",
    "2025",
    "2026",
    "2027",
    "2028"
  ];
  for (String year in years) {
    futureGroupFEM.addF(obtenerFicha(year, fem, bl));
  }
  futureGroupFEM.close();
  await futureGroupFEM.future;
  try {
    emit(state().copyWith(fem: fem));
  } catch (e) {
    bl.errorCarga("FEM", e);
  }
  bl.stopLoadingFEM;
}

Future obtenerFicha(
  String year,
  Fem fem,
  Bl bl,
) async {
  try {
    await fem.obtener('f$year');
  } catch (e) {
    bl.errorCarga('FEM ficha del $year', e);
  }
}

Future onAddCesta(
  AddCesta event,
  var emit,
  MainState Function() state,
) async {
  var add = (MainEvent event) => emit(event);
  Bl bl = Bl(emit, state, add);
  bl.startLoading;
  try {
    String year = '20${event.pedido.substring(3, 5)}';
    SingleFEM pedido = event.singleFEM.setPedido(event.pedido, '1');
    ModFemDB modFemDB = ModFemDB(year: year, singleFEM: pedido);
    await onModFemDB(modFemDB, emit, state);
  } catch (e) {
    bl.errorCarga("onAddCesta", e);
  }
  bl.stopLoading;
}

Future onDeleteCesta(
  DeleteCesta event,
  var emit,
  MainState Function() state,
) async {
  Bl bl = Bl(emit, state, (MainEvent event) => emit(event));
  bl.startLoading;
  try {
    String year = '20${event.pedido.substring(3, 5)}';
    SingleFEM pedido = event.singleFEM.setPedido(event.pedido, '0');
    ModFemDB modFemDB = ModFemDB(year: year, singleFEM: pedido);
    await onModFemDB(modFemDB, emit, state);
  } catch (e) {
    bl.errorCarga("onDeleteCesta", e);
  }
  bl.stopLoading;
}

//----- modificar FEMLIST-----------------------------------
void onModFemList(
  ModFemList event,
  var emit,
  MainState Function() state,
) async {
  var add = (MainEvent event) => emit(event);
  List<SingleFEM> ficha = getFemYear(event.year, state().fem!);
  SingleFEM fila = ficha.firstWhere((e) => e.id == event.singleFEM.id);
  fila.setValueEvent(event);
  state().fem!.femSum();
  emit(state().copyWith(fem: state().fem));
  await DisponibilidadController(Bl(emit, state, add)).crear;
}

//----- modificar PEDIDOSLIST-----------------------------------
Future onModFemDB(
  ModFemDB event,
  var emit,
  MainState Function() state,
) async {
  var add = (MainEvent event) => emit(event);
  Bl bl = Bl(emit, state, add);
  bl.startLoading;
  try {
    String respuesta = '';
    respuesta = await state().fem!.enviar(event.year, event.singleFEM);
    bl.mensaje(
      message: '$respuesta | ${event.singleFEM.e4e}',
      messageColor: Colors.green,
    );
  } catch (e) {
    bl.errorCarga("onModFemDB", e);
  }
  bl.stopLoading;
}

void onHoldCtd(
  HoldCtd event,
  Emitter<MainState> emit,
  MainState Function() state,
) async {
  // await state.fem!.enviar(event.year, event.singleFEM);
  int ctdTotal = 0;
  Map dataMap = event.singleFEM.toMapInt();
  for (var quin in state().fechasFEM!.closedVersions()) {
    ctdTotal += dataMap[quin] as int;
  }
  state().fem!.ctdTotal[event.singleFEM.e4e] = ctdTotal;
  emit(state().copyWith(
    fem: state().fem,
  ));
}

List<SingleFEM> getFemYear(String year, Fem fem) {
  List<SingleFEM> data = [];
  if (year == "2022") data = fem.f2022;
  if (year == "2023") data = fem.f2023;
  if (year == "2024") data = fem.f2024;
  if (year == "2025") data = fem.f2025;
  if (year == "2026") data = fem.f2026;
  if (year == "2027") data = fem.f2027;
  if (year == "2028") data = fem.f2028;
  return data;
}
