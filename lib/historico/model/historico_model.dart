import 'dart:convert';

import 'package:http/http.dart';

import '../../fem/model/fem_model_single_fem.dart';
import '../../resources/constant/apis.dart';

class Historico {
  List<SingleFEM> f2022 = [];
  List<SingleFEM> f2023 = [];
  List<SingleFEM> f2024 = [];

  Future<List<SingleFEM>> obtener(String year) async {
    var dataSend = {
      'dataReq': {'libro': year, 'hoja': 'reg'},
      'fname': "getHojaList"
    };
    final response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    var dataAsListMap = jsonDecode(response.body);
    if (dataAsListMap is! List || dataAsListMap.isEmpty) {
      return [];
    }
    dataAsListMap.removeAt(0);
    if (year == "f2022") {
      f2022 = [];
      for (List item in dataAsListMap) {
        f2022.add(SingleFEM.fromList(item));
      }
      return f2022;
    }
    if (year == "f2023") {
      f2023 = [];
      for (List item in dataAsListMap) {
        f2023.add(SingleFEM.fromList(item));
      }
      return f2023;
    }
    if (year == "f2024") {
      f2024 = [];
      for (List item in dataAsListMap) {
        f2024.add(SingleFEM.fromList(item));
      }
      return f2024;
    }
    return [];
  }
}
