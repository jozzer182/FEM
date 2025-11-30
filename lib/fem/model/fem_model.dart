import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:fem_app/fem/model/fem_model_single_fem.dart';

import 'package:fem_app/nuevo/model/nuevo_model.dart';

import '../../pedidos/model/pedidos_model.dart';
import '../../resources/a_entero_2.dart';
import '../../resources/constant/apis.dart';
import 'fem_sumsingle_model.dart';

class Fem {
  List<SingleFEM> f2022 = [];
  List<SingleFEM> f2023 = [];
  List<SingleFEM> f2024 = [];
  List<SingleFEM> f2025 = [];
  List<SingleFEM> f2026 = [];
  List<SingleFEM> f2027 = [];
  List<SingleFEM> f2028 = [];
  List<SingleFEM> f2022SumMonth = [];
  List<SingleFEM> f2023SumMonth = [];
  List<SingleFEM> f2024SumMonth = [];
  List<SingleFEM> f2025SumMonth = [];
  List<SingleFEM> f2026SumMonth = [];
  List<SingleFEM> f2027SumMonth = [];
  List<SingleFEM> f2028SumMonth = [];
  List<FemSumSingle> f2022Sum = [];
  List<FemSumSingle> f2023Sum = [];
  List<FemSumSingle> f2024Sum = [];
  List<FemSumSingle> f2025Sum = [];
  List<FemSumSingle> f2026Sum = [];
  List<FemSumSingle> f2027Sum = [];
  List<FemSumSingle> f2028Sum = [];
  List<SingleFEM> s2022 = [];
  List<SingleFEM> s2023 = [];
  List<SingleFEM> s2024 = [];
  List<SingleFEM> s2025 = [];
  List<SingleFEM> s2026 = [];
  List<SingleFEM> s2027 = [];
  List<SingleFEM> s2028 = [];
  List<SingleFEM> e2022 = [];
  List<SingleFEM> e2023 = [];
  List<SingleFEM> e2024 = [];
  List<SingleFEM> e2025 = [];
  List<SingleFEM> e2026 = [];
  List<SingleFEM> e2027 = [];
  List<SingleFEM> e2028 = [];
  List<EnableDate> enableDates = [];
  Map<String, int> ctdTotal = {};
  List<PedidosSingle> pedidosList = [];

  List<SingleFEM> obtenerAno(int year) {
    if (year == 2022) return f2022;
    if (year == 2023) return f2023;
    if (year == 2024) return f2024;
    if (year == 2025) return f2025;
    if (year == 2026) return f2026;
    if (year == 2027) return f2027;
    if (year == 2028) return f2028;
    return [];
  }

  List<FemSumSingle> obtenerAnoSum(int year) {
    if (year == 2022) return f2022Sum;
    if (year == 2023) return f2023Sum;
    if (year == 2024) return f2024Sum;
    if (year == 2025) return f2025Sum;
    if (year == 2026) return f2026Sum;
    if (year == 2027) return f2027Sum;
    if (year == 2028) return f2028Sum;
    return [];
  }

  Map itemAndFlex = {
    'circuito': [1, 'Circuito'],
    'e4e': [1, 'E4e'],
    'descripcion': [1, 'Descripción'],
    'um': [1, 'u'],
    'm01': [1, '01'],
    'm02': [1, '02'],
    'm03': [1, '03'],
    'm04': [1, '04'],
    'm05': [1, '05'],
    'm06': [1, '06'],
    'm07': [1, '07'],
    'm08': [1, '08'],
    'm09': [1, '09'],
    'm10': [1, '10'],
    'm11': [1, '11'],
    'm12': [1, '12'],
  };

  Map mapToTitles = {
    'id': [1, 'Año'],
    'proyecto': [8, 'Proyecto'],
    'e4e': [1, 'E4e'],
    'descripcion': [6, 'Descripción'],
    'um': [1, 'Um'],
    'm01': [1, '01'],
    'm02': [1, '02'],
    'm03': [1, '03'],
    'm04': [1, '04'],
    'm05': [1, '05'],
    'm06': [1, '06'],
    'm07': [1, '07'],
    'm08': [1, '08'],
    'm09': [1, '09'],
    'm10': [1, '10'],
    'm11': [1, '11'],
    'm12': [1, '12'],
    'total': [1, 'Total'],
  };

  Map mapToBusquedaE4e = {
    // 'id': [1, 'Año'],
    'proyecto': [8, 'Proyecto'],
    'circuito': [4, 'Circuito'],
    'e4e': [2, 'E4e'],
    'descripcion': [6, 'Descripción'],
    'um': [1, 'Um'],
    'm01': [1, '01'],
    'm02': [1, '02'],
    'm03': [1, '03'],
    'm04': [1, '04'],
    'm05': [1, '05'],
    'm06': [1, '06'],
    'm07': [1, '07'],
    'm08': [1, '08'],
    'm09': [1, '09'],
    'm10': [1, '10'],
    'm11': [1, '11'],
    'm12': [1, '12'],
    'total': [1, 'Total'],
  };

