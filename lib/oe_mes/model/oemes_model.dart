import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fem_app/resources/env_config.dart';

class OeMes {
  List<Map> oeMesList = [];
  List<Map> oeMesListSearch = [];
  int view = 50;
  bool loading = false;
  Map itemsAndFlex = {
    'po': [2, 'po'],
    'pos': [1, 'pos'],
    'proovedor': [6, 'proovedor'],
    'e4e': [2, 'e4e'],
    'descripcion': [6, 'descripción'],
    'ctd': [2, 'ctd'],
    'fecha': [2, 'fecha'],
    'incoterm': [1, 'inco'],
    'destino': [4, 'destino'],
    'grupo': [2, 'grupo'],
    'usuario': [6, 'usuario'],
  };
  get keys {
    return oeMesList[0].keys.toList();
  }

  List<int> get flex{
    int length = oeMesList[0].keys.length;
    List<int> asFlex = List.filled(length, 1);
    asFlex[0] = 2;
    asFlex[1] = 4;
    return asFlex;
  }

  get listaTitulo {
    return [
      for (var key in keys)
        {'texto': itemsAndFlex[key][1], 'flex': itemsAndFlex[key][0]},
    ];
  }

  buscar(String busqueda) {
    oeMesListSearch = oeMesList
        .where((element) => element.values.any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  Future<List> obtener() async {
    var dataSend = {
      'dataReq': {'pdi': 'GENERAL', 'tx': 'OEMES'},
      'fname': "getSAP"
    };
    final response = await http.post(
      Uri.parse(EnvConfig.apiOeMes),
      body: jsonEncode(dataSend),
    );
    var dataAsListMap;
    if (response.statusCode == 302) {
      var response2 =
          await http.get(Uri.parse(response.headers["location"] ?? ''));
      dataAsListMap = jsonDecode(response2.body)['dataObject'];
    } else {
      dataAsListMap = jsonDecode(response.body)['dataObject'];
    }
    // print(dataAsListMap[0]);
    for (var item in dataAsListMap) {
      // print(item.runtimeType);
      // print(item);
      Map item2 = Map.from(item);
      oeMesList.add(item2);
      // print(item2.runtimeType);
      // print(item2.keys);
    }
    // print(oeMesList[0].runtimeType);
    // print(oeMesList[0].keys.length);
    // print(oeMesList[0].values);
    // print(oeMesList);
    // oeMesList.sort((a, b) => a.po.compareTo(b.po));
    oeMesListSearch = [...oeMesList];
    return oeMesList;
  }
}
