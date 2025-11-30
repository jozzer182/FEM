import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../../../resources/constant/apis.dart';
import '../../model/ficha__ficha_model.dart';

class CtrlFFichaGuardarEliminados {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late FFicha fficha;

  CtrlFFichaGuardarEliminados(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    fficha = state().ficha!.fficha;
  }

  Future<void> get enviar async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${state().year}_eliminados',
        'hoja': 'reg',
        'vals': fficha.eliminados.map((e) => e.log.toMap()).toList(),
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