  Map mapToTitlesPedidos = {
    'pedido': [2, 'Pedido'],
    // 'id': [2, 'id'],
    'e4e': [2, 'E4e'],
    'descripcion': [6, 'Descripción'],
    'ctdi': [1, 'Ctd'],
    // 'ctdf': [2, 'ctd_f'],
    'um': [1, 'Um'],
    // 'comentario': [2, 'comentario'],
    // 'solicitante': [2, 'solicitante'],
    // 'tipoenvio': [2, 'tipoenvio'],
    // 'pdi': [2, 'pdi'],
    // 'pdiname': [2, 'pdiname'],
    'proyecto': [5, 'Proyecto'],
    'ref': [3, 'Cto'],
    // 'wbe': [2, 'wbe'],
    // 'wbeproyecto': [2, 'wbeproyecto'],
    // 'wbeparte': [2, 'wbeparte'],
    // 'wbeestado': [2, 'wbeestado'],
    // 'fecha': [2, 'fecha'],
    'estado': [2, 'Estado'],
  };

  Future obtener(String year) async {
    var dataSend = {
      'dataReq': {'libro': year, 'hoja': 'reg'},
      'fname': "getHojaList"
    };
    final response = await http.post(
      Uri.parse(
          Api.fem),
      body: jsonEncode(dataSend),
    );
    // print(response.body);
    // ignore: prefer_typing_uninitialized_variables
    var dataAsListMap;
    if (response.statusCode == 302) {
      var response2 = await http.get(Uri.parse(
          response.headers["location"].toString().replaceAll(',', '')));
      dataAsListMap = jsonDecode(response2.body);
    } else {
      dataAsListMap = jsonDecode(response.body);
    }
    // print();
    List<SingleFEM> ficha = f2022;
    List<SingleFEM> fichaSumMonth = f2022SumMonth;

    if (year == "f2022") ficha = f2022;
    if (year == "f2023") ficha = f2023;
    if (year == "f2024") ficha = f2024;
    if (year == "f2025") ficha = f2025;
    if (year == "f2026") ficha = f2026;
    if (year == "f2027") ficha = f2027;
    if (year == "f2028") ficha = f2028;
    if (year == "f2022") fichaSumMonth = f2022SumMonth;
    if (year == "f2023") fichaSumMonth = f2023SumMonth;
    if (year == "f2024") fichaSumMonth = f2024SumMonth;
    if (year == "f2025") fichaSumMonth = f2025SumMonth;
    if (year == "f2026") fichaSumMonth = f2026SumMonth;
    if (year == "f2027") fichaSumMonth = f2027SumMonth;
    if (year == "f2028") fichaSumMonth = f2028SumMonth;

    if (dataAsListMap.isNotEmpty) {
      for (var item in dataAsListMap.sublist(1)) {
        // print(year.runtimeType);
        ficha.add(SingleFEM.fromList(item));
        fichaSumMonth.add(SingleFEM.fromListToMonth(item));
        if (year == "s2022") s2022.add(SingleFEM.fromList(item));
        if (year == "s2023") s2023.add(SingleFEM.fromList(item));
        if (year == "s2024") s2024.add(SingleFEM.fromList(item));
        if (year == "s2025") s2025.add(SingleFEM.fromList(item));
        if (year == "s2026") s2026.add(SingleFEM.fromList(item));
        if (year == "s2027") s2027.add(SingleFEM.fromList(item));
        if (year == "s2028") s2028.add(SingleFEM.fromList(item));
        if (year == "e2022") e2022.add(SingleFEM.fromList(item));
        if (year == "e2023") e2023.add(SingleFEM.fromList(item));
        if (year == "e2024") e2024.add(SingleFEM.fromList(item));
        if (year == "e2025") e2025.add(SingleFEM.fromList(item));
        if (year == "e2026") e2026.add(SingleFEM.fromList(item));
        if (year == "e2027") e2027.add(SingleFEM.fromList(item));
        if (year == "e2028") e2028.add(SingleFEM.fromList(item));
        Map<String, dynamic> celda = jsonDecode(item[2])[0];
        List<String> keys = celda.keys.toList();
        for (int i = 0; i < keys.length; i++) {
          String key = keys[i];
          // String pedido = quincenas[key];
          int enPedido = 0;
          if (celda[key] is String) {
            enPedido = aEntero(celda[key]);
          } else {
            enPedido = celda[key] ?? 0;
          }
          int posicion = toPosOnList(key);
          int ctd = 0;
          if (item[posicion] is String) {
            ctd = aEntero(item[posicion]);
          } else {
            ctd = item[posicion] ?? 0;
          }
          if (enPedido == 1 && ctd > 0) {
            pedidosList.add(
              PedidosSingle(
                pedido: key,
                id: item[0].toString(),
                e4e: item[18].toString(),
                descripcion: item[19]
                    .toString()
                    .toString()
                    .replaceAll('"', '')
                    .replaceAll(';', '')
                    .replaceAll(',', ''),
                ctdi: ctd.toString(),
                ctdf: item[15].toString(),
                um: item[20].toString(),
                comentario: item[17]
                    .toString()
                    .replaceAll('"', '')
                    .replaceAll(';', '')
                    .replaceAll(',', '')
                    .replaceAll("\n", " "),
                solicitante: item[12]
                    .toString()
                    .replaceAll('"', '')
                    .replaceAll(';', '')
                    .replaceAll(',', '')
                    .replaceAll("\n", " "),
                tipoenvio: item[3].toString(),
                pdi: item[13].toString(),
                pdiname: 'pdiname',
                proyecto: item[9].toString(),
                ref: item[10].toString(),
                wbe: item[14].toString(),
                wbeproyecto: '',
                wbeparte: '',
                wbeestado: '',
                fecha: item[5].toString().length > 10
                    ? item[5].toString().substring(0, 10)
                    : item[5].toString(),
                estado: 'enFicha',
                lastperson: item[12].toString(),
              ),
            );
          }
          // try {
          // } catch (e) {
          //   print('item[posicion] = ${item[posicion]}');
          // }
          // let fila = {};
        }
        // print(keys);
      }
      ficha.sort((a, b) {
        int projectCompare = a.proyecto.compareTo(b.proyecto);
        if (projectCompare != 0) return projectCompare;
        return a.e4e.compareTo(b.e4e);
      });
    }

    Map femByE4e = {};
    for (SingleFEM reg in ficha) {
      if (femByE4e[reg.e4e] == null) {
        femByE4e[reg.e4e] = {
          'm01q1': 0,
          'm01q2': 0,
          'm01qx': 0,
          'm02q1': 0,
          'm02q2': 0,
          'm02qx': 0,
          'm03q1': 0,
          'm03q2': 0,
          'm03qx': 0,
          'm04q1': 0,
          'm04q2': 0,
          'm04qx': 0,
          'm05q1': 0,
          'm05q2': 0,
          'm05qx': 0,
          'm06q1': 0,
          'm06q2': 0,
          'm06qx': 0,
          'm07q1': 0,
          'm07q2': 0,
          'm07qx': 0,
          'm08q1': 0,
          'm08q2': 0,
          'm08qx': 0,
          'm09q1': 0,
          'm09q2': 0,
          'm09qx': 0,
          'm10q1': 0,
          'm10q2': 0,
          'm10qx': 0,
          'm11q1': 0,
          'm11q2': 0,
          'm11qx': 0,
          'm12q1': 0,
          'm12q2': 0,
          'm12qx': 0,
          'm01q1ped': 0,
          'm01q2ped': 0,
          'm02q1ped': 0,
          'm02q2ped': 0,
          'm03q1ped': 0,
          'm03q2ped': 0,
          'm04q1ped': 0,
          'm04q2ped': 0,
          'm05q1ped': 0,
          'm05q2ped': 0,
          'm06q1ped': 0,
          'm06q2ped': 0,
          'm07q1ped': 0,
          'm07q2ped': 0,
          'm08q1ped': 0,
          'm08q2ped': 0,
          'm09q1ped': 0,
          'm09q2ped': 0,
          'm10q1ped': 0,
          'm10q2ped': 0,
          'm11q1ped': 0,
          'm11q2ped': 0,
          'm12q1ped': 0,
          'm12q2ped': 0,
        };
      }
      femByE4e[reg.e4e]['m01q1'] += aDoble(reg.m01q1);
      femByE4e[reg.e4e]['m01q2'] += aDoble(reg.m01q2);
      femByE4e[reg.e4e]['m01qx'] += aDoble(reg.m01qx);
      femByE4e[reg.e4e]['m02q1'] += aDoble(reg.m02q1);
      femByE4e[reg.e4e]['m02q2'] += aDoble(reg.m02q2);
      femByE4e[reg.e4e]['m02qx'] += aDoble(reg.m02qx);
      femByE4e[reg.e4e]['m03q1'] += aDoble(reg.m03q1);
      femByE4e[reg.e4e]['m03q2'] += aDoble(reg.m03q2);
      femByE4e[reg.e4e]['m03qx'] += aDoble(reg.m03qx);
      femByE4e[reg.e4e]['m04q1'] += aDoble(reg.m04q1);
      femByE4e[reg.e4e]['m04q2'] += aDoble(reg.m04q2);
      femByE4e[reg.e4e]['m04qx'] += aDoble(reg.m04qx);
      femByE4e[reg.e4e]['m05q1'] += aDoble(reg.m05q1);
      femByE4e[reg.e4e]['m05q2'] += aDoble(reg.m05q2);
      femByE4e[reg.e4e]['m05qx'] += aDoble(reg.m05qx);
      femByE4e[reg.e4e]['m06q1'] += aDoble(reg.m06q1);
      femByE4e[reg.e4e]['m06q2'] += aDoble(reg.m06q2);
      femByE4e[reg.e4e]['m06qx'] += aDoble(reg.m06qx);
      femByE4e[reg.e4e]['m07q1'] += aDoble(reg.m07q1);
      femByE4e[reg.e4e]['m07q2'] += aDoble(reg.m07q2);
      femByE4e[reg.e4e]['m07qx'] += aDoble(reg.m07qx);
      femByE4e[reg.e4e]['m08q1'] += aDoble(reg.m08q1);
      femByE4e[reg.e4e]['m08q2'] += aDoble(reg.m08q2);
      femByE4e[reg.e4e]['m08qx'] += aDoble(reg.m08qx);
      femByE4e[reg.e4e]['m09q1'] += aDoble(reg.m09q1);
      femByE4e[reg.e4e]['m09q2'] += aDoble(reg.m09q2);
      femByE4e[reg.e4e]['m09qx'] += aDoble(reg.m09qx);
      femByE4e[reg.e4e]['m10q1'] += aDoble(reg.m10q1);
      femByE4e[reg.e4e]['m10q2'] += aDoble(reg.m10q2);
      femByE4e[reg.e4e]['m10qx'] += aDoble(reg.m10qx);
      femByE4e[reg.e4e]['m11q1'] += aDoble(reg.m11q1);
      femByE4e[reg.e4e]['m11q2'] += aDoble(reg.m11q2);
      femByE4e[reg.e4e]['m11qx'] += aDoble(reg.m11qx);
      femByE4e[reg.e4e]['m12q1'] += aDoble(reg.m12q1);
      femByE4e[reg.e4e]['m12q2'] += aDoble(reg.m12q2);
      femByE4e[reg.e4e]['m12qx'] += aDoble(reg.m12qx);
      femByE4e[reg.e4e]['m01q1ped'] += reg.m01q1ped;
      femByE4e[reg.e4e]['m01q2ped'] += reg.m01q2ped;
      femByE4e[reg.e4e]['m02q1ped'] += reg.m02q1ped;
      femByE4e[reg.e4e]['m02q2ped'] += reg.m02q2ped;
      femByE4e[reg.e4e]['m03q1ped'] += reg.m03q1ped;
      femByE4e[reg.e4e]['m03q2ped'] += reg.m03q2ped;
      femByE4e[reg.e4e]['m04q1ped'] += reg.m04q1ped;
      femByE4e[reg.e4e]['m04q2ped'] += reg.m04q2ped;
      femByE4e[reg.e4e]['m05q1ped'] += reg.m05q1ped;
      femByE4e[reg.e4e]['m05q2ped'] += reg.m05q2ped;
      femByE4e[reg.e4e]['m06q1ped'] += reg.m06q1ped;
      femByE4e[reg.e4e]['m06q2ped'] += reg.m06q2ped;
      femByE4e[reg.e4e]['m07q1ped'] += reg.m07q1ped;
      femByE4e[reg.e4e]['m07q2ped'] += reg.m07q2ped;
      femByE4e[reg.e4e]['m08q1ped'] += reg.m08q1ped;
      femByE4e[reg.e4e]['m08q2ped'] += reg.m08q2ped;
      femByE4e[reg.e4e]['m09q1ped'] += reg.m09q1ped;
      femByE4e[reg.e4e]['m09q2ped'] += reg.m09q2ped;
      femByE4e[reg.e4e]['m10q1ped'] += reg.m10q1ped;
      femByE4e[reg.e4e]['m10q2ped'] += reg.m10q2ped;
      femByE4e[reg.e4e]['m11q1ped'] += reg.m11q1ped;
      femByE4e[reg.e4e]['m11q2ped'] += reg.m11q2ped;
      femByE4e[reg.e4e]['m12q1ped'] += reg.m12q1ped;
      femByE4e[reg.e4e]['m12q2ped'] += reg.m12q2ped;
    }
    List<FemSumSingle> fichaSum = f2022Sum;
    if (year == "f2022") fichaSum = f2022Sum;
    if (year == "f2023") fichaSum = f2023Sum;
    if (year == "f2024") fichaSum = f2024Sum;
    if (year == "f2025") fichaSum = f2025Sum;
    if (year == "f2026") fichaSum = f2026Sum;
    if (year == "f2027") fichaSum = f2027Sum;
    if (year == "f2028") fichaSum = f2028Sum;

    for (var key in femByE4e.keys) {
      Map item = femByE4e[key];
      fichaSum.add(
        FemSumSingle(
          e4e: key.toString(),
          m01q1: item['m01q1'].round().toString(),
          m01q2: item['m01q2'].round().toString(),
          m01qx: item['m01qx'].round().toString(),
          m02q1: item['m02q1'].round().toString(),
          m02q2: item['m02q2'].round().toString(),
          m02qx: item['m02qx'].round().toString(),
          m03q1: item['m03q1'].round().toString(),
          m03q2: item['m03q2'].round().toString(),
          m03qx: item['m03qx'].round().toString(),
          m04q1: item['m04q1'].round().toString(),
          m04q2: item['m04q2'].round().toString(),
          m04qx: item['m04qx'].round().toString(),
          m05q1: item['m05q1'].round().toString(),
          m05q2: item['m05q2'].round().toString(),
          m05qx: item['m05qx'].round().toString(),
          m06q1: item['m06q1'].round().toString(),
          m06q2: item['m06q2'].round().toString(),
          m06qx: item['m06qx'].round().toString(),
          m07q1: item['m07q1'].round().toString(),
          m07q2: item['m07q2'].round().toString(),
          m07qx: item['m07qx'].round().toString(),
          m08q1: item['m08q1'].round().toString(),
          m08q2: item['m08q2'].round().toString(),
          m08qx: item['m08qx'].round().toString(),
          m09q1: item['m09q1'].round().toString(),
          m09q2: item['m09q2'].round().toString(),
          m09qx: item['m09qx'].round().toString(),
          m10q1: item['m10q1'].round().toString(),
          m10q2: item['m10q2'].round().toString(),
          m10qx: item['m10qx'].round().toString(),
          m11q1: item['m11q1'].round().toString(),
          m11q2: item['m11q2'].round().toString(),
          m11qx: item['m11qx'].round().toString(),
          m12q1: item['m12q1'].round().toString(),
          m12q2: item['m12q2'].round().toString(),
          m12qx: item['m12qx'].round().toString(),
          m01q1ped: item['m01q1ped'],
          m01q2ped: item['m01q2ped'],
          m02q1ped: item['m02q1ped'],
          m02q2ped: item['m02q2ped'],
          m03q1ped: item['m03q1ped'],
          m03q2ped: item['m03q2ped'],
          m04q1ped: item['m04q1ped'],
          m04q2ped: item['m04q2ped'],
          m05q1ped: item['m05q1ped'],
          m05q2ped: item['m05q2ped'],
          m06q1ped: item['m06q1ped'],
          m06q2ped: item['m06q2ped'],
          m07q1ped: item['m07q1ped'],
          m07q2ped: item['m07q2ped'],
          m08q1ped: item['m08q1ped'],
          m08q2ped: item['m08q2ped'],
          m09q1ped: item['m09q1ped'],
          m09q2ped: item['m09q2ped'],
          m10q1ped: item['m10q1ped'],
          m10q2ped: item['m10q2ped'],
          m11q1ped: item['m11q1ped'],
          m11q2ped: item['m11q2ped'],
          m12q1ped: item['m12q1ped'],
          m12q2ped: item['m12q2ped'],
        ),
      );
    }
    // for (SingleFEM element in ficha) {
    //   // //wait 1 ms
    //   // await Future.delayed(const Duration(microseconds: 1));
    //   pedidosList.addAll(element.pedidosList);
    // }
  }

