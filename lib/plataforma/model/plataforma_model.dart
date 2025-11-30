import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:fem_app/resources/titulo.dart';

import '../../resources/a_entero_2.dart';
import '../../resources/constant/apis.dart';

class Plataforma {
  List<PlataformaSingle> plataformaList = [];
  List<PlataformaSingle> plataformaListSearch = [];
  List<PlataformaSumSingle> plataformaSumList = [];
  Map plataformaByE4e = {};
  int view = 70;
  bool loading = false;
  List<ToCelda> titles = [
    ToCelda(valor: 'E4e', flex: 2),
    ToCelda(valor: 'Descripción', flex: 6),
    ToCelda(valor: 'Um', flex: 2),
    ToCelda(valor: 'Ctd', flex: 2),
    ToCelda(valor: 'Proyecto (WBE)', flex: 6),
  ];

  buscar(String busqueda) {
    plataformaListSearch = plataformaList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  Future<List<PlataformaSingle>> obtener() async {
    var dataSend = {
      'dataReq': {'hoja': 'PLATAFORMA_MB52'},
      'fname': "getSAPList"
    };
    final response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    var dataAsListMap;
    if (response.statusCode == 302) {
      var response2 = await get(Uri.parse(response.headers["location"] ?? ''));
      dataAsListMap = jsonDecode(response2.body);
    } else {
      dataAsListMap = jsonDecode(response.body);
    }
    // print('dataAsListMap: $dataAsListMap');
    // print(dataAsListMap[0]);
    for (var item in dataAsListMap.sublist(1)) {
      plataformaList.add(PlataformaSingle.fromList(item));
    }

    // print('plataformaList: ${plataformaList}');

    plataformaList.sort((a, b) => a.material.compareTo(b.material));
    plataformaListSearch = [...plataformaList];
    if (plataformaList.isNotEmpty) {
      for (PlataformaSingle reg in plataformaList) {
        if (plataformaByE4e[reg.material] == null) {
          plataformaByE4e[reg.material] = {
            'descripcion': reg.descripcion,
            'ctd': 0,
          };
        }
        plataformaByE4e[reg.material]['ctd'] += aEntero(reg.ctd);
      }
      var dataAsListMap = plataformaList.map((e) {
        // print('e: $e');
        return {
          ...e.toMap(),
          ...{
            'ctd': int.parse(e.ctd),
            'valor': int.parse(e.valor),
          }
        };
      }).toList();
      List<String> keysToSelect = ['material'];
      List<String> keysToSum = ['ctd', 'valor'];
      List<Map<String, dynamic>> porE4e =
          groupByList(dataAsListMap, keysToSelect, keysToSum);
      for (Map e in porE4e) {
        plataformaSumList.add(
          PlataformaSumSingle(
            e4e: e['material'],
            ctd: e['ctd'].toString(),
            valor: e['valor'].toString(),
          ),
        );
        // print('plataformaSumList: ${plataformaSumList}');
      }
    }
    return plataformaList;
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

    Map<dynamic, Map<String, int>> groupAsMap =
        groupBy(dataKeyAsJson, (Map e) => e['asJson'])
            .map((key, value) => MapEntry(key, {
                  for (var keySum in keysToSum)
                    keySum: value.fold<int>(0, (p, a) => p + (a[keySum] as int))
                }));
    // print('groupAsMap = $groupAsMap');

    List<Map<String, dynamic>> result = groupAsMap.entries.map((e) {
      Map<String, dynamic> newMap = jsonDecode(e.key);
      return {...newMap, ...e.value};
    }).toList();
    // print('result = $result');

    return result;
  }

  @override
  String toString() => 'Plataforma(plataforma: $plataformaList)';
}

class PlataformaSumSingle {
  String e4e;
  String ctd;
  String valor;
  PlataformaSumSingle({
    required this.e4e,
    required this.ctd,
    required this.valor,
  });

  PlataformaSumSingle copyWith({
    String? e4e,
    String? ctd,
    String? valor,
  }) {
    return PlataformaSumSingle(
      e4e: e4e ?? this.e4e,
      ctd: ctd ?? this.ctd,
      valor: valor ?? this.valor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'e4e': e4e,
      'ctd': ctd,
      'valor': valor,
    };
  }

  factory PlataformaSumSingle.fromMap(Map<String, dynamic> map) {
    return PlataformaSumSingle(
      e4e: map['e4e'] ?? '',
      ctd: map['ctd'] ?? '',
      valor: map['valor'] ?? '',
    );
  }

