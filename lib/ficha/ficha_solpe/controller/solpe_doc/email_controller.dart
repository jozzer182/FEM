import 'dart:convert';

import 'package:http/http.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../../../resources/constant/apis.dart';
import '../../model/solpe_doc.dart';

class EmailListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late SolPeDoc solPeDoc;

  EmailListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    solPeDoc = bl.state().solPeDoc!;
  }

  void get initDestinatarios {
    solPeDoc.destinatarios.clear();
    solPeDoc.destinatarios = [];
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    solPeDoc.destinatarios = state()
            .ficha
            ?.fficha
            .ficha
            .map((e) => e.pm.toUpperCase())
            .toSet()
            .toList() ??
        [];
    solPeDoc.destinatarios.addAll(
      state()
              .ficha
              ?.fficha
              .ficha
              .map((e) => e.solicitante.toUpperCase())
              .toSet()
              .toList() ??
          [],
    );
    solPeDoc.destinatarios.add(solPeDoc.list.first.ecpersona.toUpperCase());
    solPeDoc.destinatarios.add(state().user?.email.toUpperCase() ?? "");
    solPeDoc.destinatarios.removeWhere((element) => !regex.hasMatch(element));
    solPeDoc.destinatarios.sort();
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  void agregarDestinatarios(String value) {
    solPeDoc.destinatarios.add(value);
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  void quitarDestinatarios(String value) {
    solPeDoc.destinatarios.remove(value);
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  get enviar async {
    bl.startLoading;
    try {
      String remitente = state().user!.email.toUpperCase();
      Map<String, Object> dataSend = {
        'dataReq': {
          'datos': solPeDoc.list.map((e) => e.toMap()).toList(),
          'pdi': solPeDoc.list.first.pdi,
          'proyecto': solPeDoc.list.first.proyecto,
          'circuito': solPeDoc.list.first.circuito,
          'pedido': solPeDoc.list.first.pedido,
          'comentario': solPeDoc.list.first.enelcomentario,
          'unidad': solPeDoc.list.first.unidad,
          'destinatarios': solPeDoc.destinatarios,
          'remitente': remitente,
          'estado': solPeDoc.list.first.estado,
          'pedidonumber': solPeDoc.list.first.pedidonumber,
        },
        'fname': "sendMail"
      };
      // print("dataSend: ${jsonEncode(dataSend)}");
      final response = await post(
        Uri.parse(Api.enviarSolpe),
        body: jsonEncode(dataSend),
      );
      var dataAsListMap = jsonDecode(response.body);
      bl.mensajeFlotante(message: dataAsListMap.toString());
      // add(Load());
    } catch (e) {
      bl.errorCarga('Enviar Mail SolPe', e);
    }
    bl.stopLoading;
  }
}
