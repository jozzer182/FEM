import 'dart:convert';
import 'package:fem_app/resources/titulo.dart';
import 'package:http/http.dart';

import '../../resources/constant/apis.dart';

class Pdis {
  List<PdisSingle> pdisList = [];
  List<PdisSingle> pdisListSearch = [];
  int view = 70;
  Map itemsAndFlex = {
    'lote': [2, 'lote'],
    'almacen': [2, 'almacén'],
  };

  get keys {
    return itemsAndFlex.keys.toList();
  }

  get listaTitulo {
    return [
      for (var key in keys)
        {'texto': itemsAndFlex[key][1], 'flex': itemsAndFlex[key][0]},
    ];
  }

  List<ToCelda> titles = [
    ToCelda(valor: 'Lote', flex: 2),
    ToCelda(valor: 'Almacén', flex: 2),
  ];

  obtener() async {
    Map<String, Object> dataSend = {
      'dataReq': {'libro': 'PDIS', 'hoja': 'reg'},
      'fname': "getHojaList"
    };
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
      // print(item);
      pdisList.add(PdisSingle.fromList(item));
    }
    // print(pdisList);
    pdisListSearch = [...pdisList];
  }

  buscar(String busqueda) {
    pdisListSearch = [...pdisList];
    pdisListSearch = pdisList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }
}

class PdisSingle {
  String lote;
  String almacen;
  PdisSingle({
    required this.lote,
    required this.almacen,
  });

  List<String> toList() {
    return [
      lote,
      almacen,
    ];
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: lote, flex: 2),
        ToCelda(valor: almacen, flex: 2),
      ];

  PdisSingle copyWith({
    String? lote,
    String? almacen,
  }) {
    return PdisSingle(
      lote: lote ?? this.lote,
      almacen: almacen ?? this.almacen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lote': lote,
      'almacen': almacen,
    };
  }

  factory PdisSingle.fromList(List l) {
    return PdisSingle(
      lote: l[0].toString(),
      almacen: l[1]
          .toString()
          .replaceAll('"', '')
          .replaceAll(';', '')
          .replaceAll(',', '')
          .replaceAll("\n", " "),
    );
  }
  factory PdisSingle.fromMap(Map<String, dynamic> map) {
    return PdisSingle(
      lote: map['lote'].toString(),
      almacen: map['almacen'].toString(),
    );
  }

  factory PdisSingle.fromZero() {
    return PdisSingle(
      lote: '',
      almacen: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PdisSingle.fromJson(String source) =>
      PdisSingle.fromMap(json.decode(source));

  @override
  String toString() => 'PdisSingle(lote: $lote, almacen: $almacen)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PdisSingle &&
        other.lote == lote &&
        other.almacen == almacen;
  }

  @override
  int get hashCode => lote.hashCode ^ almacen.hashCode;
}
