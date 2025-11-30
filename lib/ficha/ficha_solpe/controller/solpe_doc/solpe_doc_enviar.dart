import 'dart:convert';

import 'package:fem_app/resources/constant/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../../../resources/future_group_add.dart';
import '../../../ficha_ficha/model/ficha_reg/reg.dart';
import '../../model/solpe_doc.dart';
import '../../model/solpe_reg.dart';
import 'email_controller.dart';

class SolPeDocEnviarController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late SolPeDoc solPeDoc;

  SolPeDocEnviarController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    solPeDoc = state().solPeDoc!;
  }

  void enviar(String estado) async {
    bl.startLoading;
    bl.mensajeFlotante(
      message: 'Por favor espera a que termine de cargar la página y/o salga un mensaje de confirmación adicional a este.',
    );
    _modificarSolpe(estado);
    FutureGroupDelayed futureGeneral = FutureGroupDelayed();
    if (estado == "Aprobado") {
      if (solPeDoc.eliminados.isNotEmpty) {
        _modificarEliminados;
        futureGeneral.addF(_enviarEliminados);
      }
      _modificarModificados;
      futureGeneral.addF(_enviarModificados);
    }
    futureGeneral.addF(_enviarSolpe);
    futureGeneral.addF(email.enviar);
    futureGeneral.close();
    await futureGeneral.future;
    bl.stopLoading;
    add(Load());
  }

  void get _modificarEliminados {
    String persona = state().user!.email;
    String fecha = DateTime.now().toString();
    for (FichaReg reg in solPeDoc.eliminados) {
      reg.log.razon = solPeDoc.razon;
      reg.log.persona = persona;
      reg.log.fecha = fecha;
      reg.fechacambio = fecha;
      reg.solicitante = persona;
    }
  }

  void get _modificarModificados {
    String persona = state().user!.email;
    String fecha = DateTime.now().toString();
    for (FichaReg reg in solPeDoc.modificada) {
      reg.log.razon = solPeDoc.razon;
      reg.log.persona = persona;
      reg.log.fecha = fecha;
      reg.fechacambio = fecha;
      reg.solicitante = persona;
    }
  }

  void _modificarSolpe(String estado) {
    for (SolPeReg reg in solPeDoc.list) {
      reg.estado = estado;
      reg.estadofecha = DateTime.now().toIso8601String();
      reg.enelfecha = DateTime.now().toIso8601String();
      reg.enelpersona = state().user?.email ?? "";
    }
  }

  get _enviarSolpe async {
    try {
      Map<String, Object> dataSend = {
        'dataReq': {
          'libro': 'SOLICITUDES_PEDIDOS',
          'hoja': 'SOLICITUDES_PEDIDOS',
          'vals': solPeDoc.list.map((e) => e.toMap()).toList(),
        },
        'fname': "updateAndNewPedido"
      };
      // print(jsonEncode(dataSend));
      final Response response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
      var dataAsListMap = jsonDecode(response.body);
      bl.mensajeFlotante(message: dataAsListMap.toString());
    } catch (e) {
      bl.errorCarga("SolPeList", e);
    }
  }

  Future<void> get _enviarEliminados async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${state().year}_eliminados',
        'hoja': 'reg',
        'vals': solPeDoc.eliminados.map((e) => e.log.toMap()).toList(),
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

  Future<void> get _enviarModificados async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${state().year}',
        'hoja': 'reg',
        'vals': solPeDoc.modificada.map((e) => e.log.toMap()).toList(),
      },
      'fname': "updateAndNew"
    };
    late Response response;
    try {
      print(jsonEncode(dataSend));
      response = await post(
        Uri.parse(
          Api.fem,
        ),
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

  EmailListController get email => EmailListController(bl);
}