  femSum() {
    f2022Sum = [];
    f2023Sum = [];
    f2024Sum = [];
    f2025Sum = [];
    f2026Sum = [];
    f2027Sum = [];
    f2028Sum = [];
    List<String> years = [
      'f2022',
      'f2023',
      'f2024',
      'f2025',
      'f2026',
      'f2027',
      'f2028'
    ];

    // print(f2023.where((e) => e.id == '2023000002'));
    for (String year in years) {
      List<SingleFEM> ficha = f2022;

      if (year == "f2022") ficha = f2022;
      if (year == "f2023") ficha = f2023;
      if (year == "f2024") ficha = f2024;
      if (year == "f2025") ficha = f2025;
      if (year == "f2026") ficha = f2026;
      if (year == "f2027") ficha = f2027;
      if (year == "f2028") ficha = f2028;

      Map femByE4e = {};
      for (SingleFEM reg in ficha) {
        if (femByE4e[reg.e4e] == null) {
          femByE4e[reg.e4e] = {
            'm01q1': 0,
            'm01q2': 0,
            'm01qx': 0,
            'm02q1': 0,
            'm02q2': 0,
            'm02qx': 0,
            'm03q1': 0,
            'm03q2': 0,
            'm03qx': 0,
            'm04q1': 0,
            'm04q2': 0,
            'm04qx': 0,
            'm05q1': 0,
            'm05q2': 0,
            'm05qx': 0,
            'm06q1': 0,
            'm06q2': 0,
            'm06qx': 0,
            'm07q1': 0,
            'm07q2': 0,
            'm07qx': 0,
            'm08q1': 0,
            'm08q2': 0,
            'm08qx': 0,
            'm09q1': 0,
            'm09q2': 0,
            'm09qx': 0,
            'm10q1': 0,
            'm10q2': 0,
            'm10qx': 0,
            'm11q1': 0,
            'm11q2': 0,
            'm11qx': 0,
            'm12q1': 0,
            'm12q2': 0,
            'm12qx': 0,
            'm01q1ped': 0,
            'm01q2ped': 0,
            'm02q1ped': 0,
            'm02q2ped': 0,
            'm03q1ped': 0,
            'm03q2ped': 0,
            'm04q1ped': 0,
            'm04q2ped': 0,
            'm05q1ped': 0,
            'm05q2ped': 0,
            'm06q1ped': 0,
            'm06q2ped': 0,
            'm07q1ped': 0,
            'm07q2ped': 0,
            'm08q1ped': 0,
            'm08q2ped': 0,
            'm09q1ped': 0,
            'm09q2ped': 0,
            'm10q1ped': 0,
            'm10q2ped': 0,
            'm11q1ped': 0,
            'm11q2ped': 0,
            'm12q1ped': 0,
            'm12q2ped': 0,
          };
        }
        femByE4e[reg.e4e]['m01q1'] += aDoble(reg.m01q1);
        femByE4e[reg.e4e]['m01q2'] += aDoble(reg.m01q2);
        femByE4e[reg.e4e]['m01qx'] += aDoble(reg.m01qx);
        femByE4e[reg.e4e]['m02q1'] += aDoble(reg.m02q1);
        femByE4e[reg.e4e]['m02q2'] += aDoble(reg.m02q2);
        femByE4e[reg.e4e]['m02qx'] += aDoble(reg.m02qx);
        femByE4e[reg.e4e]['m03q1'] += aDoble(reg.m03q1);
        femByE4e[reg.e4e]['m03q2'] += aDoble(reg.m03q2);
        femByE4e[reg.e4e]['m03qx'] += aDoble(reg.m03qx);
        femByE4e[reg.e4e]['m04q1'] += aDoble(reg.m04q1);
        femByE4e[reg.e4e]['m04q2'] += aDoble(reg.m04q2);
        femByE4e[reg.e4e]['m04qx'] += aDoble(reg.m04qx);
        femByE4e[reg.e4e]['m05q1'] += aDoble(reg.m05q1);
        femByE4e[reg.e4e]['m05q2'] += aDoble(reg.m05q2);
        femByE4e[reg.e4e]['m05qx'] += aDoble(reg.m05qx);
        femByE4e[reg.e4e]['m06q1'] += aDoble(reg.m06q1);
        femByE4e[reg.e4e]['m06q2'] += aDoble(reg.m06q2);
        femByE4e[reg.e4e]['m06qx'] += aDoble(reg.m06qx);
        femByE4e[reg.e4e]['m07q1'] += aDoble(reg.m07q1);
        femByE4e[reg.e4e]['m07q2'] += aDoble(reg.m07q2);
        femByE4e[reg.e4e]['m07qx'] += aDoble(reg.m07qx);
        femByE4e[reg.e4e]['m08q1'] += aDoble(reg.m08q1);
        femByE4e[reg.e4e]['m08q2'] += aDoble(reg.m08q2);
        femByE4e[reg.e4e]['m08qx'] += aDoble(reg.m08qx);
        femByE4e[reg.e4e]['m09q1'] += aDoble(reg.m09q1);
        femByE4e[reg.e4e]['m09q2'] += aDoble(reg.m09q2);
        femByE4e[reg.e4e]['m09qx'] += aDoble(reg.m09qx);
        femByE4e[reg.e4e]['m10q1'] += aDoble(reg.m10q1);
        femByE4e[reg.e4e]['m10q2'] += aDoble(reg.m10q2);
        femByE4e[reg.e4e]['m10qx'] += aDoble(reg.m10qx);
        femByE4e[reg.e4e]['m11q1'] += aDoble(reg.m11q1);
        femByE4e[reg.e4e]['m11q2'] += aDoble(reg.m11q2);
        femByE4e[reg.e4e]['m11qx'] += aDoble(reg.m11qx);
        femByE4e[reg.e4e]['m12q1'] += aDoble(reg.m12q1);
        femByE4e[reg.e4e]['m12q2'] += aDoble(reg.m12q2);
        femByE4e[reg.e4e]['m12qx'] += aDoble(reg.m12qx);
        femByE4e[reg.e4e]['m01q1ped'] += reg.m01q1ped;
        femByE4e[reg.e4e]['m01q2ped'] += reg.m01q2ped;
        femByE4e[reg.e4e]['m02q1ped'] += reg.m02q1ped;
        femByE4e[reg.e4e]['m02q2ped'] += reg.m02q2ped;
        femByE4e[reg.e4e]['m03q1ped'] += reg.m03q1ped;
        femByE4e[reg.e4e]['m03q2ped'] += reg.m03q2ped;
        femByE4e[reg.e4e]['m04q1ped'] += reg.m04q1ped;
        femByE4e[reg.e4e]['m04q2ped'] += reg.m04q2ped;
        femByE4e[reg.e4e]['m05q1ped'] += reg.m05q1ped;
        femByE4e[reg.e4e]['m05q2ped'] += reg.m05q2ped;
        femByE4e[reg.e4e]['m06q1ped'] += reg.m06q1ped;
        femByE4e[reg.e4e]['m06q2ped'] += reg.m06q2ped;
        femByE4e[reg.e4e]['m07q1ped'] += reg.m07q1ped;
        femByE4e[reg.e4e]['m07q2ped'] += reg.m07q2ped;
        femByE4e[reg.e4e]['m08q1ped'] += reg.m08q1ped;
        femByE4e[reg.e4e]['m08q2ped'] += reg.m08q2ped;
        femByE4e[reg.e4e]['m09q1ped'] += reg.m09q1ped;
        femByE4e[reg.e4e]['m09q2ped'] += reg.m09q2ped;
        femByE4e[reg.e4e]['m10q1ped'] += reg.m10q1ped;
        femByE4e[reg.e4e]['m10q2ped'] += reg.m10q2ped;
        femByE4e[reg.e4e]['m11q1ped'] += reg.m11q1ped;
        femByE4e[reg.e4e]['m11q2ped'] += reg.m11q2ped;
        femByE4e[reg.e4e]['m12q1ped'] += reg.m12q1ped;
        femByE4e[reg.e4e]['m12q2ped'] += reg.m12q2ped;
      }
      List<FemSumSingle> fichaSum = f2022Sum;
      if (year == "f2022") fichaSum = f2022Sum;
      if (year == "f2023") fichaSum = f2023Sum;
      if (year == "f2024") fichaSum = f2024Sum;
      if (year == "f2025") fichaSum = f2025Sum;
      if (year == "f2026") fichaSum = f2026Sum;
      if (year == "f2027") fichaSum = f2027Sum;
      if (year == "f2028") fichaSum = f2028Sum;

      for (var key in femByE4e.keys) {
        Map item = femByE4e[key];
        fichaSum.add(
          FemSumSingle(
            e4e: key.toString(),
            m01q1: item['m01q1'].round().toString(),
            m01q2: item['m01q2'].round().toString(),
            m01qx: item['m01qx'].round().toString(),
            m02q1: item['m02q1'].round().toString(),
            m02q2: item['m02q2'].round().toString(),
            m02qx: item['m02qx'].round().toString(),
            m03q1: item['m03q1'].round().toString(),
            m03q2: item['m03q2'].round().toString(),
            m03qx: item['m03qx'].round().toString(),
            m04q1: item['m04q1'].round().toString(),
            m04q2: item['m04q2'].round().toString(),
            m04qx: item['m04qx'].round().toString(),
            m05q1: item['m05q1'].round().toString(),
            m05q2: item['m05q2'].round().toString(),
            m05qx: item['m05qx'].round().toString(),
            m06q1: item['m06q1'].round().toString(),
            m06q2: item['m06q2'].round().toString(),
            m06qx: item['m06qx'].round().toString(),
            m07q1: item['m07q1'].round().toString(),
            m07q2: item['m07q2'].round().toString(),
            m07qx: item['m07qx'].round().toString(),
            m08q1: item['m08q1'].round().toString(),
            m08q2: item['m08q2'].round().toString(),
            m08qx: item['m08qx'].round().toString(),
            m09q1: item['m09q1'].round().toString(),
            m09q2: item['m09q2'].round().toString(),
            m09qx: item['m09qx'].round().toString(),
            m10q1: item['m10q1'].round().toString(),
            m10q2: item['m10q2'].round().toString(),
            m10qx: item['m10qx'].round().toString(),
            m11q1: item['m11q1'].round().toString(),
            m11q2: item['m11q2'].round().toString(),
            m11qx: item['m11qx'].round().toString(),
            m12q1: item['m12q1'].round().toString(),
            m12q2: item['m12q2'].round().toString(),
            m12qx: item['m12qx'].round().toString(),
            m01q1ped: item['m01q1ped'],
            m01q2ped: item['m01q2ped'],
            m02q1ped: item['m02q1ped'],
            m02q2ped: item['m02q2ped'],
            m03q1ped: item['m03q1ped'],
            m03q2ped: item['m03q2ped'],
            m04q1ped: item['m04q1ped'],
            m04q2ped: item['m04q2ped'],
            m05q1ped: item['m05q1ped'],
            m05q2ped: item['m05q2ped'],
            m06q1ped: item['m06q1ped'],
            m06q2ped: item['m06q2ped'],
            m07q1ped: item['m07q1ped'],
            m07q2ped: item['m07q2ped'],
            m08q1ped: item['m08q1ped'],
            m08q2ped: item['m08q2ped'],
            m09q1ped: item['m09q1ped'],
            m09q2ped: item['m09q2ped'],
            m10q1ped: item['m10q1ped'],
            m10q2ped: item['m10q2ped'],
            m11q1ped: item['m11q1ped'],
            m11q2ped: item['m11q2ped'],
            m12q1ped: item['m12q1ped'],
            m12q2ped: item['m12q2ped'],
          ),
        );
      }
    }
  }

