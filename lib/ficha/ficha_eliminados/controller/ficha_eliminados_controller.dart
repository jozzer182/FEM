import 'dart:convert';

import 'package:fem_app/ficha/main/ficha/model/ficha_model.dart';
import 'package:http/http.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../resources/constant/apis.dart';
import '../model/ficha_eliminados_single_model.dart';

class FichaEliminadosController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  FichaEliminadosController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  Future<void> obtener() async {
    try {
      // print("FichaCambiosController obtener");
      bl.startLoading;
      Map<String, Object> dataSend = {
        'dataReq': {
          'libro': 'f${state().year}_eliminados',
          'hoja': 'reg',
          'filter': state().ficha!.fficha.ficha[0].proyecto,
          'field': 9, // 9 es el campo de proyecto en el sheet
        },
        'fname': "getHojaListFiltered"
      };
      late Response response;
      // print(jsonEncode(dataSend));
      response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
      var dataAsListMap = jsonDecode(response.body);
      // print("dataAsListMap: $dataAsListMap");
      Ficha ficha = state().ficha!;
      List<EliminadosSingle> cambiosList = ficha.cambios.cambiosList;
      cambiosList.clear();
      if (dataAsListMap is! List || dataAsListMap.isEmpty) {
        // bl.mensaje(message: 'No hay cambios registrados ${dataAsListMap}');
        ficha.cambios.isEmpty = true;
        emit(state().copyWith(ficha: ficha));
        bl.stopLoading;
        return;
      }
      // dataAsListMap.removeAt(0);
      for (List item in dataAsListMap) {
        cambiosList.add(EliminadosSingle.fromList(item));
      }
      emit(state().copyWith(ficha: ficha));
    } catch (e) {
      bl.errorCarga("Obtener Cambios", e);
    }
    bl.stopLoading;
  }
}
