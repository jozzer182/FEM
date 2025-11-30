import 'dart:convert';
import 'package:fem_app/codigosadicionales/model/codigosadicionales_model.dart';
import 'package:fem_app/codigosoficiales/model/codigosoficiales_model.dart';

import '../../resources/a_entero_2.dart';
import '../../resources/numero_precio.dart';
import '../../resources/titulo.dart';

class CodigosHabilitados {
  List<CodigoHabilitado> codigoshabilitados = [];

  List<ToCelda> celdas = [
    ToCelda(valor: 'E4E', flex: 1),
    ToCelda(valor: 'Descripción', flex: 4),
    ToCelda(valor: 'Familia', flex: 4),
    ToCelda(valor: 'NT', flex: 1),
    ToCelda(valor: 'UM', flex: 1),
    ToCelda(valor: 'Precio', flex: 2),
    ToCelda(valor: 'Norma', flex: 1),
  ];

  crear({
    required CodigosAdicionales codigosAdicionales,
    required CodigosOficiales codigosOficiales,
  }) async {
    codigoshabilitados = codigosAdicionales.codigosAdicionales
        .where((element) => element.e4e != '')
        .map(
          (e) => CodigoHabilitado(
            e4e: e.e4e,
            descripcion: e.descripcion,
            familia: e.familia,
            nt: e.nt,
            um: e.um,
            precio: e.precio,
            norma: e.norma,
          ),
        )
        .toList();
    codigoshabilitados.addAll(codigosOficiales.codigosOficiales
        .where((element) => element.e4e != '')
        .map(
          (e) => CodigoHabilitado(
            e4e: e.e4e,
            descripcion: e.descripcion,
            familia: e.familia,
            nt: e.nt,
            um: e.um,
            precio: e.precio,
            norma: e.norma,
          ),
        )
        .toList());
  }
}

class CodigoHabilitado {
  String e4e;
  String descripcion;
  String familia;
  String nt;
  String um;
  String precio;
  String norma;
  CodigoHabilitado({
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

  CodigoHabilitado copyWith({
    String? e4e,
    String? descripcion,
    String? familia,
    String? nt,
    String? um,
    String? precio,
    String? norma,
  }) {
    return CodigoHabilitado(
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

  factory CodigoHabilitado.fromMap(Map<String, dynamic> map) {
    return CodigoHabilitado(
      e4e: map['e4e'].toString(),
      descripcion: map['descripcion'].toString(),
      familia: map['familia'].toString(),
      nt: map['nt'].toString(),
      um: map['um'].toString(),
      precio: map['precio'].toString(),
      norma: map['norma'].toString(),
    );
  }

  factory CodigoHabilitado.fromList(List ls) {
    return CodigoHabilitado(
      e4e: ls[0].toString(),
      descripcion: ls[1].toString(),
      familia: ls[2].toString(),
      nt: ls[3].toString(),
      um: ls[4].toString(),
      precio: ls[5].toString(),
      norma: ls[6].toString(),
    );
  }

  factory CodigoHabilitado.fromInit() {
    return CodigoHabilitado(
      e4e: '',
      descripcion: 'No está habilitado',
      familia: '',
      nt: '',
      um: '',
      precio: '',
      norma: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CodigoHabilitado.fromJson(String source) =>
      CodigoHabilitado.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CodigoHabilitado(e4e: $e4e, descripcion: $descripcion, familia: $familia, nt: $nt, um: $um, precio: $precio, norma: $norma)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CodigoHabilitado &&
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
