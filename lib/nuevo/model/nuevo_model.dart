import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/budget/model/budget_model.dart';
import 'package:fem_app/disponibilidad/model/disponibilidad_model.dart';
import 'package:fem_app/fechas_fem/model/fechasfem_model.dart';
import 'package:fem_app/fem/model/fem_model.dart';
import 'package:fem_app/mm60/model/mm60_model.dart';
import 'package:fem_app/plataforma/model/plataforma_model.dart';
import 'package:http/http.dart' as http;

import '../../fem/model/fem_model_single_fem.dart';
import '../../resources/constant/apis.dart';

class Nuevo {
  List<SingleNuevo> nuevoList = [];
  List<SingleNuevo> nuevoListSearch = [];
  List<EnableDate> enableDates = [];
  EncabezadoNuevo encabezado = EncabezadoNuevo.fromInit();

  get crear2 {
    nuevoList = [];
    nuevoList = List.generate(3, (index) => SingleNuevo.fromInit(index + 1));
    encabezado = EncabezadoNuevo.fromInit();
  }

  get agregar {
    nuevoList.add(SingleNuevo.fromInit(nuevoList.length + 1));
  }

  get quitar {
    nuevoList.removeLast();
  }

  resize(String index) {
    index = index.isEmpty ? '1' : index;
    int size = int.parse(index);
    int len = nuevoList.length;
    if (size > len) {
      for (int i = len; i < size; i++) {
        nuevoList.add(SingleNuevo.fromInit(i + 1));
      }
    } else {
      for (int i = size; i < len; i++) {
        nuevoList.removeLast();
      }
    }
  }

  List? get validar {
    //comprobar si hay algun error
    var faltantes = [];
    Color r = Colors.red;
    EncabezadoNuevo e = encabezado;
    if (e.anoError == r) faltantes.add('Año');
    if (e.proyectoError == r) faltantes.add('Proyecto');
    if (e.pmError == r) faltantes.add('PM');
    for (SingleNuevo reg in nuevoList) {
      String f = 'Item: ${reg.index} =>';
      if (reg.e4eError == r) f += ' E4E,';
      if (reg.wbeError == r) f += ' WBE,';
      if (reg.m01q1Error == r) f += ' Ctd en M01 q1,';
      if (reg.m01q2Error == r) f += ' Ctd en M01 q2,';
      if (reg.m02q1Error == r) f += ' Ctd en M02 q1,';
      if (reg.m02q2Error == r) f += ' Ctd en M02 q2,';
      if (reg.m03q1Error == r) f += ' Ctd en M03 q1,';
      if (reg.m03q2Error == r) f += ' Ctd en M03 q2,';
      if (reg.m04q1Error == r) f += ' Ctd en M04 q1,';
      if (reg.m04q2Error == r) f += ' Ctd en M04 q2,';
      if (reg.m05q1Error == r) f += ' Ctd en M05 q1,';
      if (reg.m05q2Error == r) f += ' Ctd en M05 q2,';
      if (reg.m06q1Error == r) f += ' Ctd en M06 q1,';
      if (reg.m06q2Error == r) f += ' Ctd en M06 q2,';
      if (reg.m07q1Error == r) f += ' Ctd en M07 q1,';
      if (reg.m07q2Error == r) f += ' Ctd en M07 q2,';
      if (reg.m08q1Error == r) f += ' Ctd en M08 q1,';
      if (reg.m08q2Error == r) f += ' Ctd en M08 q2,';
      if (reg.m09q1Error == r) f += ' Ctd en M09 q1,';
      if (reg.m09q2Error == r) f += ' Ctd en M09 q2,';
      if (reg.m10q1Error == r) f += ' Ctd en M10 q1,';
      if (reg.m10q2Error == r) f += ' Ctd en M10 q2,';
      if (reg.m11q1Error == r) f += ' Ctd en M11 q1,';
      if (reg.m11q2Error == r) f += ' Ctd en M11 q2,';
      if (reg.m12q1Error == r) f += ' Ctd en M12 q1,';
      if (reg.m12q2Error == r) f += ' Ctd en M12 q2,';
      if (f != 'Item: ${reg.index} =>') faltantes.add(f);
    }

    if (faltantes.isNotEmpty) {
      faltantes.insert(0,
          'Por favor revise los siguientes campos en la planilla, para poder realizar el guardado:');
      return faltantes;
    } else {
      return null;
    }
  }

  Future get enviar async {
    List<Map> vals = [];
    DateTime date = DateTime.now();
    String fecha =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    encabezado.estado = 'Aprobado';
    encabezado.fechainicial = fecha;
    encabezado.fechasolicitud = fecha;
    String ano = encabezado.ano.substring(2);
    String pedidos =
        '[{"01|$ano-1":"0","01|$ano-2":"0","02|$ano-1":"0","02|$ano-2":"0","03|$ano-1":"0","03|$ano-2":"0","04|$ano-1":"0","04|$ano-2":"0","05|$ano-1":"0","05|$ano-2":"0","06|$ano-1":"0","06|$ano-2":"0","07|$ano-1":"0","07|$ano-2":"0","08|$ano-1":"0","08|$ano-2":"0","09|$ano-1":"0","09|$ano-2":"0","10|$ano-1":"0","10|$ano-2":"0","11|$ano-1":"0","11|$ano-2":"0","12|$ano-1":"0","12|$ano-2":"0"}]';
    encabezado.estdespacho = pedidos;
    encabezado.solicitante = FirebaseAuth.instance.currentUser!.email!;
    for (SingleNuevo row in nuevoList) {
      vals.add({
        ...row.toMap(),
        ...encabezado.toMap(),
      });
    }
    Map dataSend = {
      'dataReq': {'year': 'f${encabezado.ano}', 'vals': vals, 'hoja': 'reg'},
      'fname': "addRows"
    };
    // print(jsonEncode(dataSend));
    var response =
        await http.post(Uri.parse(Api.fem), body: jsonEncode(dataSend));
    // print(response.body);
    var respuesta = jsonDecode(response.body) ?? ['error', 'error'];
    // print(respuesta);
    if (respuesta is List) {
      respuesta =
          'Se han agregado ${respuesta[0]} registros con el pedido ${respuesta[1]}';
    } else {
      print(respuesta);
    }
    return respuesta;
  }

