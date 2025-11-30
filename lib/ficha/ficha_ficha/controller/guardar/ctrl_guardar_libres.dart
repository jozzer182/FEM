import 'dart:convert';

import 'package:fem_app/ficha/ficha_ficha/model/ficha_reg/reg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../../../resources/constant/apis.dart';
import '../../model/ficha__ficha_model.dart';

class CtrlFFichaGuardarLibres {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late FFicha fficha;

  CtrlFFichaGuardarLibres(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    fficha = state().ficha!.fficha;
  }

  Future<void> get enviar async {
    for (FichaReg reg in fficha.libres) {
      reg.estado = "Aprobado";
    }

    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${state().year}',
        'hoja': 'reg',
        'vals': fficha.libres.map((e) => e.log.toMap()).toList(),
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
