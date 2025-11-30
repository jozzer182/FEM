// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import '../../resources/constant/apis.dart';
import '../../resources/titulo.dart';

class AlertaProyectos {
  List<AlertaProyecto> alertaProyectosList = [];
  List<AlertaProyecto> alertaProyectosListSearch = [];

  Map itemsAndFlex = {
    'proyecto': [6, 'proyecto'],
    'codigo': [2, 'codigo'],
    'descripcion': [6, 'descripcion'],
    'mes': [2, 'mes'],
    'proyectado': [2, 'proyectado'],
    'necesidad': [2, 'necesidad'],
    'actualizado': [2, 'actualizado'],
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
    ToCelda(valor: 'Proyecto', flex: 6),
    ToCelda(valor: 'Código', flex: 2),
    ToCelda(valor: 'Descripción', flex: 6),
    ToCelda(valor: 'Mes', flex: 2),
    ToCelda(valor: 'Proyectado', flex: 2),
    ToCelda(valor: 'Necesidad', flex: 2),
    // ToCelda(valor: 'Actualizado', flex: 2),
  ];

  obtener() async {
    var dataSend = {
      'dataReq': {'libro': 'disponibilidad', 'hoja': 'proyectosriesgo'},
      'fname': "getHojaList"
    };
    final response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    List dataAsListMap = jsonDecode(response.body);
    for (var item in dataAsListMap.sublist(1)) {
      // print(item);
      alertaProyectosList.add(AlertaProyecto.fromList(item));
    }
    alertaProyectosListSearch = [...alertaProyectosList];
    // print("alertaProyectosList: $alertaProyectosList");
  }

  buscar(String query) {
    alertaProyectosListSearch = alertaProyectosList
        .where((element) =>
            element.codigo.toLowerCase().contains(query.toLowerCase()) ||
            element.descripcion.toLowerCase().contains(query.toLowerCase()) ||
            element.mes.toLowerCase().contains(query.toLowerCase()) ||
            element.proyecto.toLowerCase().contains(query.toLowerCase()) ||
            element.proyectado.toLowerCase().contains(query.toLowerCase()) ||
            element.necesidad.toLowerCase().contains(query.toLowerCase()) ||
            element.actualizado.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

class AlertaProyecto {
  String codigo;
  String descripcion;
  String mes;
  String proyecto;
  String proyectado;
  String necesidad;
  String actualizado;
  AlertaProyecto({
    required this.codigo,
    required this.descripcion,
    required this.mes,
    required this.proyecto,
    required this.proyectado,
    required this.necesidad,
    required this.actualizado,
  });

  List<String> toList() {
    return [
      codigo,
      descripcion,
      mes,
      proyecto,
      proyectado,
      necesidad,
      actualizado,
    ];
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: proyecto, flex: 6),
        ToCelda(valor: codigo, flex: 2),
        ToCelda(valor: descripcion, flex: 6),
        ToCelda(valor: mes.substring(5, 7), flex: 2),
        ToCelda(valor: proyectado, flex: 2),
        ToCelda(valor: necesidad, flex: 2),
        // ToCelda(valor: actualizado, flex: 2),
      ];

  AlertaProyecto copyWith({
    String? codigo,
    String? descripcion,
    String? mes,
    String? proyecto,
    String? proyectado,
    String? necesidad,
    String? actualizado,
  }) {
    return AlertaProyecto(
      codigo: codigo ?? this.codigo,
      descripcion: descripcion ?? this.descripcion,
      mes: mes ?? this.mes,
      proyecto: proyecto ?? this.proyecto,
      proyectado: proyectado ?? this.proyectado,
      necesidad: necesidad ?? this.necesidad,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo': codigo,
      'descripcion': descripcion,
      'mes': mes,
      'proyecto': proyecto,
      'proyectado': proyectado,
      'necesidad': necesidad,
      'actualizado': actualizado,
    };
  }

  factory AlertaProyecto.fromMap(Map<String, dynamic> map) {
    return AlertaProyecto(
      codigo: map['codigo'].toString(),
      descripcion: map['descripcion'].toString(),
      mes: map['mes'].toString().substring(0, 10),
      proyecto: map['proyecto'].toString(),
      proyectado: map['proyectado'].toString(),
      necesidad: map['necesidad'].toString(),
      actualizado: map['actualizado'].toString(),
    );
  }

  factory AlertaProyecto.fromList(List l) {
    return AlertaProyecto(
      codigo: l[0].toString(),
      descripcion: l[1].toString(),
      mes: l[2].toString().substring(0, 10),
      proyecto: l[3].toString(),
      proyectado: l[4].toString(),
      necesidad: l[5].toString(),
      actualizado: l[6].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AlertaProyecto.fromJson(String source) =>
      AlertaProyecto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlertaProyecto(codigo: $codigo, descripcion: $descripcion, mes: $mes, proyecto: $proyecto, proyectado: $proyectado, necesidad: $necesidad, actualizado: $actualizado)';
  }

  @override
  bool operator ==(covariant AlertaProyecto other) {
    if (identical(this, other)) return true;

    return other.codigo == codigo &&
        other.descripcion == descripcion &&
        other.mes == mes &&
        other.proyecto == proyecto &&
        other.proyectado == proyectado &&
        other.necesidad == necesidad &&
        other.actualizado == actualizado;
  }

  @override
  int get hashCode {
    return codigo.hashCode ^
        descripcion.hashCode ^
        mes.hashCode ^
        proyecto.hashCode ^
        proyectado.hashCode ^
        necesidad.hashCode ^
        actualizado.hashCode;
  }
}