  aDoble(String valor) {
    if (valor == "") {
      return 0.0;
    } else {
      return double.parse(valor);
    }
  }

  Future<String> enviar(String year, SingleFEM singleFEM) async {
    DateTime date = DateTime.now();
    String fecha =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    singleFEM.solicitante = FirebaseAuth.instance.currentUser!.email!;
    singleFEM.fechacambio = fecha;
    var dataSend = {
      'dataReq': {'year': 'f$year', 'val': singleFEM.toMap()},
      'fname': "modFemDB"
    };
    print('FEM_MODEL enviar: ${jsonEncode(dataSend)}');
    final response = await http.post(
      Uri.parse(
          Api.fem),
      body: jsonEncode(dataSend),
    );
    // print(response.body);
    // ignore: unused_local_variable
    var dataAsListMap;
    if (response.statusCode == 302) {
      var response2 = await http.get(Uri.parse(
          response.headers["location"].toString().replaceAll(',', '')));
      dataAsListMap = jsonDecode(response2.body);
    } else {
      dataAsListMap = jsonDecode(response.body);
    }
    return dataAsListMap.toString();
    // print(dataAsListMap);
  }

  List<Map<String, dynamic>> groupByList(
    List<Map<String, dynamic>> data,
    List<String> keysToSelect,
    List<String> keysToSum,
  ) {
    // print('groupByList from forecast model');
    // print(keysToSelect);
    List<Map<String, dynamic>> dataKeyAsJson = data.map((e) {
      e['asJson'] = {};
      for (var key in keysToSelect) {
        e['asJson'].addAll({key: e[key]});
        e.remove(key);
      }
      e['asJson'] = jsonEncode(e['asJson']);
      return e;
    }).toList();
    // print('dataKeyAsJson = $dataKeyAsJson');

    Map<dynamic, Map<String, double>> groupAsMap =
        groupBy(dataKeyAsJson, (Map e) => e['asJson'])
            .map((key, value) => MapEntry(key, {
                  for (var keySum in keysToSum)
                    keySum: value.fold<double>(
                        0, (p, a) => p + (a[keySum] as double))
                }));
    // print('groupAsMap = $groupAsMap');

    List<Map<String, dynamic>> result = groupAsMap.entries.map((e) {
      Map<String, dynamic> newMap = jsonDecode(e.key);
      return {...newMap, ...e.value};
    }).toList();
    // print('result = $result');

    return result;
  }
}



