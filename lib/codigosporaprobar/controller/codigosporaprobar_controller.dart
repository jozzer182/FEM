import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/codigosporaprobar_model.dart';

class CodigosPorAprobarController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  CodigosPorAprobarController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get onLoadCodigosPorAprobar async {
    var emit = bl.emit;
    MainState Function() state = bl.state;
    CodigosPorAprobar codigosPorAprobar = CodigosPorAprobar();
    try {
      await codigosPorAprobar.obtener();
      emit(state().copyWith(codigosPorAprobar: codigosPorAprobar));
    } catch (e) {
      bl.errorCarga("CodigosPorAprobar", e);
    }
  }

  Future<void> onSaveCodigoPorAprobar({
    required CodigoPorAprobar codigoPorAprobar,
  }) async {
    // void Function(MainState p1) emit = bl.emit;
    MainState Function() state = bl.state;
    // void Function(MainEvent p1) add = bl.add;
    bl.startLoading;
    CodigosPorAprobar codigosPorAprobar = state().codigosPorAprobar!;
    try {
      Get.back();
      String respuesta = await codigosPorAprobar.guardar(codigoPorAprobar);
      bl.mensaje(message: respuesta, messageColor: Colors.green);
      await Future.delayed(const Duration(seconds: 1));
      bl.recargar;
    } catch (e) {
      bl.errorCarga("CodigosPorAprobar", e);
      bl.stopLoading;
    }
  }

  Future<void> onDeleteCodigoPorAprobar({
    required CodigoPorAprobar codigoPorAprobar,
  }) async {
    // void Function(MainState p1) emit = bl.emit;
    MainState Function() state = bl.state;
    // void Function(MainEvent p1) add = bl.add;
    bl.startLoading;
    CodigosPorAprobar codigosPorAprobar = state().codigosPorAprobar!;
    try {
      Get.back();
      String respuesta = await codigosPorAprobar.borrar(codigoPorAprobar);
      bl.mensaje(message: respuesta, messageColor: Colors.green);
      await Future.delayed(const Duration(seconds: 1));
      bl.recargar;
    } catch (e) {
      bl.errorCarga("CodigosPorAprobar", e);
      bl.stopLoading;
    }
  }
}
