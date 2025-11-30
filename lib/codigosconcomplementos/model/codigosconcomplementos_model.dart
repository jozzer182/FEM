import 'dart:convert';

import 'package:http/http.dart';

import '../../../../resources/a_entero_2.dart';
import '../../../../resources/titulo.dart';
import '../../resources/constant/apis.dart';

class CodigosConComplementos {
  List<CodigosConComplementosSingle> codigosConComplementos = [];
  CodigosConComplementosSingle nuevo = CodigosConComplementosSingle.fromInit();

  List<ToCelda> celdas = [
    ToCelda(valor: 'E4e', flex: 1),
    ToCelda(valor: 'Descripción', flex: 6),
    ToCelda(valor: 'Familia', flex: 2),
    ToCelda(valor: 'Nt', flex: 1),
    ToCelda(valor: 'Um', flex: 1),
    ToCelda(valor: 'Precio', flex: 1),
    ToCelda(valor: 'Norma', flex: 1),
  ];

  Future obtener() async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'CODIGOS_CON_COMPLEMENTOS',
        'hoja': 'codigosconcomplementos',
      },
      'fname': "getHojaList"
    };
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    var dataAsListMap = jsonDecode(response.body);
    if (dataAsListMap is List && dataAsListMap.isNotEmpty) {
      codigosConComplementos = dataAsListMap
          .sublist(1)
          .map((e) => CodigosConComplementosSingle.fromList(e))
          .toList();
    }
  }

  Future guardar(
      CodigosConComplementosSingle codigosConComplementosSingle) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'CODIGOS_CON_COMPLEMENTOS',
        'hoja': 'codigosconcomplementos',
        'vals': [codigosConComplementosSingle.toMap()]
      },
      'fname': "addRowsNotId"
    };
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    return response.body;
  }

  Future actualizar(
      CodigosConComplementosSingle codigosConComplementosSingle) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'CODIGOS_CON_COMPLEMENTOS',
        'hoja': 'codigosconcomplementos',
        'map': codigosConComplementosSingle.toMap()
      },
      'fname': "updateWithE4e"
    };
    print(jsonEncode(dataSend));
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    return response.body;
  }

  Future borrar(
      CodigosConComplementosSingle codigosConComplementosSingle) async {
    Map<String, Object> dataSend = {
      'dataReq': {
        'libro': 'CODIGOS_CON_COMPLEMENTOS',
        'hoja': 'codigosconcomplementos',
        'map': codigosConComplementosSingle.toMap()
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

enum CodigosConComplementosSingleTipo {
  e4e,
  descripcion,
  familia,
  nt,
  um,
  precio,
  norma,
}

class CodigosConComplementosSingle {
  final String e4e;
  final String descripcion;
  final String familia;
  final String nt;
  final String um;
  final String precio;
  final String norma;

  String? e4eError;
  String? descripcionError;
  String? familiaError;
  String? ntError;
  String? umError;
  String? precioError;
  String? normaError;

  final Type tipo = CodigosConComplementosSingleTipo;

  CodigosConComplementosSingle({
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
        ToCelda(valor: descripcion, flex: 6),
        ToCelda(valor: familia, flex: 2),
        ToCelda(valor: nt, flex: 1),
        ToCelda(valor: um, flex: 1),
        ToCelda(valor: precio, flex: 1),
        ToCelda(valor: norma, flex: 1),
      ];

  get esValido {
    return e4eError == null &&
        descripcionError == null &&
        familiaError == null &&
        ntError == null &&
        umError == null &&
        precioError == null &&
        normaError == null;
  }

  CodigosConComplementosSingle copyWith({
    String? e4e,
    String? descripcion,
    String? familia,
    String? nt,
    String? um,
    String? precio,
    String? norma,
  }) {
    return CodigosConComplementosSingle(
      e4e: e4e ?? this.e4e,
      descripcion: descripcion ?? this.descripcion,
      familia: familia ?? this.familia,
      nt: nt ?? this.nt,
      um: um ?? this.um,
      precio: precio ?? this.precio,
      norma: norma ?? this.norma,
    );
  }

  CodigosConComplementosSingle copyWithEnum({
    required String value,
    required CodigosConComplementosSingleTipo tipo,
  }) {
    switch (tipo) {
      case CodigosConComplementosSingleTipo.e4e:
        return copyWith(e4e: value);
      case CodigosConComplementosSingleTipo.descripcion:
        return copyWith(descripcion: value);
      case CodigosConComplementosSingleTipo.familia:
        return copyWith(familia: value);
      case CodigosConComplementosSingleTipo.nt:
        return copyWith(nt: value);
      case CodigosConComplementosSingleTipo.um:
        return copyWith(um: value);
      case CodigosConComplementosSingleTipo.precio:
        return copyWith(precio: value);
      case CodigosConComplementosSingleTipo.norma:
        return copyWith(norma: value);
    }
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

  factory CodigosConComplementosSingle.fromMap(Map<String, dynamic> map) {
    return CodigosConComplementosSingle(
      e4e: map['e4e'].toString(),
      descripcion: map['descripcion'].toString(),
      familia: map['familia'].toString(),
      nt: map['nt'].toString(),
      um: map['um'].toString(),
      precio: map['precio'].toString(),
      norma: map['norma'].toString(),
    );
  }

  factory CodigosConComplementosSingle.fromList(List ls) {
    return CodigosConComplementosSingle(
      e4e: ls[0].toString(),
      descripcion: ls[1].toString(),
      familia: ls[2].toString(),
      nt: ls[3].toString(),
      um: ls[4].toString(),
      precio: ls[5].toString(),
      norma: ls[6].toString(),
    );
  }

  int get precioInt => aEntero(precio);

  factory CodigosConComplementosSingle.fromInit() {
    return CodigosConComplementosSingle(
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

  factory CodigosConComplementosSingle.fromJson(String source) =>
      CodigosConComplementosSingle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CodigosConComplementosSingle(e4e: $e4e,descripcion: $descripcion,familia: $familia,nt: $nt,um: $um,precio: $precio,norma: $norma,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CodigosConComplementosSingle &&
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
