import 'dart:convert';

import 'package:fem_app/fem/model/fem_model_single_fem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../resources/constant/apis.dart';
import '../../../resources/future_group_add.dart';
import '../../model/desplazartiempo_model.dart';

class DesplazarCtrlGuardarLibres {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo desplazarTiempo;

  DesplazarCtrlGuardarLibres(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo!;
  }

  Future<void> get enviar async {
    List<List<SingleFEM>> fichasNuevas = desplazarTiempo.allFEMNuevos;

    FutureGroupDelayed fg = FutureGroupDelayed();

    for (int i = 0; i < fichasNuevas.length; i++) {
      var fichas = fichasNuevas[i];
      if (fichas.isNotEmpty) {
        fg.add(_enviarFichaSingle(fichas, 2024 + i));
      }
    }

    fg.close();
    await fg.future;
  }

  Future<void> _enviarFichaSingle(
    List<SingleFEM> fichas,
    int year,
  ) async {
    for (SingleFEM ficha in fichas) {
      if (ficha.estado == 'nuevo') ficha.id = '';
      ficha.estado = 'Aprobado_Desp';
    }
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f$year',
        'hoja': 'reg',
        'vals': fichas.map((e) => e.log.toMap()).toList(),
      },
      'fname': "updateAndNew"
    };
    late Response response;
    try {
      // print(jsonEncode(dataSend));
      response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
    } on Exception catch (e) {
      bl.errorCarga('Envío Libres', e);
      return;
    }
    var dataAsListMap = jsonDecode(response.body);
    bl.mensajeFlotante(
      message: 'LIBRES: $dataAsListMap',
      messageColor: Colors.green,
    );
  }
}