int toPosOnList(String key) {
  if (RegExp(r"^01\|.*-1$").hasMatch(key)) return 21;
  if (RegExp(r"^01\|.*-2$").hasMatch(key)) return 22;
  if (RegExp(r"^01\|.*-x$").hasMatch(key)) return 23;
  if (RegExp(r"^02\|.*-1$").hasMatch(key)) return 24;
  if (RegExp(r"^02\|.*-2$").hasMatch(key)) return 25;
  if (RegExp(r"^02\|.*-x$").hasMatch(key)) return 26;
  if (RegExp(r"^03\|.*-1$").hasMatch(key)) return 27;
  if (RegExp(r"^03\|.*-2$").hasMatch(key)) return 28;
  if (RegExp(r"^03\|.*-x$").hasMatch(key)) return 29;
  if (RegExp(r"^04\|.*-1$").hasMatch(key)) return 30;
  if (RegExp(r"^04\|.*-2$").hasMatch(key)) return 31;
  if (RegExp(r"^04\|.*-x$").hasMatch(key)) return 32;
  if (RegExp(r"^05\|.*-1$").hasMatch(key)) return 33;
  if (RegExp(r"^05\|.*-2$").hasMatch(key)) return 34;
  if (RegExp(r"^05\|.*-x$").hasMatch(key)) return 35;
  if (RegExp(r"^06\|.*-1$").hasMatch(key)) return 36;
  if (RegExp(r"^06\|.*-2$").hasMatch(key)) return 37;
  if (RegExp(r"^06\|.*-x$").hasMatch(key)) return 38;
  if (RegExp(r"^07\|.*-1$").hasMatch(key)) return 39;
  if (RegExp(r"^07\|.*-2$").hasMatch(key)) return 40;
  if (RegExp(r"^07\|.*-x$").hasMatch(key)) return 41;
  if (RegExp(r"^08\|.*-1$").hasMatch(key)) return 42;
  if (RegExp(r"^08\|.*-2$").hasMatch(key)) return 43;
  if (RegExp(r"^08\|.*-x$").hasMatch(key)) return 44;
  if (RegExp(r"^09\|.*-1$").hasMatch(key)) return 45;
  if (RegExp(r"^09\|.*-2$").hasMatch(key)) return 46;
  if (RegExp(r"^09\|.*-x$").hasMatch(key)) return 47;
  if (RegExp(r"^10\|.*-1$").hasMatch(key)) return 48;
  if (RegExp(r"^10\|.*-2$").hasMatch(key)) return 49;
  if (RegExp(r"^10\|.*-x$").hasMatch(key)) return 50;
  if (RegExp(r"^11\|.*-1$").hasMatch(key)) return 51;
  if (RegExp(r"^11\|.*-2$").hasMatch(key)) return 52;
  if (RegExp(r"^11\|.*-x$").hasMatch(key)) return 53;
  if (RegExp(r"^12\|.*-1$").hasMatch(key)) return 54;
  if (RegExp(r"^12\|.*-2$").hasMatch(key)) return 55;
  if (RegExp(r"^12\|.*-x$").hasMatch(key)) return 56;
  return 0;
}
