import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../resources/constant/apis.dart';
import '../../model/desplazartiempo_model.dart';

class DesplazarCtrlGuardarNotificacionFem {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late DesplazarTiempo desplazarTiempo;

  DesplazarCtrlGuardarNotificacionFem(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    desplazarTiempo = state().desplazarTiempo!;
  }

  Future<void> get enviar async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'persona': state().user!.email,
        'razon': desplazarTiempo.razon,
        'cambios': desplazarTiempo.cambios,
        'para': desplazarTiempo.para,
      },
      'fname': "notificacionFem"
    };
    late Response response;
    try {
      print(jsonEncode(dataSend));
      response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
    } on Exception catch (e) {
      bl.errorCarga('Envío Notificacion FEM', e);
      return;
    }
    var dataAsListMap = jsonDecode(response.body);
    bl.mensajeFlotante(
      message: 'CORREO: $dataAsListMap',
      messageColor: Colors.green,
    );
  }

  void addPara(String para) {
    desplazarTiempo.para.add(para);
  }

  void removePara(String para) {
    desplazarTiempo.para.remove(para);
  }
}
