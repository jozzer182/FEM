import 'dart:convert';

import 'package:http/http.dart';

import '../../resources/a_entero_2.dart';
import '../../resources/constant/apis.dart';
import '../../resources/numero_precio.dart';
import '../../resources/titulo.dart';

class CodigosPorAprobar {
  List<CodigoPorAprobar> codigosPorAprobar = [];

  List<ToCelda> celdas = [
    ToCelda(valor: 'E4E', flex: 1),
    ToCelda(valor: 'Descripción', flex: 4),
    ToCelda(valor: 'Familia', flex: 4),
    ToCelda(valor: 'NT', flex: 1),
    ToCelda(valor: 'UM', flex: 1),
    ToCelda(valor: 'Precio', flex: 2),
    ToCelda(valor: 'Norma', flex: 1),
  ];

  Future obtener() async {
    Map<String, Object> dataSend = {
      'dataReq': {'libro': 'CODIGOS_POR_APROBAR', 'hoja': 'codigosporaprobar'},
      'fname': "getHojaList"
    };
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    var dataAsListMap = jsonDecode(response.body);
    if (dataAsListMap is List && dataAsListMap.isNotEmpty) {
      codigosPorAprobar = dataAsListMap
          .sublist(1)
          .map((e) => CodigoPorAprobar.fromList(e))
          .toList();
    }
  }

  Future guardar(CodigoPorAprobar codigoPorAprobar) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'CODIGOS_POR_APROBAR',
        'hoja': 'codigosporaprobar',
        'vals': [codigoPorAprobar.toMap()]
      },
      'fname': "addRowsNotId"
    };
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    return response.body;
  }

  Future borrar(CodigoPorAprobar codigoPorAprobar) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'CODIGOS_POR_APROBAR',
        'hoja': 'codigosporaprobar',
        'map': codigoPorAprobar.toMap()
      },
      'fname': "deleteCodigosE4e"
    };
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    return response.body;
  }
}

class CodigoPorAprobar {
  String e4e;
  String descripcion;
  String familia;
  String nt;
  String um;
  String precio;
  String norma;
  CodigoPorAprobar({
    required this.e4e,
    required this.descripcion,
    required this.familia,
    required this.nt,
    required this.um,
    required this.precio,
    required this.norma,
  });

  List<String> toList() {
    return [
      e4e,
      descripcion,
      familia,
      nt,
      um,
      precio,
      norma,
    ];
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: e4e, flex: 1),
        ToCelda(valor: descripcion, flex: 4),
        ToCelda(valor: familia, flex: 4),
        ToCelda(valor: nt, flex: 1),
        ToCelda(valor: um, flex: 1),
        ToCelda(valor: uSFormat.format(precioInt), flex: 2),
        ToCelda(valor: norma, flex: 1),
      ];

  int get precioInt => aEntero(precio);

  CodigoPorAprobar copyWith({
    String? e4e,
    String? descripcion,
    String? familia,
    String? nt,
    String? um,
    String? precio,
    String? norma,
  }) {
    return CodigoPorAprobar(
      e4e: e4e ?? this.e4e,
      descripcion: descripcion ?? this.descripcion,
      familia: familia ?? this.familia,
      nt: nt ?? this.nt,
      um: um ?? this.um,
      precio: precio ?? this.precio,
      norma: norma ?? this.norma,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'e4e': e4e,
      'descripcion': descripcion,
      'familia': familia,
      'nt': nt,
      'um': um,
      'precio': precio,
      'norma': norma,
    };
  }

  factory CodigoPorAprobar.fromMap(Map<String, dynamic> map) {
    return CodigoPorAprobar(
      e4e: map['e4e'] ?? '',
      descripcion: map['descripcion'] ?? '',
      familia: map['familia'] ?? '',
      nt: map['nt'] ?? '',
      um: map['um'] ?? '',
      precio: map['precio'] ?? '',
      norma: map['norma'] ?? '',
    );
  }

  factory CodigoPorAprobar.fromList(List ls) {
    return CodigoPorAprobar(
      e4e: ls[0].toString(),
      descripcion: ls[1].toString(),
      familia: ls[2].toString(),
      nt: ls[3].toString(),
      um: ls[4].toString(),
      precio: ls[5].toString(),
      norma: ls[6].toString(),
    );
  }

  factory CodigoPorAprobar.fromInit() {
    return CodigoPorAprobar(
      e4e: '',
      descripcion: '',
      familia: '',
      nt: '',
      um: '',
      precio: '',
      norma: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CodigoPorAprobar.fromJson(String source) =>
      CodigoPorAprobar.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CodigosPorAprobarSingle(e4e: $e4e, descripcion: $descripcion, familia: $familia, nt: $nt, um: $um, precio: $precio, norma: $norma)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CodigoPorAprobar &&
        other.e4e == e4e &&
        other.descripcion == descripcion &&
        other.familia == familia &&
        other.nt == nt &&
        other.um == um &&
        other.precio == precio &&
        other.norma == norma;
  }

  @override
  int get hashCode {
    return e4e.hashCode ^
        descripcion.hashCode ^
        familia.hashCode ^
        nt.hashCode ^
        um.hashCode ^
        precio.hashCode ^
        norma.hashCode;
  }
}
