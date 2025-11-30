import 'dart:convert';

import 'package:fem_app/plataforma_mb51/model/plataforma_mb51_single.dart';
import 'package:http/http.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/constant/apis.dart';
import '../../resources/future_group_add.dart';
import '../model/plataforma_mb51.dart';

class PlataformaMb51Controller {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  PlataformaMb51 plataformaMb51Init = PlataformaMb51();

  PlataformaMb51Controller(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get obtener async {
    FutureGroupDelayed futureGroup = FutureGroupDelayed();
    for (String mes in obtenerMeses) {
      futureGroup.addF(obtenerMes(mes));
    }
    futureGroup.close();
    await futureGroup.future;
    emit(state().copyWith(plataformaMb51: plataformaMb51Init));
  }

  obtenerMes(String mes) async {
    try {
      PlataformaMb51Mes mb51Mes = PlataformaMb51Mes(mes: mes);
      // plataformaMb51.meses.add(PlataformaMb51Mes(mes: mes));
      Map<String, Object> dataSend = {
        'dataReq': {'libro': 'PLATAFORMA_MB51', 'hoja': '2024_$mes'},
        'fname': "getHojaList"
      };
      // print(jsonEncode(dataSend));
      final response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
      // print(response.body);
      List dataAsListMap;
      if (response.statusCode == 302) {
        var response2 = await get(Uri.parse(
            response.headers["location"].toString().replaceAll(',', '')));
        dataAsListMap = jsonDecode(response2.body);
      } else {
        dataAsListMap = jsonDecode(response.body);
      }
      for (var item in dataAsListMap.sublist(1)) {
        mb51Mes.lista.add(PlataformaMb51Single.fromList(item));
      }
      plataformaMb51Init.meses.add(mb51Mes);
    } catch (e) {
      bl.errorCarga("plataformaMb51 2024_$mes", e);
    }
  }
}

List<String> get obtenerMeses {
  final fechaActual = DateTime.now();
  final List<String> meses = [];

  for (int i = 1; i <= fechaActual.month; i++) {
    meses.add(i.toString().padLeft(2, '0'));
  }

  return meses;
}

List<int> get obtenerMesesInt {
  final fechaActual = DateTime.now();
  final List<int> meses = [];
  for (int i = 1; i < fechaActual.month; i++) {
    meses.add(i);
  }
  return meses.reversed.toList();
}
