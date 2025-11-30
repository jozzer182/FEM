import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../resources/constant/apis.dart';
import '../model/estudiosol_reg.dart';

class EstudioSolLlamadasController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  EstudioSolLlamadasController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  Future<void> borrarSolicitudes(
    List<EstudioSolReg> solicitudes,
  ) async {
    try {
      bl.startLoading;
      List<int> years = solicitudes.map((e) => e.year).toSet().toList();
      for (int year in years) {
        List<EstudioSolReg> solicitudesYear =
            solicitudes.where((element) => element.year == year).toList();
        Map<String, Object> dataSend = {
          'dataReq': {
            'libro': 'f${year}_solicitados',
            'hoja': 'reg',
            'map': solicitudesYear.map((e) => e.toMap()).toList(),
          },
          'fname': "deleteByIdE4eCto"
        };
        // print(jsonEncode(dataSend));
        final Response response = await post(
          Uri.parse(Api.fem),
          body: jsonEncode(dataSend),
        );

        bl.mensajeFlotante(message: response.body.toString());
      }
    } catch (e) {
      bl.errorCarga("Eliminar Solicitado", e);
    }
    bl.stopLoading;
  }

  Future<void> agregarFEMs(
    List<EstudioSolReg> solicitudes,
  ) async {
    try {
      bl.startLoading;
      List<int> years = solicitudes.map((e) => e.year).toSet().toList();
      for (int year in years) {
        List<EstudioSolReg> solicitudesYear =
            solicitudes.where((element) => element.year == year).toList();
        Map<String, Object> dataSend = {
          'dataReq': {
            'libro': 'f$year',
            'hoja': 'reg',
            'vals': solicitudesYear.map((e) => e.toMap()).toList(),
          },
          'fname': "updateAndNew"
        };
        late Response response;
        // print(jsonEncode(dataSend));
        response = await post(
          Uri.parse(Api.fem),
          body: jsonEncode(dataSend),
        );
        var dataAsListMap = jsonDecode(response.body);
        bl.mensajeFlotante(
          message: '$dataAsListMap',
          messageColor: Colors.green,
        );
      }
    } on Exception catch (e) {
      bl.errorCarga('Agregando FEM DB', e);
      return;
    }
  }

  Future<void> agregarEliminados(
    List<EstudioSolReg> solicitudes,
  ) async {
    try {
      bl.startLoading;
      List<int> years = solicitudes.map((e) => e.year).toSet().toList();

      for (int year in years) {
        List<EstudioSolReg> solicitudesYear =
            solicitudes.where((element) => element.year == year).toList();
        Map<String, Object> dataSend = {
          'dataReq': {
            'libro': 'f${year}_eliminados',
            'hoja': 'reg',
            'vals': solicitudesYear.map((e) => e.toMap()).toList(),
          },
          'fname': "addRowsNotId"
        };
        late Response response;
        // print(jsonEncode(dataSend));
        response = await post(
          Uri.parse(Api.fem),
          body: jsonEncode(dataSend),
        );
        var dataAsListMap = jsonDecode(response.body);
        bl.mensajeFlotante(
          message: '$dataAsListMap',
          messageColor: Colors.green,
        );
      }
    } on Exception catch (e) {
      bl.errorCarga('Agregando registro a Eliminados', e);
      return;
    }
  }
}
