import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:fem_app/fechas_fem/model/fechasfem_model.dart';
import 'package:fem_app/fem/model/fem_model.dart';

import 'fem_sumsingle_model.dart';

class FemDemand {
  List<FemDemandSingle> femDemandList = [];
  List<FemDemandSingle> femDemandSumList = [];

  crear({
    required FechasFEM fechasFEM,
    required Fem fem,
  }) {
    // print('FemDemand.crear()');
    femDemandList = [];
    femDemandSumList = [];
    List<FechasFEMSingle> pedidosPendientes = fechasFEM.fechasFEMList
        .where((e) => e.versionestado == 'false' && e.delivered == 'false')
        .toList();
    // print('pedidosPendientes ${pedidosPendientes}');
    Map e4eSum = {};
    List<FemSumSingle> fichaSum = fem.f2022Sum;
    for (FechasFEMSingle pedido in pedidosPendientes) {
      // print('pedido: ${pedido.pedido}');
      if (pedido.ano == "2022") fichaSum = fem.f2022Sum;
      if (pedido.ano == "2023") fichaSum = fem.f2023Sum;
      if (pedido.ano == "2024") fichaSum = fem.f2024Sum;
      if (pedido.ano == "2025") fichaSum = fem.f2025Sum;
      if (pedido.ano == "2026") fichaSum = fem.f2026Sum;
      if (pedido.ano == "2027") fichaSum = fem.f2027Sum;
      if (pedido.ano == "2028") fichaSum = fem.f2028Sum;
      for (FemSumSingle e in fichaSum) {
        if (e4eSum[e.e4e] == null) {
          e4eSum[e.e4e] = {
            'ctd': 0.0,
          };
        }
        e4eSum[e.e4e]['ctd'] += double.parse(e.toMap()[
            'm${pedido.pedido.substring(0, 2).padLeft(2, '0')}q${pedido.pedido[pedido.pedido.length - 1]}']);
      }
    }
    for (var key in e4eSum.keys) {
      Map item = e4eSum[key];
      femDemandSumList.add(FemDemandSingle(
        e4e: key,
        ctd: item['ctd'].round().toString(),
      ));
    }

    // print('femDemandSumList: ${femDemandSumList.where((e) => e.e4e == "140991")}');
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

class FemDemandSingle {
  String e4e;
  String ctd;
  FemDemandSingle({
    required this.e4e,
    required this.ctd,
  });

  FemDemandSingle copyWith({
    String? e4e,
    String? ctd,
  }) {
    return FemDemandSingle(
      e4e: e4e ?? this.e4e,
      ctd: ctd ?? this.ctd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'e4e': e4e,
      'ctd': ctd,
    };
  }

  factory FemDemandSingle.fromMap(Map<String, dynamic> map) {
    return FemDemandSingle(
      e4e: map['e4e'] ?? '',
      ctd: map['ctd'] ?? '',
    );
  }

  factory FemDemandSingle.fromZero() {
    return FemDemandSingle(
      e4e: '0',
      ctd: '0',
    );
  }

  String toJson() => json.encode(toMap());

  factory FemDemandSingle.fromJson(String source) =>
      FemDemandSingle.fromMap(json.decode(source));

  @override
  String toString() => 'FemDemandSingle(e4e: $e4e, ctd: $ctd)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FemDemandSingle && other.e4e == e4e && other.ctd == ctd;
  }

  @override
  int get hashCode => e4e.hashCode ^ ctd.hashCode;
}
