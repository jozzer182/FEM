import 'dart:convert';

import 'package:http/http.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../resources/constant/apis.dart';
import '../../main/ficha/model/ficha_model.dart';
import '../model/ficha_solicitados_single_model.dart';

class FichaSolicitadosController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  FichaSolicitadosController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  Future<void> obtener() async {
    bl.startLoading;
    // print("FichaSolicitadosController obtener");
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'f${state().year}_solicitados',
        'hoja': 'reg',
        'filter': state().ficha!.fficha.ficha[0].proyecto,
        'field': 9, // 9 es el campo de proyecto en el sheet
      },
      'fname': "getHojaListFiltered"
    };
    late Response response;
    try {
      // print(jsonEncode(dataSend));
      response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
      var dataAsListMap = jsonDecode(response.body);
      Ficha ficha = state().ficha!;
      List<SolicitadoSingle> solicitadosList =
          ficha.solicitados.solicitadosList;
      solicitadosList.clear();
      if (dataAsListMap is! List || dataAsListMap.isEmpty) {
        // bl.mensaje(message: 'No hay solicitados registrados ${dataAsListMap}');
        // print('No hay solicitados registrados ${dataAsListMap}');
        ficha.solicitados.isEmpty = true;
        emit(state().copyWith(ficha: ficha));
        bl.stopLoading;
        return;
      }
      // print("dataAsListMap: ${dataAsListMap}");
      ficha.solicitados.isEmpty = false;
      for (List item in dataAsListMap) {
        solicitadosList.add(SolicitadoSingle.fromList(item));
      }
      emit(state().copyWith(ficha: ficha));
    } on Exception catch (e) {
      bl.errorCarga("Obtener Solicitados", e);
    }
    bl.stopLoading;
  }

  Future<void> eliminar(
    SolicitadoSingle solicitado,
  ) async {
    try {
      bl.startLoading;
      Map<String, Object> dataSend = {
        'dataReq': {
          'libro': 'f${state().year}_solicitados',
          'hoja': 'reg',
          'map': solicitado.toMap()
        },
        'fname': "deleteByIdE4eCto"
      };
      // print(jsonEncode(dataSend));
      final Response response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );

      bl.mensajeFlotante(message: response.body.toString());
      //wait 1 second
      await Future.delayed(const Duration(seconds: 1));
      await obtener();
    } catch (e) {
      bl.errorCarga("Eliminar Solicitado", e);
    }
    bl.stopLoading;
  }
}
