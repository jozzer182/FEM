import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../../../resources/constant/apis.dart';
import '../../model/ficha__ficha_model.dart';

class CtrlFFichaGuardarControlados {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late FFicha fficha;

  CtrlFFichaGuardarControlados(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    fficha = state().ficha!.fficha;
  }

  Future<void> get enviar async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${state().year}_solicitados',
        'hoja': 'reg',
        'vals': fficha.controlados.map((e) => e.log.toMap()).toList(),
      },
      'fname': "updateAndNewNotId"
    };
    late Response response;
    try {
      // print(jsonEncode(dataSend));
      response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
    } on Exception catch (e) {
      bl.errorCarga('Envío Solicitados', e);
      return;
    }
    var dataAsListMap = jsonDecode(response.body);
    bl.mensajeFlotante(
      message: 'SOLICITADOS: $dataAsListMap',
      messageColor: Colors.green,
    );
  }
}