  enableDatesMethod({
    required FechasFEM fechasFEM,
    required String ano,
  }) {
    enableDates = [];
    nuevoList = List.generate(3, (index) => SingleNuevo.fromInit(index + 1));
    List<String> meses = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ];

    switch (ano) {
      case '2023':
        List<FechasFEMSingle> just2023 =
            fechasFEM.fechasFEMList.where((e) => e.ano == ano).toList();
        for (String mes in meses) {
          List<FechasFEMSingle> mesEstado =
              just2023.where((e) => e.pedido.substring(0, 2) == mes).toList();
          if (mesEstado.length == 2) {
            enableDates.add(
              EnableDate(
                mes: mes,
                versionActivaq1: mesEstado[0].versionestado == 'true',
                versionActivaq2: mesEstado[1].versionestado == 'true',
                pedidoActivoq1: mesEstado[0].estado == 'true',
                pedidoActivoq2: mesEstado[1].estado == 'true',
              ),
            );
          } else {
            print('Error mes $mes no tiene 2 versiones ${mesEstado.length}');
            print('just2023 -1 mes $mes ${just2023[0].pedido.substring(0, 2)}');
          }
        }
        break;
      case '2024':
        List<FechasFEMSingle> just2024 =
            fechasFEM.fechasFEMList.where((e) => e.ano == ano).toList();
        for (String mes in meses) {
          List<FechasFEMSingle> mesEstado =
              just2024.where((e) => e.pedido.substring(0, 2) == mes).toList();
          if (mesEstado.length == 2) {
            enableDates.add(
              EnableDate(
                mes: mes,
                versionActivaq1: mesEstado[0].versionestado == 'true',
                versionActivaq2: mesEstado[1].versionestado == 'true',
                pedidoActivoq1: mesEstado[0].estado == 'true',
                pedidoActivoq2: mesEstado[1].estado == 'true',
              ),
            );
          } else {
            print('Error mes $mes no tiene 2 versiones ${mesEstado.length}');
            print('just2025 -1 mes $mes ${just2024[0].pedido.substring(0, 2)}');
          }
        }
        break;
      case '2025':
        List<FechasFEMSingle> just2025 =
            fechasFEM.fechasFEMList.where((e) => e.ano == ano).toList();
        for (String mes in meses) {
          List<FechasFEMSingle> mesEstado =
              just2025.where((e) => e.pedido.substring(0, 2) == mes).toList();
          if (mesEstado.length == 2) {
            enableDates.add(
              EnableDate(
                mes: mes,
                versionActivaq1: mesEstado[0].versionestado == 'true',
                versionActivaq2: mesEstado[1].versionestado == 'true',
                pedidoActivoq1: mesEstado[0].estado == 'true',
                pedidoActivoq2: mesEstado[1].estado == 'true',
              ),
            );
          } else {
            print('Error mes $mes no tiene 2 versiones ${mesEstado.length}');
            print('just2025 -1 mes $mes ${just2025[0].pedido.substring(0, 2)}');
          }
        }
        break;
      default:
        for (String mes in meses) {
          enableDates.add(
            EnableDate(
              mes: mes,
              versionActivaq1: true,
              versionActivaq2: true,
              pedidoActivoq1: true,
              pedidoActivoq2: true,
            ),
          );
        }
    }
  }

  procesarProyecto({
    required Budget budget,
    required ModNuevo e,
  }) {
    if (e.valor != "") {
      nuevoList = List.generate(3, (index) => SingleNuevo.fromInit(index + 1));
      encabezado.proyecto = e.valor;
      encabezado.codigo = budget.budgetList
          .firstWhere((el) => el.nomproyecto == e.valor)
          .codproyecto;
      encabezado.unidad = budget.budgetList
          .firstWhere((el) => el.nomproyecto == e.valor)
          .responsable2;
    } else {
      encabezado.proyecto = e.valor;
      encabezado.codigo = "";
      encabezado.unidad = "";
    }
  }

  procesarE4E({
    required Mm60 mm60,
    required Plataforma plataforma,
    required Fem fem,
    required ModNuevo e,
    required Disponibilidad disponibilidad,
  }) {
    //transformamos el index, en caso de erro lo mandamos a cero.
    int index = e.index ?? 0;
    //borramos cualquier dato anterior
    nuevoList[index].blanquearCamposE4e();
    //Poblamos la descripcion y unidad de medida
    Mm60Single mm60Elem = mm60.mm60List.firstWhere(
        (el) => el.material == e.valor,
        orElse: () => Mm60Single.fromInit());
    nuevoList[index].descripcion = mm60Elem.descripcion;
    nuevoList[index].um = mm60Elem.um;
    //Obtenemos el listado de WBES para que el usuario seleccione.
    List<PlataformaSingle> wbesList = plataforma.plataformaList
        .where((el) => el.material == e.valor)
        .toSet()
        .toList();
    nuevoList[index].wbes = wbesList;
    //Se revisa que no este duplicado en la ficha actual.
    List<SingleFEM> femFicha = fem.f2023;
    if (encabezado.ano == '2024') femFicha = fem.f2024;
    if (encabezado.ano == '2025') femFicha = fem.f2025;
    if (encabezado.ano == '2026') femFicha = fem.f2026;
    if (encabezado.ano == '2027') femFicha = fem.f2027;
    if (encabezado.ano == '2028') femFicha = fem.f2028;
    SingleFEM singlefem = femFicha.firstWhere(
      (el) => (el.proyecto == encabezado.proyecto &&
          el.circuito == nuevoList[index].circuito &&
          el.e4e == e.valor),
      orElse: () => SingleFEM.notFound(),
    );
    String proyecto = singlefem.proyecto;
    nuevoList[index].mensaje = proyecto == 'NotFound'
        ? 'ok'
        : '*Duplicado, el material ${singlefem.e4e} ya existe en el proyecto ${proyecto} - ${singlefem.circuito}, por favor modifique la ficha existente.';
    //Se revisa que no este duplicado en el pedido actual.
    bool repetido = nuevoList
            .where((ele) =>
                ele.circuito == nuevoList[index].circuito && ele.e4e == e.valor)
            .length >
        1;
    nuevoList[index].mensaje = repetido
        ? '*Duplicado, el material ${e.valor} ya existe en el circuito ${nuevoList[index].circuito}, en esta lista.'
        : nuevoList[index].mensaje;
    //Se verifica si hay disponibilidad de elemento a agregar.
    DisponibilidadSingle disponibilidadSingle =
        disponibilidad.disponibilidadList.firstWhere((el) => el.e4e == e.valor,
            orElse: () => DisponibilidadSingle.fromInit());
    nuevoList[index].disponibles = disponibilidadSingle.total;
    print('disponibles: ${nuevoList[index].disponibles}');
    //calculamos el costo de la planificación
    nuevoList[index].costo =
        (double.parse(mm60Elem.precio) * nuevoList[index].cantidadTotal)
            .toStringAsFixed(0);
  }

  procesarCantidad({
    required Mm60 mm60,
    required ModNuevo e,
  }) {
    int index = e.index ?? 0;
    if (e.campo == 'm01q1') nuevoList[index].m01q1 = e.valor;
    if (e.campo == 'm01q2') nuevoList[index].m01q2 = e.valor;
    if (e.campo == 'm02q1') nuevoList[index].m02q1 = e.valor;
    if (e.campo == 'm02q2') nuevoList[index].m02q2 = e.valor;
    if (e.campo == 'm03q1') nuevoList[index].m03q1 = e.valor;
    if (e.campo == 'm03q2') nuevoList[index].m03q2 = e.valor;
    if (e.campo == 'm04q1') nuevoList[index].m04q1 = e.valor;
    if (e.campo == 'm04q2') nuevoList[index].m04q2 = e.valor;
    if (e.campo == 'm05q1') nuevoList[index].m05q1 = e.valor;
    if (e.campo == 'm05q2') nuevoList[index].m05q2 = e.valor;
    if (e.campo == 'm06q1') nuevoList[index].m06q1 = e.valor;
    if (e.campo == 'm06q2') nuevoList[index].m06q2 = e.valor;
    if (e.campo == 'm07q1') nuevoList[index].m07q1 = e.valor;
    if (e.campo == 'm07q2') nuevoList[index].m07q2 = e.valor;
    if (e.campo == 'm08q1') nuevoList[index].m08q1 = e.valor;
    if (e.campo == 'm08q2') nuevoList[index].m08q2 = e.valor;
    if (e.campo == 'm09q1') nuevoList[index].m09q1 = e.valor;
    if (e.campo == 'm09q2') nuevoList[index].m09q2 = e.valor;
    if (e.campo == 'm10q1') nuevoList[index].m10q1 = e.valor;
    if (e.campo == 'm10q2') nuevoList[index].m10q2 = e.valor;
    if (e.campo == 'm11q1') nuevoList[index].m11q1 = e.valor;
    if (e.campo == 'm11q2') nuevoList[index].m11q2 = e.valor;
    if (e.campo == 'm12q1') nuevoList[index].m12q1 = e.valor;
    if (e.campo == 'm12q2') nuevoList[index].m12q2 = e.valor;
    //calcular el costo de las unidades solicitadas
    Mm60Single mm60Elem = mm60.mm60List.firstWhere(
        (el) => el.material == nuevoList[index].e4e,
        orElse: () => Mm60Single.fromInit());
    nuevoList[index].costo =
        (double.parse(mm60Elem.precio) * nuevoList[index].cantidadTotal)
            .toStringAsFixed(0);
    // verificar la suma de las versiones cerradas
    int suma = 0;
    Map<String, Quincena> quincenas = nuevoList[index].q;
    for (EnableDate el in enableDates) {
      if (el.pedidoActivoq1 && !el.versionActivaq2)
        suma += quincenas[el.mes]!.n1;
      if (el.pedidoActivoq2 && !el.versionActivaq2)
        suma += quincenas[el.mes]!.n2;
    }
    // print('suma: $suma');
    if (suma > aEnteroCero(nuevoList[index].disponibles)) {
      for (EnableDate el in enableDates) {
        if (el.pedidoActivoq1 && !el.versionActivaq2) {
          nuevoList[index].mensaje = 'No hay disponibilidad de material';
          nuevoList[index].qError(mes: el.mes, q: 'q1', color: Colors.red);
        }
        if (el.pedidoActivoq2 && !el.versionActivaq2) {
          nuevoList[index].mensaje = 'No hay disponibilidad de material';
          nuevoList[index].qError(mes: el.mes, q: 'q2', color: Colors.red);
        }
      }
    } else {
      nuevoList[index].mensaje = 'ok';
      for (EnableDate el in enableDates) {
        if (el.pedidoActivoq1 && !el.versionActivaq2)
          nuevoList[index].qError(mes: el.mes, q: 'q1', color: null);
        if (el.pedidoActivoq2 && !el.versionActivaq2)
          nuevoList[index].qError(mes: el.mes, q: 'q2', color: null);
      }
    }
  }

  int aEnteroCero(String n) {
    if (n.isEmpty) {
      return 0;
    } else {
      return int.parse(n) < 0 ? 0 : int.parse(n);
    }
  }
}