  factory PlataformaSumSingle.fromZero() {
    return PlataformaSumSingle(
      e4e: '',
      ctd: '0',
      valor: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlataformaSumSingle.fromJson(String source) =>
      PlataformaSumSingle.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlataformaSumSingle(e4e: $e4e, ctd: $ctd, valor: $valor)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlataformaSumSingle &&
        other.e4e == e4e &&
        other.ctd == ctd &&
        other.valor == valor;
  }

  @override
  int get hashCode => e4e.hashCode ^ ctd.hashCode ^ valor.hashCode;
}

class PlataformaSingle {
  String material;
  String descripcion;
  String umb;
  String ctd;
  String valor;
  String proyecto;
  String parte_proyecto;
  String wbe;
  String status;
  String actualizado;
  PlataformaSingle({
    required this.material,
    required this.descripcion,
    required this.umb,
    required this.ctd,
    required this.valor,
    required this.proyecto,
    required this.parte_proyecto,
    required this.wbe,
    required this.status,
    required this.actualizado,
  });

  PlataformaSingle copyWith({
    String? material,
    String? descripcion,
    String? umb,
    String? ctd,
    String? valor,
    String? proyecto,
    String? parte_proyecto,
    String? wbe,
    String? status,
    String? actualizado,
  }) {
    return PlataformaSingle(
      material: material ?? this.material,
      descripcion: descripcion ?? this.descripcion,
      umb: umb ?? this.umb,
      ctd: ctd ?? this.ctd,
      valor: valor ?? this.valor,
      proyecto: proyecto ?? this.proyecto,
      parte_proyecto: parte_proyecto ?? this.parte_proyecto,
      wbe: wbe ?? this.wbe,
      status: status ?? this.status,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'material': material,
      'descripcion': descripcion,
      'umb': umb,
      'ctd': ctd,
      'valor': valor,
      'proyecto': proyecto,
      'parte_proyecto': parte_proyecto,
      'wbe': wbe,
      'status': status,
      'actualizado': actualizado,
    };
  }

  factory PlataformaSingle.fromMap(Map<String, dynamic> map) {
    return PlataformaSingle(
      material: map['material'].toString(),
      descripcion: map['descripcion'].toString(),
      umb: map['umb'].toString(),
      ctd: map['ctd'].toString(),
      valor: map['valor'].toString(),
      proyecto: map['proyecto'].toString(),
      parte_proyecto: map['parte_proyecto'].toString(),
      wbe: map['wbe'].toString(),
      status: map['status'].toString(),
      actualizado: map['actualizado'].toString(),
    );
  }

  factory PlataformaSingle.fromList(List<dynamic> list) {
    return PlataformaSingle(
      material: list[0].toString(),
      descripcion: list[1].toString(),
      umb: list[2].toString(),
      ctd: list[3].toString(),
      valor: list[4].toString(),
      proyecto: list[6].toString(),
      parte_proyecto: list[7].toString(),
      wbe: list[5].toString(),
      status: list[8].toString(),
      actualizado: list[9].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlataformaSingle.fromJson(String source) =>
      PlataformaSingle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlataformaSingle(material: $material, descripcion: $descripcion, umb: $umb, ctd: $ctd, valor: $valor, proyecto: $proyecto, parte_proyecto: $parte_proyecto, wbe: $wbe, status: $status, actualizado: $actualizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlataformaSingle &&
        other.material == material &&
        other.descripcion == descripcion &&
        other.umb == umb &&
        other.ctd == ctd &&
        other.valor == valor &&
        other.proyecto == proyecto &&
        other.parte_proyecto == parte_proyecto &&
        other.wbe == wbe &&
        other.status == status &&
        other.actualizado == actualizado;
  }

  @override
  int get hashCode {
    return material.hashCode ^
        descripcion.hashCode ^
        umb.hashCode ^
        ctd.hashCode ^
        valor.hashCode ^
        proyecto.hashCode ^
        parte_proyecto.hashCode ^
        wbe.hashCode ^
        status.hashCode ^
        actualizado.hashCode;
  }

  List<String> toList() {
    return [
      material,
      descripcion,
      umb,
      ctd,
      valor,
      proyecto,
      parte_proyecto,
      wbe,
      status,
      actualizado,
    ];
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: material, flex: 2),
        ToCelda(valor: descripcion, flex: 6),
        ToCelda(valor: umb, flex: 2),
        ToCelda(valor: ctd, flex: 2),
        ToCelda(valor: proyecto, flex: 6),
      ];
}
