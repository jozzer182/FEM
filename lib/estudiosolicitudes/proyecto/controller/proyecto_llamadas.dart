import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../resources/constant/apis.dart';
import '../../general/model/estudiosol_reg.dart';

class EstudioProyectoLLamadasController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  EstudioProyectoLLamadasController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  Future<void> borrarSolicitud(
    EstudioSolReg solicitado,
  ) async {
    try {
      bl.startLoading;
      Map<String, Object> dataSend = {
        'dataReq': {
          'libro': 'f${solicitado.year}_solicitados',
          'hoja': 'reg',
          'map': [solicitado.toMap()],
        },
        'fname': "deleteByIdE4eCto"
      };
      // print(jsonEncode(dataSend));
      final Response response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );

      bl.mensajeFlotante(message: response.body.toString());
    } catch (e) {
      bl.errorCarga("Eliminar Solicitado", e);
    }
    bl.stopLoading;
  }

  Future<void> agregarFEM(EstudioSolReg solicitud) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${solicitud.year}',
        'hoja': 'reg',
        'vals': [solicitud.toMap()],
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
      bl.errorCarga('Agregando FEM DB', e);
      return;
    }
    var dataAsListMap = jsonDecode(response.body);
    bl.mensajeFlotante(
      message: '$dataAsListMap',
      messageColor: Colors.green,
    );
  }

  Future<void> agregarEliminados(EstudioSolReg solicitud) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${solicitud.year}_eliminados',
        'hoja': 'reg',
        'vals': [solicitud.toMap()],
      },
      'fname': "addRowsNotId"
    };
    late Response response;
    try {
      print(jsonEncode(dataSend));
      response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
    } on Exception catch (e) {
      bl.errorCarga('Agregando registro a Eliminados', e);
      return;
    }
    var dataAsListMap = jsonDecode(response.body);
    bl.mensajeFlotante(
      message: '$dataAsListMap',
      messageColor: Colors.green,
    );
  }
}
