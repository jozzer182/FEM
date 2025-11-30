import 'dart:convert';

import 'package:http/http.dart';

import '../../resources/a_entero_2.dart';
import '../../resources/constant/apis.dart';
import '../../resources/numero_precio.dart';
import '../../resources/titulo.dart';

class CodigosAdicionales {
  List<CodigoAdicional> codigosAdicionales = [];

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
      'dataReq': {'libro': 'CODIGOS_ADICIONALES', 'hoja': 'codigosadicionales'},
      'fname': "getHojaList"
    };
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    var dataAsListMap = jsonDecode(response.body);
    if (dataAsListMap is List && dataAsListMap.isNotEmpty) {
      codigosAdicionales = dataAsListMap
          .sublist(1)
          .map((e) => CodigoAdicional.fromList(e))
          .toList();
    }
  }

  Future guardar(CodigoAdicional codigoAdicional) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'CODIGOS_ADICIONALES',
        'hoja': 'codigosadicionales',
        'vals': [codigoAdicional.toMap()]
      },
      'fname': "addRowsNotId"
    };
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    return response.body;
  }

  Future borrar(CodigoAdicional codigoAdicional) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'CODIGOS_ADICIONALES',
        'hoja': 'codigosadicionales',
        'map': codigoAdicional.toMap()
      },
      'fname': "deleteCodigosE4e"
    };
    print(jsonEncode(dataSend));
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    return response.body;
  }
}

class CodigoAdicional {
  String e4e;
  String descripcion;
  String familia;
  String nt;
  String um;
  String precio;
  String norma;
  CodigoAdicional({
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

  CodigoAdicional copyWith({
    String? e4e,
    String? descripcion,
    String? familia,
    String? nt,
    String? um,
    String? precio,
    String? norma,
  }) {
    return CodigoAdicional(
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

  factory CodigoAdicional.fromMap(Map<String, dynamic> map) {
    return CodigoAdicional(
      e4e: map['e4e'].toString(),
      descripcion: map['descripcion'].toString(),
      familia: map['familia'].toString(),
      nt: map['nt'].toString(),
      um: map['um'].toString(),
      precio: map['precio'].toString(),
      norma: map['norma'].toString(),
    );
  }

  factory CodigoAdicional.fromList(List ls) {
    return CodigoAdicional(
      e4e: ls[0].toString(),
      descripcion: ls[1].toString(),
      familia: ls[2].toString(),
      nt: ls[3].toString(),
      um: ls[4].toString(),
      precio: ls[5].toString(),
      norma: ls[6].toString(),
    );
  }

  factory CodigoAdicional.fromInit() {
    return CodigoAdicional(
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

  factory CodigoAdicional.fromJson(String source) =>
      CodigoAdicional.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CodigoAdicional(e4e: $e4e, descripcion: $descripcion, familia: $familia, nt: $nt, um: $um, precio: $precio, norma: $norma)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CodigoAdicional &&
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
