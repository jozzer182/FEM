import 'dart:convert';

import 'package:collection/collection.dart';
// import 'package:fem_app/fechas_fem/fechasfem_model.dart';
import 'package:intl/intl.dart';
import 'package:fem_app/oe/model/oe_model.dart';

class OeSum {
  List<OeSumSingle>? oeSumList;

  crear({
    // required FechasFEM fechasFEM,
    required Oe oe,
  }) {
    // print('entrando a OeSUM');
    // DateTime fecha = DateFormat('yyyy-MM-dd').parse(
    //   fechasFEM.fechasFEMList
    //       .firstWhere((e) => e.versionestado == 'true')
    //       .fechadelivery,
    // );
    // print('fecha: $fecha');
    if (oe.oeList.isNotEmpty) {
      DateTime fechaActual = DateTime.now();
      int ano = fechaActual.year;
      int mes = fechaActual.month;
      DateTime fechaMes = DateTime(ano, mes, 1);
      int mesesParaQuatrimestre = 0;
      for (var i = mes; i < 17; i++) {
        if (((i - mes) >= 4) && (i % 4 == 0)) {
          mesesParaQuatrimestre = i - mes;
          i = 17;
        }
      }
      DateTime fechaFinal =
          fechaMes.add(Duration(days: mesesParaQuatrimestre * 31));

      var oeByE4e = {};
      for (OeSingle orden in oe.oeList) {
        DateTime fechaOrden = DateFormat('yyyy-MM-dd').parse(orden.fecha);
        if (fechaOrden.difference(fechaActual).inDays > 0 &&
            fechaFinal.difference(fechaOrden).inDays > 0) {
          if (oeByE4e[orden.e4e] == null) {
            oeByE4e[orden.e4e] = {'ctd': 0.0};
          }
          oeByE4e[orden.e4e]['ctd'] += double.parse(orden.ctd);
        }
      }

      oeSumList = [];
      for (var key in oeByE4e.keys) {
        Map item = oeByE4e[key];
        oeSumList?.add(
          OeSumSingle(
            e4e: key,
            ctd: item['ctd'].round().toString(),
          ),
        );
      }
      // print('oeSumList: $oeSumList');
    }
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

class OeSumSingle {
  String e4e;
  String ctd;
  OeSumSingle({
    required this.e4e,
    required this.ctd,
  });

  OeSumSingle copyWith({
    String? e4e,
    String? ctd,
  }) {
    return OeSumSingle(
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

  factory OeSumSingle.fromMap(Map<String, dynamic> map) {
    return OeSumSingle(
      e4e: map['e4e'] ?? '',
      ctd: map['ctd'] ?? '',
    );
  }

  factory OeSumSingle.fromZero() {
    return OeSumSingle(
      e4e: '',
      ctd: '0',
    );
  }

  String toJson() => json.encode(toMap());

  factory OeSumSingle.fromJson(String source) =>
      OeSumSingle.fromMap(json.decode(source));

  @override
  String toString() => 'OeSumSingle(e4e: $e4e, ctd: $ctd)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OeSumSingle && other.e4e == e4e && other.ctd == ctd;
  }

  @override
  int get hashCode => e4e.hashCode ^ ctd.hashCode;
}