class Quincena {
  String q1;
  String q2;
  Color? q1Error;
  Color? q2Error;
  Quincena({
    required this.q1,
    required this.q2,
    this.q1Error,
    this.q2Error,
  });

  int get n1 {
    if (q1.isEmpty) {
      return 0;
    } else {
      return int.parse(q1);
    }
  }

  int get n2 {
    if (q2.isEmpty) {
      return 0;
    } else {
      return int.parse(q2);
    }
  }

  Quincena copyWith({
    String? q1,
    String? q2,
    Color? q1Error,
    Color? q2Error,
  }) {
    return Quincena(
      q1: q1 ?? this.q1,
      q2: q2 ?? this.q2,
      q1Error: q1Error ?? this.q1Error,
      q2Error: q2Error ?? this.q2Error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'q1': q1,
      'q2': q2,
      'q1Error': q1Error?.value,
      'q2Error': q2Error?.value,
    };
  }

  factory Quincena.fromMap(Map<String, dynamic> map) {
    return Quincena(
      q1: map['q1'] ?? '',
      q2: map['q2'] ?? '',
      q1Error: map['q1Error'] != null ? Color(map['q1Error']) : null,
      q2Error: map['q2Error'] != null ? Color(map['q2Error']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quincena.fromJson(String source) =>
      Quincena.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Quincena(q1: $q1, q2: $q2, q1Error: $q1Error, q2Error: $q2Error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Quincena &&
        other.q1 == q1 &&
        other.q2 == q2 &&
        other.q1Error == q1Error &&
        other.q2Error == q2Error;
  }

  @override
  int get hashCode {
    return q1.hashCode ^ q2.hashCode ^ q1Error.hashCode ^ q2Error.hashCode;
  }
}

class EnableDate {
  String mes;
  bool pedidoActivoq1;
  bool versionActivaq1;
  bool pedidoActivoq2;
  bool versionActivaq2;
  EnableDate({
    required this.mes,
    required this.pedidoActivoq1,
    required this.versionActivaq1,
    required this.pedidoActivoq2,
    required this.versionActivaq2,
  });

  EnableDate copyWith({
    String? mes,
    bool? pedidoActivoq1,
    bool? versionActivaq1,
    bool? pedidoActivoq2,
    bool? versionActivaq2,
  }) {
    return EnableDate(
      mes: mes ?? this.mes,
      pedidoActivoq1: pedidoActivoq1 ?? this.pedidoActivoq1,
      versionActivaq1: versionActivaq1 ?? this.versionActivaq1,
      pedidoActivoq2: pedidoActivoq2 ?? this.pedidoActivoq2,
      versionActivaq2: versionActivaq2 ?? this.versionActivaq2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mes': mes,
      'pedidoActivoq1': pedidoActivoq1,
      'versionActivaq1': versionActivaq1,
      'pedidoActivoq2': pedidoActivoq2,
      'versionActivaq2': versionActivaq2,
    };
  }

  factory EnableDate.fromMap(Map<String, dynamic> map) {
    return EnableDate(
      mes: map['mes'] ?? '',
      pedidoActivoq1: map['pedidoActivoq1'] ?? false,
      versionActivaq1: map['versionActivaq1'] ?? false,
      pedidoActivoq2: map['pedidoActivoq2'] ?? false,
      versionActivaq2: map['versionActivaq2'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnableDate.fromJson(String source) =>
      EnableDate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnableDate(mes: $mes, pedidoActivoq1: $pedidoActivoq1, versionActivaq1: $versionActivaq1, pedidoActivoq2: $pedidoActivoq2, versionActivaq2: $versionActivaq2)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnableDate &&
        other.mes == mes &&
        other.pedidoActivoq1 == pedidoActivoq1 &&
        other.versionActivaq1 == versionActivaq1 &&
        other.pedidoActivoq2 == pedidoActivoq2 &&
        other.versionActivaq2 == versionActivaq2;
  }

  @override
  int get hashCode {
    return mes.hashCode ^
        pedidoActivoq1.hashCode ^
        versionActivaq1.hashCode ^
        pedidoActivoq2.hashCode ^
        versionActivaq2.hashCode;
  }
}

class EnableDateInt {
  int mes;
  bool pedidoActivoq1;
  bool versionActivaq1;
  bool pedidoActivoq2;
  bool versionActivaq2;
  bool entredoQ1;
  bool entredoQ2;
  EnableDateInt({
    required this.mes,
    required this.pedidoActivoq1,
    required this.versionActivaq1,
    required this.pedidoActivoq2,
    required this.versionActivaq2,
    required this.entredoQ1,
    required this.entredoQ2,
  });
}

class EncabezadoNuevo {
  String ano;
  String proyecto;
  String codigo;
  String unidad;
  String solicitante;
  String pm;
  String comentario1;
  String estado;
  String estdespacho;
  String tipo;
  String fechainicial;
  String fechafinal;
  String fechacambio;
  String fechasolicitud;
  EncabezadoNuevo({
    required this.ano,
    required this.proyecto,
    required this.codigo,
    required this.unidad,
    required this.solicitante,
    required this.pm,
    required this.comentario1,
    required this.estado,
    required this.estdespacho,
    required this.tipo,
    required this.fechainicial,
    required this.fechafinal,
    required this.fechacambio,
    required this.fechasolicitud,
  });

  Color get anoError => ano.isEmpty ? Colors.red : Colors.green;
  Color get proyectoError => proyecto.isEmpty ? Colors.red : Colors.green;
  Color get codigoError => codigo.isEmpty ? Colors.red : Colors.green;
  Color get unidadError => unidad.isEmpty ? Colors.red : Colors.green;
  Color get solicitanteError => solicitante.isEmpty ? Colors.red : Colors.green;
  Color get pmError => pm.isEmpty ? Colors.red : Colors.green;
  Color get comentario1Error => comentario1.isEmpty ? Colors.red : Colors.green;
  Color get estadoError => estado.isEmpty ? Colors.red : Colors.green;
  Color get estdespachoError => estdespacho.isEmpty ? Colors.red : Colors.green;
  Color get tipoError => tipo.isEmpty ? Colors.red : Colors.green;
  Color get fechainicialError =>
      fechainicial.isEmpty ? Colors.red : Colors.green;
  Color get fechafinalError => fechafinal.isEmpty ? Colors.red : Colors.green;
  Color get fechacambioError => fechacambio.isEmpty ? Colors.red : Colors.green;
  Color get fechasolicitudError =>
      fechasolicitud.isEmpty ? Colors.red : Colors.green;

  EncabezadoNuevo copyWith({
    String? ano,
    String? proyecto,
    String? codigo,
    String? unidad,
    String? solicitante,
    String? pm,
    String? comentario1,
    String? estado,
    String? estdespacho,
    String? tipo,
    String? fechainicial,
    String? fechafinal,
    String? fechacambio,
    String? fechasolicitud,
  }) {
    return EncabezadoNuevo(
      ano: ano ?? this.ano,
      proyecto: proyecto ?? this.proyecto,
      codigo: codigo ?? this.codigo,
      unidad: unidad ?? this.unidad,
      solicitante: solicitante ?? this.solicitante,
      pm: pm ?? this.pm,
      comentario1: comentario1 ?? this.comentario1,
      estado: estado ?? this.estado,
      estdespacho: estdespacho ?? this.estdespacho,
      tipo: tipo ?? this.tipo,
      fechainicial: fechainicial ?? this.fechainicial,
      fechafinal: fechafinal ?? this.fechafinal,
      fechacambio: fechacambio ?? this.fechacambio,
      fechasolicitud: fechasolicitud ?? this.fechasolicitud,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ano': ano,
      'proyecto': proyecto,
      'codigo': codigo,
      'unidad': unidad,
      'solicitante': solicitante,
      'pm': pm,
      'comentario1': comentario1,
      'estado': estado,
      'estdespacho': estdespacho,
      'tipo': tipo,
      'fechainicial': fechainicial,
      'fechafinal': fechafinal,
      'fechacambio': fechacambio,
      'fechasolicitud': fechasolicitud,
    };
  }

  factory EncabezadoNuevo.fromMap(Map<String, dynamic> map) {
    return EncabezadoNuevo(
      ano: map['ano'],
      proyecto: map['proyecto'] ?? '',
      codigo: map['codigo'] ?? '',
      unidad: map['unidad'] ?? '',
      solicitante: map['solicitante'] ?? '',
      pm: map['pm'] ?? '',
      comentario1: map['comentario1'] ?? '',
      estado: map['estado'] ?? '',
      estdespacho: map['estdespacho'] ?? '',
      tipo: map['tipo'] ?? '',
      fechainicial: map['fechainicial'] ?? '',
      fechafinal: map['fechafinal'] ?? '',
      fechacambio: map['fechacambio'] ?? '',
      fechasolicitud: map['fechasolicitud'] ?? '',
    );
  }

  factory EncabezadoNuevo.fromInit() {
    return EncabezadoNuevo(
      ano: '',
      proyecto: '',
      codigo: '',
      unidad: '',
      solicitante: '',
      pm: '',
      comentario1: '',
      estado: '',
      estdespacho: '',
      tipo: '',
      fechainicial: '',
      fechafinal: '',
      fechacambio: '',
      fechasolicitud: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EncabezadoNuevo.fromJson(String source) =>
      EncabezadoNuevo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EncabezadoNuevo(proyecto: $proyecto, codigo: $codigo, unidad: $unidad, solicitante: $solicitante, pm: $pm, comentario1: $comentario1, estado: $estado, estdespacho: $estdespacho, tipo: $tipo, fechainicial: $fechainicial, fechafinal: $fechafinal, fechacambio: $fechacambio, fechasolicitud: $fechasolicitud)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EncabezadoNuevo &&
        other.proyecto == proyecto &&
        other.codigo == codigo &&
        other.unidad == unidad &&
        other.solicitante == solicitante &&
        other.pm == pm &&
        other.comentario1 == comentario1 &&
        other.estado == estado &&
        other.estdespacho == estdespacho &&
        other.tipo == tipo &&
        other.fechainicial == fechainicial &&
        other.fechafinal == fechafinal &&
        other.fechacambio == fechacambio &&
        other.fechasolicitud == fechasolicitud;
  }

  @override
  int get hashCode {
    return proyecto.hashCode ^
        codigo.hashCode ^
        unidad.hashCode ^
        solicitante.hashCode ^
        pm.hashCode ^
        comentario1.hashCode ^
        estado.hashCode ^
        estdespacho.hashCode ^
        tipo.hashCode ^
        fechainicial.hashCode ^
        fechafinal.hashCode ^
        fechacambio.hashCode ^
        fechasolicitud.hashCode;
  }
}

class SingleNuevo {
  String costo;
  String disponibles;
  String mensaje;
  String pdi;
  String index;
  String estado;
  String circuito;
  List<PlataformaSingle> wbes = [];
  String wbe;
  String proyectowbe;
  String comentario2;
  String e4e;
  String descripcion;
  String um;
  String m01q1 = '0';
  String m01q2 = '0';
  String m02q1 = '0';
  String m02q2 = '0';
  String m03q1 = '0';
  String m03q2 = '0';
  String m04q1 = '0';
  String m04q2 = '0';
  String m05q1 = '0';
  String m05q2 = '0';
  String m06q1 = '0';
  String m06q2 = '0';
  String m07q1 = '0';
  String m07q2 = '0';
  String m08q1 = '0';
  String m08q2 = '0';
  String m09q1 = '0';
  String m09q2 = '0';
  String m10q1 = '0';
  String m10q2 = '0';
  String m11q1 = '0';
  String m11q2 = '0';
  String m12q1 = '0';
  String m12q2 = '0';
  Color? m01q1Error;
  Color? m01q2Error;
  Color? m02q1Error;
  Color? m02q2Error;
  Color? m03q1Error;
  Color? m03q2Error;
  Color? m04q1Error;
  Color? m04q2Error;
  Color? m05q1Error;
  Color? m05q2Error;
  Color? m06q1Error;
  Color? m06q2Error;
  Color? m07q1Error;
  Color? m07q2Error;
  Color? m08q1Error;
  Color? m08q2Error;
  Color? m09q1Error;
  Color? m09q2Error;
  Color? m10q1Error;
  Color? m10q2Error;
  Color? m11q1Error;
  Color? m11q2Error;
  Color? m12q1Error;
  Color? m12q2Error;
  SingleNuevo({
    required this.costo,
    required this.disponibles,
    required this.mensaje,
    required this.pdi,
    required this.index,
    required this.estado,
    required this.circuito,
    required this.wbe,
    required this.proyectowbe,
    required this.comentario2,
    required this.e4e,
    required this.descripcion,
    required this.um,
    required this.m01q1,
    required this.m01q2,
    required this.m02q1,
    required this.m02q2,
    required this.m03q1,
    required this.m03q2,
    required this.m04q1,
    required this.m04q2,
    required this.m05q1,
    required this.m05q2,
    required this.m06q1,
    required this.m06q2,
    required this.m07q1,
    required this.m07q2,
    required this.m08q1,
    required this.m08q2,
    required this.m09q1,
    required this.m09q2,
    required this.m10q1,
    required this.m10q2,
    required this.m11q1,
    required this.m11q2,
    required this.m12q1,
    required this.m12q2,
  });

  Color get e4eError {
    if (e4e.length != 6 ||
        descripcion == 'No existe en BD' ||
        mensaje != 'ok') {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  Color get wbeError {
    if (wbe.length == 22) {
      return Colors.green;
    } else if (wbes.any((e) => e.wbe.isNotEmpty && e.wbe.length == 22) &&
        wbes.any((e) => e.wbe.isEmpty)) {
      return Colors.orange;
    } else if (wbes.any((e) => e.wbe.isNotEmpty && e.wbe.length == 22)) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  int get cantidadTotal {
    int cantidad = 0;
    cantidad += aEntero(m01q1);
    cantidad += aEntero(m01q2);
    cantidad += aEntero(m02q1);
    cantidad += aEntero(m02q2);
    cantidad += aEntero(m03q1);
    cantidad += aEntero(m03q2);
    cantidad += aEntero(m04q1);
    cantidad += aEntero(m04q2);
    cantidad += aEntero(m05q1);
    cantidad += aEntero(m05q2);
    cantidad += aEntero(m06q1);
    cantidad += aEntero(m06q2);
    cantidad += aEntero(m07q1);
    cantidad += aEntero(m07q2);
    cantidad += aEntero(m08q1);
    cantidad += aEntero(m08q2);
    cantidad += aEntero(m09q1);
    cantidad += aEntero(m09q2);
    cantidad += aEntero(m10q1);
    cantidad += aEntero(m10q2);
    cantidad += aEntero(m11q1);
    cantidad += aEntero(m11q2);
    cantidad += aEntero(m12q1);
    cantidad += aEntero(m12q2);
    return cantidad;
  }

  qError({
    required String mes,
    required String q,
    required Color? color,
  }) {
    switch (mes) {
      case '01':
        if (q == 'q1') m01q1Error = color;
        if (q == 'q2') m01q2Error = color;
        break;
      case '02':
        if (q == 'q1') m02q1Error = color;
        if (q == 'q2') m02q2Error = color;
        break;
      case '03':
        if (q == 'q1') m03q1Error = color;
        if (q == 'q2') m03q2Error = color;
        break;
      case '04':
        if (q == 'q1') m04q1Error = color;
        if (q == 'q2') m04q2Error = color;
        break;
      case '05':
        if (q == 'q1') m05q1Error = color;
        if (q == 'q2') m05q2Error = color;
        break;
      case '06':
        if (q == 'q1') m06q1Error = color;
        if (q == 'q2') m06q2Error = color;
        break;
      case '07':
        if (q == 'q1') m07q1Error = color;
        if (q == 'q2') m07q2Error = color;
        break;
      case '08':
        if (q == 'q1') m08q1Error = color;
        if (q == 'q2') m08q2Error = color;
        break;
      case '09':
        if (q == 'q1') m09q1Error = color;
        if (q == 'q2') m09q2Error = color;
        break;
      case '10':
        if (q == 'q1') m10q1Error = color;
        if (q == 'q2') m10q2Error = color;
        break;
      case '11':
        if (q == 'q1') m11q1Error = color;
        if (q == 'q2') m11q2Error = color;
        break;
      case '12':
        if (q == 'q1') m12q1Error = color;
        if (q == 'q2') m12q2Error = color;
        break;
      default:
        print('Error en qError de Single Nuevo: mes $mes no encontrado');
    }
  }

  Map<String, Quincena> get q {
    return {
      '01': Quincena(
          q1: m01q1, q2: m01q2, q1Error: m01q1Error, q2Error: m01q2Error),
      '02': Quincena(
          q1: m02q1, q2: m02q2, q1Error: m02q1Error, q2Error: m02q2Error),
      '03': Quincena(
          q1: m03q1, q2: m03q2, q1Error: m03q1Error, q2Error: m03q2Error),
      '04': Quincena(
          q1: m04q1, q2: m04q2, q1Error: m04q1Error, q2Error: m04q2Error),
      '05': Quincena(
          q1: m05q1, q2: m05q2, q1Error: m05q1Error, q2Error: m05q2Error),
      '06': Quincena(
          q1: m06q1, q2: m06q2, q1Error: m06q1Error, q2Error: m06q2Error),
      '07': Quincena(
          q1: m07q1, q2: m07q2, q1Error: m07q1Error, q2Error: m07q2Error),
      '08': Quincena(
          q1: m08q1, q2: m08q2, q1Error: m08q1Error, q2Error: m08q2Error),
      '09': Quincena(
          q1: m09q1, q2: m09q2, q1Error: m09q1Error, q2Error: m09q2Error),
      '10': Quincena(
          q1: m10q1, q2: m10q2, q1Error: m10q1Error, q2Error: m10q2Error),
      '11': Quincena(
          q1: m11q1, q2: m11q2, q1Error: m11q1Error, q2Error: m11q2Error),
      '12': Quincena(
          q1: m12q1, q2: m12q2, q1Error: m12q1Error, q2Error: m12q2Error)
    };
  }

  int aEntero(String n) {
    if (n.isEmpty) {
      return 0;
    } else {
      return int.parse(n);
    }
  }

  blanquearCamposE4e() {
    pdi = '';
    wbe = '';
    proyectowbe = '';
    comentario2 = '';
    m01q1 = '';
    m01q2 = '';
    m02q1 = '';
    m02q2 = '';
    m03q1 = '';
    m03q2 = '';
    m04q1 = '';
    m04q2 = '';
    m05q1 = '';
    m05q2 = '';
    m06q1 = '';
    m06q2 = '';
    m07q1 = '';
    m07q2 = '';
    m08q1 = '';
    m08q2 = '';
    m09q1 = '';
    m09q2 = '';
    m10q1 = '';
    m10q2 = '';
    m11q1 = '';
    m11q2 = '';
    m12q1 = '';
    m12q2 = '';
  }

  blanquearCamposAnoProyecto() {
    pdi = '';
    wbe = '';
    e4e = '';
    mensaje = '';
    wbe = '';
    wbes = [];
    proyectowbe = '';
    comentario2 = '';
    m01q1 = '';
    m01q2 = '';
    m02q1 = '';
    m02q2 = '';
    m03q1 = '';
    m03q2 = '';
    m04q1 = '';
    m04q2 = '';
    m05q1 = '';
    m05q2 = '';
    m06q1 = '';
    m06q2 = '';
    m07q1 = '';
    m07q2 = '';
    m08q1 = '';
    m08q2 = '';
    m09q1 = '';
    m09q2 = '';
    m10q1 = '';
    m10q2 = '';
    m11q1 = '';
    m11q2 = '';
    m12q1 = '';
    m12q2 = '';
  }

  SingleNuevo copyWith({
    String? costo,
    String? disponibles,
    String? mensaje,
    String? pdi,
    String? index,
    String? estado,
    String? circuito,
    String? wbe,
    String? proyectowbe,
    String? comentario2,
    String? e4e,
    String? descripcion,
    String? um,
    String? m01q1,
    String? m01q2,
    String? m02q1,
    String? m02q2,
    String? m03q1,
    String? m03q2,
    String? m04q1,
    String? m04q2,
    String? m05q1,
    String? m05q2,
    String? m06q1,
    String? m06q2,
    String? m07q1,
    String? m07q2,
    String? m08q1,
    String? m08q2,
    String? m09q1,
    String? m09q2,
    String? m10q1,
    String? m10q2,
    String? m11q1,
    String? m11q2,
    String? m12q1,
    String? m12q2,
  }) {
    return SingleNuevo(
      costo: costo ?? this.costo,
      disponibles: disponibles ?? this.disponibles,
      mensaje: mensaje ?? this.mensaje,
      pdi: pdi ?? this.pdi,
      index: index ?? this.index,
      estado: estado ?? this.estado,
      circuito: circuito ?? this.circuito,
      wbe: wbe ?? this.wbe,
      proyectowbe: proyectowbe ?? this.proyectowbe,
      comentario2: comentario2 ?? this.comentario2,
      e4e: e4e ?? this.e4e,
      descripcion: descripcion ?? this.descripcion,
      um: um ?? this.um,
      m01q1: m01q1 ?? this.m01q1,
      m01q2: m01q2 ?? this.m01q2,
      m02q1: m02q1 ?? this.m02q1,
      m02q2: m02q2 ?? this.m02q2,
      m03q1: m03q1 ?? this.m03q1,
      m03q2: m03q2 ?? this.m03q2,
      m04q1: m04q1 ?? this.m04q1,
      m04q2: m04q2 ?? this.m04q2,
      m05q1: m05q1 ?? this.m05q1,
      m05q2: m05q2 ?? this.m05q2,
      m06q1: m06q1 ?? this.m06q1,
      m06q2: m06q2 ?? this.m06q2,
      m07q1: m07q1 ?? this.m07q1,
      m07q2: m07q2 ?? this.m07q2,
      m08q1: m08q1 ?? this.m08q1,
      m08q2: m08q2 ?? this.m08q2,
      m09q1: m09q1 ?? this.m09q1,
      m09q2: m09q2 ?? this.m09q2,
      m10q1: m10q1 ?? this.m10q1,
      m10q2: m10q2 ?? this.m10q2,
      m11q1: m11q1 ?? this.m11q1,
      m11q2: m11q2 ?? this.m11q2,
      m12q1: m12q1 ?? this.m12q1,
      m12q2: m12q2 ?? this.m12q2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'estado': estado,
      'circuito': circuito,
      'wbe': wbe,
      'proyectowbe': proyectowbe,
      'comentario2': comentario2,
      'e4e': e4e,
      'descripcion': descripcion,
      'um': um,
      'm01q1': m01q1,
      'm01q2': m01q2,
      'm02q1': m02q1,
      'm02q2': m02q2,
      'm03q1': m03q1,
      'm03q2': m03q2,
      'm04q1': m04q1,
      'm04q2': m04q2,
      'm05q1': m05q1,
      'm05q2': m05q2,
      'm06q1': m06q1,
      'm06q2': m06q2,
      'm07q1': m07q1,
      'm07q2': m07q2,
      'm08q1': m08q1,
      'm08q2': m08q2,
      'm09q1': m09q1,
      'm09q2': m09q2,
      'm10q1': m10q1,
      'm10q2': m10q2,
      'm11q1': m11q1,
      'm11q2': m11q2,
      'm12q1': m12q1,
      'm12q2': m12q2,
    };
  }

  factory SingleNuevo.fromMap(Map<String, dynamic> map) {
    return SingleNuevo(
      costo: map['costo'],
      disponibles: map['disponibles'],
      mensaje: map['mensaje'],
      pdi: map['pdi'],
      index: map['estado'] ?? '',
      estado: map['estado'] ?? '',
      circuito: map['circuito'] ?? '',
      wbe: map['wbe'] ?? '',
      proyectowbe: map['proyectowbe'] ?? '',
      comentario2: map['comentario2'] ?? '',
      e4e: map['e4e'] ?? '',
      descripcion: map['descripcion'] ?? '',
      um: map['um'] ?? '',
      m01q1: map['m01q1'] ?? '',
      m01q2: map['m01q2'] ?? '',
      m02q1: map['m02q1'] ?? '',
      m02q2: map['m02q2'] ?? '',
      m03q1: map['m03q1'] ?? '',
      m03q2: map['m03q2'] ?? '',
      m04q1: map['m04q1'] ?? '',
      m04q2: map['m04q2'] ?? '',
      m05q1: map['m05q1'] ?? '',
      m05q2: map['m05q2'] ?? '',
      m06q1: map['m06q1'] ?? '',
      m06q2: map['m06q2'] ?? '',
      m07q1: map['m07q1'] ?? '',
      m07q2: map['m07q2'] ?? '',
      m08q1: map['m08q1'] ?? '',
      m08q2: map['m08q2'] ?? '',
      m09q1: map['m09q1'] ?? '',
      m09q2: map['m09q2'] ?? '',
      m10q1: map['m10q1'] ?? '',
      m10q2: map['m10q2'] ?? '',
      m11q1: map['m11q1'] ?? '',
      m11q2: map['m11q2'] ?? '',
      m12q1: map['m12q1'] ?? '',
      m12q2: map['m12q2'] ?? '',
    );
  }

  factory SingleNuevo.fromInit(int index) {
    return SingleNuevo(
      costo: '',
      disponibles: '',
      mensaje: '',
      pdi: '',
      index: index.toString(),
      estado: '',
      circuito: '',
      wbe: '',
      proyectowbe: '',
      comentario2: '',
      e4e: '',
      descripcion: 'Descripción',
      um: 'Um',
      m01q1: '',
      m01q2: '',
      m02q1: '',
      m02q2: '',
      m03q1: '',
      m03q2: '',
      m04q1: '',
      m04q2: '',
      m05q1: '',
      m05q2: '',
      m06q1: '',
      m06q2: '',
      m07q1: '',
      m07q2: '',
      m08q1: '',
      m08q2: '',
      m09q1: '',
      m09q2: '',
      m10q1: '',
      m10q2: '',
      m11q1: '',
      m11q2: '',
      m12q1: '',
      m12q2: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleNuevo.fromJson(String source) =>
      SingleNuevo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SingleNuevo(estado: $estado, circuito: $circuito, wbe: $wbe, proyectowbe: $proyectowbe, comentario2: $comentario2, e4e: $e4e, descripcion: $descripcion, um: $um, m01q1: $m01q1, m01q2: $m01q2, m02q1: $m02q1, m02q2: $m02q2, m03q1: $m03q1, m03q2: $m03q2, m04q1: $m04q1, m04q2: $m04q2, m05q1: $m05q1, m05q2: $m05q2, m06q1: $m06q1, m06q2: $m06q2, m07q1: $m07q1, m07q2: $m07q2, m08q1: $m08q1, m08q2: $m08q2, m09q1: $m09q1, m09q2: $m09q2, m10q1: $m10q1, m10q2: $m10q2, m11q1: $m11q1, m11q2: $m11q2, m12q1: $m12q1, m12q2: $m12q2)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SingleNuevo &&
        other.estado == estado &&
        other.circuito == circuito &&
        other.wbe == wbe &&
        other.proyectowbe == proyectowbe &&
        other.comentario2 == comentario2 &&
        other.e4e == e4e &&
        other.descripcion == descripcion &&
        other.um == um &&
        other.m01q1 == m01q1 &&
        other.m01q2 == m01q2 &&
        other.m02q1 == m02q1 &&
        other.m02q2 == m02q2 &&
        other.m03q1 == m03q1 &&
        other.m03q2 == m03q2 &&
        other.m04q1 == m04q1 &&
        other.m04q2 == m04q2 &&
        other.m05q1 == m05q1 &&
        other.m05q2 == m05q2 &&
        other.m06q1 == m06q1 &&
        other.m06q2 == m06q2 &&
        other.m07q1 == m07q1 &&
        other.m07q2 == m07q2 &&
        other.m08q1 == m08q1 &&
        other.m08q2 == m08q2 &&
        other.m09q1 == m09q1 &&
        other.m09q2 == m09q2 &&
        other.m10q1 == m10q1 &&
        other.m10q2 == m10q2 &&
        other.m11q1 == m11q1 &&
        other.m11q2 == m11q2 &&
        other.m12q1 == m12q1 &&
        other.m12q2 == m12q2;
  }

  @override
  int get hashCode {
    return estado.hashCode ^
        circuito.hashCode ^
        wbe.hashCode ^
        proyectowbe.hashCode ^
        comentario2.hashCode ^
        e4e.hashCode ^
        descripcion.hashCode ^
        um.hashCode ^
        m01q1.hashCode ^
        m01q2.hashCode ^
        m02q1.hashCode ^
        m02q2.hashCode ^
        m03q1.hashCode ^
        m03q2.hashCode ^
        m04q1.hashCode ^
        m04q2.hashCode ^
        m05q1.hashCode ^
        m05q2.hashCode ^
        m06q1.hashCode ^
        m06q2.hashCode ^
        m07q1.hashCode ^
        m07q2.hashCode ^
        m08q1.hashCode ^
        m08q2.hashCode ^
        m09q1.hashCode ^
        m09q2.hashCode ^
        m10q1.hashCode ^
        m10q2.hashCode ^
        m11q1.hashCode ^
        m11q2.hashCode ^
        m12q1.hashCode ^
        m12q2.hashCode;
  }
}
