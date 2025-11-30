// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/codigosadicionales_model.dart';

onLoadCodigosAdicionales(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  CodigosAdicionales codigosAdicionales = CodigosAdicionales();
  try {
    await codigosAdicionales.obtener();
    emit(state().copyWith(codigosAdicionales: codigosAdicionales));
  } catch (e) {
    bl.errorCarga("CodigosAdicionales", e);
  }
}

Future<void> onSaveCodigoAdicional({
  required Bl bl,
  required CodigoAdicional codigoAdicional,
}) async {
  // void Function(MainState p1) emit = bl.emit;
  MainState Function() state = bl.state;
  // void Function(MainEvent p1) add = bl.add;
  bl.startLoading;
  CodigosAdicionales codigosAdicionales = state().codigosAdicionales!;
  try {
    Get.back();
    String respuesta = await codigosAdicionales.guardar(codigoAdicional);
    bl.mensaje(message: respuesta, messageColor: Colors.green);
    await Future.delayed(const Duration(seconds: 1));
    bl.recargar;
  } catch (e) {
    bl.errorCarga("CodigosAdicionales", e);
    bl.stopLoading;
  }
}

Future<void> onDeleteCodigoAdicional({
  required Bl bl,
  required CodigoAdicional codigoAdicional,
}) async {
  // void Function(MainState p1) emit = bl.emit;
  MainState Function() state = bl.state;
  // void Function(MainEvent p1) add = bl.add;
  bl.startLoading;
  CodigosAdicionales codigosAdicionales = state().codigosAdicionales!;
  try {
    Get.back();
    String respuesta = await codigosAdicionales.borrar(codigoAdicional);
    bl.mensaje(message: respuesta, messageColor: Colors.green);
    await Future.delayed(const Duration(seconds: 1));
    bl.recargar;
  } catch (e) {
    bl.errorCarga("CodigosAdicionales", e);
    bl.stopLoading;
  }
}