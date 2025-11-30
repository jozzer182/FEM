import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../fem/model/fem_model_single_fem.dart';
import '../../../resources/constant/apis.dart';
import '../../../resources/future_group_add.dart';
import '../../model/desplazartiempo_model.dart';

class DesplazarCtrlGuardarEliminados {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo desplazarTiempo;

  DesplazarCtrlGuardarEliminados(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo!;
  }

  Future<void> get enviar async {
    List<List<SingleFEM>> fichasEliminadas = desplazarTiempo.allFEMCambios;

    FutureGroupDelayed fg = FutureGroupDelayed();

    for (int i = 0; i < fichasEliminadas.length; i++) {
      List<SingleFEM> fichas = fichasEliminadas[i];
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
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${year}_eliminados',
        'hoja': 'reg',
        'vals': fichas.map((e) => e.log.toMap()).toList(),
      },
      'fname': "addRowsNotId"
    };
    late Response response;
    try {
      // print(jsonEncode(dataSend));
      response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
    } on Exception catch (e) {
      bl.errorCarga('Envío Eliminados (Ficha)', e);
      return;
    }
    var dataAsListMap = jsonDecode(response.body);
    bl.mensajeFlotante(
      message: 'ELIMINADOS: $dataAsListMap',
      messageColor: Colors.green,
    );
  }
}
