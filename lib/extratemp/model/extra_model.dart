import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/budget/model/budget_model.dart';
import 'package:fem_app/disponibilidad/model/disponibilidad_model.dart';
import 'package:fem_app/fechas_fem/model/fechasfem_model.dart';
import 'package:fem_app/fem/model/fem_model.dart';
import 'package:fem_app/mm60/model/mm60_model.dart';
import 'package:fem_app/pedidos/model/pedidos_model.dart';
import 'package:fem_app/plataforma/model/plataforma_model.dart';

import '../../fem/model/fem_model_single_fem.dart';
import '../../resources/constant/apis.dart';
import '../../resources/titulo.dart';

class Extra {
  List<SingleExtra> extraList = [];
  List<SingleExtra> extraListSearch = [];
  List<PedidosSingle> extraListBD = [];
  List<PedidosSingle> extraListSearchBD = [];
  // List<EnableDate> enableDates = [];
  EncabezadoExtra encabezado = EncabezadoExtra.fromInit();
  String pedido = '';
  String name = '';
  String ano = '';
  int view = 70;
  int viewCart = 70;
  Map itemsAndFlex = {
    'pedido': [2, 'pedido'],
    // 'id': [2, 'id'],
    'e4e': [2, 'e4e'],
    'descripcion': [2, 'descripcion'],
    'ctdi': [2, 'ctd_i'],
    'ctdf': [2, 'ctd_f'],
    'um': [2, 'um'],
    // 'comentario': [2, 'comentario'],
    // 'solicitante': [2, 'solicitante'],
    // 'tipoenvio': [2, 'tipoenvio'],
    // 'pdi': [2, 'pdi'],
    // 'pdiname': [2, 'pdiname'],
    'proyecto': [2, 'proyecto'],
    'ref': [2, 'ref'],
    // 'wbe': [2, 'wbe'],
    // 'wbeproyecto': [2, 'wbeproyecto'],
    // 'wbeparte': [2, 'wbeparte'],
    // 'wbeestado': [2, 'wbeestado'],
    // 'fecha': [2, 'fecha'],
    'documento': [2, 'Documento\nestado'],
  };

  List<ToCelda> titles = [
    ToCelda(valor: 'Pedido', flex: 2),
    ToCelda(valor: 'E4e', flex: 2),
    ToCelda(valor: 'Descripción', flex: 6),
    ToCelda(valor: 'Ctd', flex: 1),
    ToCelda(valor: 'Um', flex: 1),
    ToCelda(valor: 'Proyecto', flex: 5),
    ToCelda(valor: 'Ref', flex: 3),
    ToCelda(valor: 'Documento\nEstado', flex: 2),
  ];

  get keys {
    return itemsAndFlex.keys.toList();
  }

  get listaTitulo {
    return [
      for (var key in keys)
        {'texto': itemsAndFlex[key][1], 'flex': itemsAndFlex[key][0]},
    ];
  }

  buscar(String busqueda) {
    extraListSearchBD = extraListBD
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  get crear2 {
    extraList = [];
    extraList = List.generate(3, (index) => SingleExtra.fromInit(index + 1));
    encabezado = EncabezadoExtra.fromInit();
  }

  get agregar {
    // if (extraList.length < 10) {
    extraList.add(SingleExtra.fromInit(extraList.length + 1));
    // }
  }

  get quitar {
    extraList.removeLast();
  }

  resize(String index) {
    index = index.isEmpty ? '1' : index;
    int size = int.parse(index);
    int len = extraList.length;
    if (size > len) {
      // size = size > 10 ? 10 : size;
      for (int i = len; i < size; i++) {
        extraList.add(SingleExtra.fromInit(i + 1));
      }
    } else {
      for (int i = size; i < len; i++) {
        extraList.removeLast();
      }
    }
  }

  obtener() async {
    extraListBD = [];
    extraListSearchBD = [];
    var dataSend = {
      'dataReq': {'libro': 'pedidos', 'hoja': 'extra'},
      'fname': "getHojaList"
    };
    final response = await http.post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    // print(response.body);
    List dataAsListMap;
    if (response.statusCode == 302) {
      var response2 = await http.get(Uri.parse(
          response.headers["location"].toString().replaceAll(',', '')));
      dataAsListMap = jsonDecode(response2.body);
    } else {
      dataAsListMap = jsonDecode(response.body);
    }

    for (var item in dataAsListMap.sublist(1)) {
      // print(item);
      PedidosSingle pedidosSingle = PedidosSingle.fromList(item);
      // if (pedidosSingle.estado != 'borrado') {
      extraListBD.add(pedidosSingle);
      // }
    }
    // print(extraListBD);
    extraListSearchBD = [...extraListBD];
  }

  List? get validar {
    //comprobar si hay algun error
    var faltantes = [];
    Color r = Colors.red;
    EncabezadoExtra e = encabezado;
    if (e.proyectoError == r) faltantes.add('Proyecto');
    if (e.pmError == r) faltantes.add('PM');
    for (SingleExtra reg in extraList) {
      String f = 'Item: ${reg.index} =>';
      if (reg.e4eError == r) f += ' E4E,';
      if (reg.wbeError == r) f += ' WBE,';
      if (reg.ctdError == r) f += ' Ctd,';
      if (reg.pdiError == r) f += ' Pdi,';
      if (reg.pdiError == r) f += ' Pdi,';
      if (reg.tipoenvioError == r) f += ' Tipo,';
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
    //1. enviar el pedido a la tabla extra
    // print('enviar from extra');
    List<Map> vals = [];
    String fecha = DateTime.now().toString().substring(0, 16);
    encabezado.estado = 'Solicitado';
    encabezado.solicitante = FirebaseAuth.instance.currentUser!.email!;
    encabezado.pedido = pedido;
    encabezado.fecha = fecha;
    encabezado.lastperson = FirebaseAuth.instance.currentUser!.email ?? "";
    for (SingleExtra row in extraList) {
      // row.id = "pendiente"; //no puedo sobre escribir el id porque elimino los ya existentes
      vals.add({
        ...row.toMap(),
        ...encabezado.toMap(),
        "comentario": "${encabezado.comentario1} - ${row.comentario2}",
        "fecha": fecha,
        "id": "pendiente",
      });
    }
    Map dataSend = {
      'dataReq': {'vals': vals},
      'fname': "addPedidoExtra"
    };
    print(jsonEncode(dataSend));
    var response =
        await http.post(Uri.parse(Api.fem), body: jsonEncode(dataSend));
    // print(response.body);
    List respuestas = [];
    var respuesta = jsonDecode(response.body) ?? ['error', 'error'];
    // print(respuesta);
    if (respuesta is List) {
      respuesta =
          'Se han agregado ${respuesta[0]} registros con el pedido ${respuesta[1]}';
      respuestas.add(respuesta);
      print(respuesta);
    } else {
      print(respuesta);
      respuestas.add(respuesta);
    }

    //2. Enviar los registros nuevos
    vals = [];
    String an = ano.substring(2);
    String estdespacho =
        '[{"01|$an-1":"0","01|$an-2":"0","02|$an-1":"0","02|$an-2":"0","03|$an-1":"0","03|$an-2":"0","04|$an-1":"0","04|$an-2":"0","05|$an-1":"0","05|$an-2":"0","06|$an-1":"0","06|$an-2":"0","07|$an-1":"0","07|$an-2":"0","08|$an-1":"0","08|$an-2":"0","09|$an-1":"0","09|$an-2":"0","10|$an-1":"0","10|$an-2":"0","11|$an-1":"0","11|$an-2":"0","12|$an-1":"0","12|$an-2":"0"}]';
    DateTime date = DateTime.now();
    fecha =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    for (SingleExtra row in extraList) {
      if (row.nuevo == "nuevo") {
        vals.add({
          ...row.toMap(),
          ...encabezado.toMap(),
          "comentario": "${encabezado.comentario1} - ${row.comentario2}",
          "fechasolicitud": fecha,
          "fechacambio": fecha,
          "tipo": row.tipoenvio,
          "estdespacho": estdespacho,
          "fechainicial": fecha,
          "ProyectoWBE": row.ctdf,
          "circuito": row.ref,
          name: row.ctdi, //cantidad extratemporal
        });
      }
    }

    if (vals.isNotEmpty) {
      dataSend = {
        'dataReq': {'year': 'f$ano', 'vals': vals, 'hoja': 'reg'},
        'fname': "addRows"
      };
      print(jsonEncode(dataSend));
      response =
          await http.post(Uri.parse(Api.fem), body: jsonEncode(dataSend));
      // print(response.body);
      respuesta = jsonDecode(response.body) ?? ['error', 'error'];
      // print(respuesta);
      if (respuesta is List) {
        respuesta =
            'Se han agregado ${respuesta[0]} registros con el pedido ${respuesta[1]}';
        print(respuesta);
        respuestas.add(respuesta);
      } else {
        print(respuesta);
      }
    }

    //3. Enviar los registros con cambios
    //todo: probar el envio de mas de un registro existente.
    vals = [];
    for (SingleExtra row in extraList) {
      if (row.nuevo == "existente") {
        vals.add({
          ...row.toMap(),
          ...encabezado.toMap(),
          "comentario": "${encabezado.comentario1} - ${row.comentario2}",
          "fechasolicitud": fecha,
          "fechacambio": fecha,
          "tipo": row.tipoenvio,
          "ProyectoWBE": row.ctdf,
          name: row.ctdi,
        });
      }
    }
    if (vals.isNotEmpty) {
      dataSend = {
        'dataReq': {'year': 'f$ano', 'vals': vals},
        'fname': "modFemDBLot"
      };
      print(jsonEncode(dataSend));
      response = await http.post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
      print(response.body);
      if (response.statusCode == 302) {
        var response2 = await http.get(Uri.parse(
            response.headers["location"].toString().replaceAll(',', '')));
        respuesta = jsonDecode(response2.body);
      } else {
        respuesta = jsonDecode(response.body);
      }
      print(respuesta);
      respuestas.add(respuesta);
    }

    return respuestas;
  }

  enableDatesMethod({
    required FechasFEM fechasFEM,
  }) {
    FechasFEMSingle fechaInteres =
        fechasFEM.fechasFEMList.firstWhere((e) => e.delivered == 'false');
    ano = fechaInteres.ano;
    pedido = fechaInteres.pedido.substring(0, 5) + 'E';
    name = fechaInteres.name.substring(0, 3) + 'qx';
  }

  procesarProyecto({
    required Budget budget,
    required ModNuevo e,
  }) {
    extraList = List.generate(3, (index) => SingleExtra.fromInit(index + 1));
    encabezado.proyecto = e.valor;
    encabezado.codigo = budget.budgetList
        .firstWhere((el) => el.nomproyecto == e.valor)
        .codproyecto;
    encabezado.unidad = budget.budgetList
        .firstWhere((el) => el.nomproyecto == e.valor)
        .responsable2;
  }

  procesarE4E({
    required Mm60 mm60,
    required Plataforma plataforma,
    required Fem fem,
    required ModNuevo e,
    required Disponibilidad disponibilidad,
    required MainState Function() state,
  }) {
    //transformamos el index, en caso de erro lo mandamos a cero.
    int index = e.index ?? 0;
    //borramos cualquier dato anterior
    extraList[index].blanquearCamposE4e();
    //Poblamos la descripcion y unidad de medida
    Mm60Single mm60Elem = mm60.mm60List.firstWhere(
        (el) => el.material == e.valor,
        orElse: () => Mm60Single.fromInit());
    extraList[index].descripcion = mm60Elem.descripcion;
    extraList[index].um = mm60Elem.um;
    //Obtenemos el listado de WBES para que el usuario seleccione.
    List<PlataformaSingle> wbesList = plataforma.plataformaList
        .where((el) => el.material == e.valor)
        .toSet()
        .toList();
    extraList[index].wbes = wbesList;
    //Se revisa que no este duplicado en la ficha actual.
    List<SingleFEM> femFicha = fem.f2023;
    String year = state().extra!.pedido.substring(3, 5);
    if (year == '24') femFicha = fem.f2024;
    if (year == '25') femFicha = fem.f2025;
    if (year == '26') femFicha = fem.f2026;
    if (year == '27') femFicha = fem.f2027;
    if (year == '28') femFicha = fem.f2028;
    // if (encabezado.ano == '2025') femFicha = fem.f2025;
    // if (encabezado.ano == '2026') femFicha = fem.f2026;
    // if (encabezado.ano == '2027') femFicha = fem.f2027;
    // if (encabezado.ano == '2028') femFicha = fem.f2028;
    SingleFEM singlefem = femFicha.firstWhere(
      (el) => (el.proyecto == encabezado.proyecto &&
          el.circuito == extraList[index].ref &&
          el.e4e == e.valor),
      orElse: () => SingleFEM.notFound(),
    );
    // print(singlefem);
    String proyecto = singlefem.proyecto;
    if (proyecto == 'NotFound') {
      extraList[index].nuevo = 'nuevo';
      extraList[index].mensaje = 'ok';
    } else {
      extraList[index].nuevo = 'existente';
      extraList[index].estdespacho = singlefem.estdespacho;
      extraList[index].id = singlefem.id;
      extraList[index].fechainicial = singlefem.fechainicial;
      extraList[index].m01q1 = singlefem.m01q1;
      extraList[index].m01q2 = singlefem.m01q2;
      extraList[index].m01qx = singlefem.m01qx;
      extraList[index].m02q1 = singlefem.m02q1;
      extraList[index].m02q2 = singlefem.m02q2;
      extraList[index].m02qx = singlefem.m02qx;
      extraList[index].m03q1 = singlefem.m03q1;
      extraList[index].m03q2 = singlefem.m03q2;
      extraList[index].m03qx = singlefem.m03qx;
      extraList[index].m04q1 = singlefem.m04q1;
      extraList[index].m04q2 = singlefem.m04q2;
      extraList[index].m04qx = singlefem.m04qx;
      extraList[index].m05q1 = singlefem.m05q1;
      extraList[index].m05q2 = singlefem.m05q2;
      extraList[index].m05qx = singlefem.m05qx;
      extraList[index].m06q1 = singlefem.m06q1;
      extraList[index].m06q2 = singlefem.m06q2;
      extraList[index].m06qx = singlefem.m06qx;
      extraList[index].m07q1 = singlefem.m07q1;
      extraList[index].m07q2 = singlefem.m07q2;
      extraList[index].m07qx = singlefem.m07qx;
      extraList[index].m08q1 = singlefem.m08q1;
      extraList[index].m08q2 = singlefem.m08q2;
      extraList[index].m08qx = singlefem.m08qx;
      extraList[index].m09q1 = singlefem.m09q1;
      extraList[index].m09q2 = singlefem.m09q2;
      extraList[index].m09qx = singlefem.m09qx;
      extraList[index].m10q1 = singlefem.m10q1;
      extraList[index].m10q2 = singlefem.m10q2;
      extraList[index].m10qx = singlefem.m10qx;
      extraList[index].m11q1 = singlefem.m11q1;
      extraList[index].m11q2 = singlefem.m11q2;
      extraList[index].m11qx = singlefem.m11qx;
      extraList[index].m12q1 = singlefem.m12q1;
      extraList[index].m12q2 = singlefem.m12q2;
      extraList[index].m12qx = singlefem.m12qx;
      extraList[index].mensaje = 'ok';
    }
    //Se revisa que no este duplicado en el pedido actual.
    bool repetido = extraList
            .where(
                (ele) => ele.ref == extraList[index].ref && ele.e4e == e.valor)
            .length >
        1;
    extraList[index].mensaje = repetido
        ? '*Duplicado, el material ${e.valor} ya existe en el circuito ${extraList[index].ref}, en esta lista.'
        : extraList[index].mensaje;
    //Se verifica si hay disponibilidad de elemento a agregar.
    DisponibilidadSingle disponibilidadSingle =
        disponibilidad.disponibilidadList.firstWhere((el) => el.e4e == e.valor,
            orElse: () => DisponibilidadSingle.fromInit());
    extraList[index].disponibles = disponibilidadSingle.total;
    //calculamos el costo de la planificación
    extraList[index].costo =
        (double.parse(mm60Elem.precio) * aEnteroCero(extraList[index].ctdi))
            .toStringAsFixed(0);
  }

  procesarCantidad({
    required Mm60 mm60,
    required ModNuevo e,
  }) {
    int index = e.index ?? 0;
    extraList[index].ctdi = e.valor;
    //calcular el costo de las unidades solicitadas
    Mm60Single mm60Elem = mm60.mm60List.firstWhere(
        (el) => el.material == extraList[index].e4e,
        orElse: () => Mm60Single.fromInit());
    extraList[index].costo =
        (double.parse(mm60Elem.precio) * aEnteroCero(extraList[index].ctdi))
            .toStringAsFixed(0);
    // verificar la suma de las versiones cerradas
    // int suma = 0;
    // Map<String, Quincena> quincenas = extraList[index].q;
    // for (EnableDate el in enableDates) {
    //   if (el.pedidoActivoq1 && !el.versionActivaq2)
    //     suma += quincenas[el.mes]!.n1;
    //   if (el.pedidoActivoq2 && !el.versionActivaq2)
    //     suma += quincenas[el.mes]!.n2;
    // }
    // print('suma: $suma');
    // if (aEnteroCero(extraList[index].ctdi) > aEnteroCero(extraList[index].disponibles)) {
    //   for (EnableDate el in enableDates) {
    //     if (el.pedidoActivoq1 && !el.versionActivaq2) {
    //       extraList[index].mensaje = 'No hay disponibilidad de material';
    //       extraList[index].qError(mes: el.mes, q: 'q1', color: Colors.red);
    //     }
    //     if (el.pedidoActivoq2 && !el.versionActivaq2) {
    //       extraList[index].mensaje = 'No hay disponibilidad de material';
    //       extraList[index].qError(mes: el.mes, q: 'q2', color: Colors.red);
    //     }
    //   }
    // } else {
    extraList[index].mensaje = 'ok';
    //   for (EnableDate el in enableDates) {
    //     if (el.pedidoActivoq1 && !el.versionActivaq2)
    //       extraList[index].qError(mes: el.mes, q: 'q1', color: null);
    //     if (el.pedidoActivoq2 && !el.versionActivaq2)
    //       extraList[index].qError(mes: el.mes, q: 'q2', color: null);
    //   }
    // }
  }

  int aEnteroCero(String n) {
    if (n.isEmpty) {
      return 0;
    } else {
      return int.parse(n) < 0 ? 0 : int.parse(n);
    }
  }
}

class EncabezadoExtra {
  String pedido;
  String solicitante;
  String proyecto;
  String fecha;
  String estado;
  String lastperson;
  String unidad;
  String codigo;
  String pm;
  String fechacambio;
  String comentario1;
  EncabezadoExtra({
    required this.pedido,
    required this.solicitante,
    required this.proyecto,
    required this.fecha,
    required this.estado,
    required this.lastperson,
    required this.unidad,
    required this.codigo,
    required this.pm,
    required this.fechacambio,
    required this.comentario1,
  });

  Color get pedidoError => pedido.isEmpty ? Colors.red : Colors.green;
  Color get solicitanteError => solicitante.isEmpty ? Colors.red : Colors.green;
  Color get proyectoError => proyecto.isEmpty ? Colors.red : Colors.green;
  Color get fechaError => fecha.isEmpty ? Colors.red : Colors.green;
  Color get estadoError => estado.isEmpty ? Colors.red : Colors.green;
  Color get lastpersonError => lastperson.isEmpty ? Colors.red : Colors.green;
  Color get unidadError => unidad.isEmpty ? Colors.red : Colors.green;
  Color get codigoError => codigo.isEmpty ? Colors.red : Colors.green;
  Color get pmError => pm.isEmpty ? Colors.red : Colors.green;
  Color get fechacambioError => fechacambio.isEmpty ? Colors.red : Colors.green;
  Color get comentario1Error => comentario1.isEmpty ? Colors.red : Colors.green;

  EncabezadoExtra copyWith({
    String? pedido,
    String? solicitante,
    String? proyecto,
    String? fecha,
    String? estado,
    String? lastperson,
    String? unidad,
    String? codigo,
    String? pm,
    String? fechacambio,
    String? comentario1,
  }) {
    return EncabezadoExtra(
      pedido: pedido ?? this.pedido,
      solicitante: solicitante ?? this.solicitante,
      proyecto: proyecto ?? this.proyecto,
      fecha: fecha ?? this.fecha,
      estado: estado ?? this.estado,
      lastperson: lastperson ?? this.lastperson,
      unidad: unidad ?? this.unidad,
      codigo: codigo ?? this.codigo,
      pm: pm ?? this.pm,
      fechacambio: fechacambio ?? this.fechacambio,
      comentario1: comentario1 ?? this.comentario1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pedido': pedido,
      'solicitante': solicitante,
      'proyecto': proyecto,
      'fecha': fecha,
      'estado': estado,
      'lastperson': lastperson,
      'unidad': unidad,
      'codigo': codigo,
      'pm': pm,
      'fechacambio': fechacambio,
      'comentario1': comentario1,
    };
  }

  factory EncabezadoExtra.fromMap(Map<String, dynamic> map) {
    return EncabezadoExtra(
      pedido: map['pedido'] ?? '',
      solicitante: map['solicitante'] ?? '',
      proyecto: map['proyecto'] ?? '',
      fecha: map['fecha'] ?? '',
      estado: map['estado'] ?? '',
      lastperson: map['lastperson'] ?? '',
      unidad: map['unidad'] ?? '',
      codigo: map['codigo'] ?? '',
      pm: map['pm'] ?? '',
      fechacambio: map['fechacambio'] ?? '',
      comentario1: map['comentario1'] ?? '',
    );
  }

  factory EncabezadoExtra.fromInit() {
    return EncabezadoExtra(
      pedido: '',
      solicitante: '',
      proyecto: '',
      fecha: '',
      estado: '',
      lastperson: '',
      unidad: '',
      codigo: '',
      pm: '',
      fechacambio: '',
      comentario1: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EncabezadoExtra.fromJson(String source) =>
      EncabezadoExtra.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EncabezadoExtra(pedido: $pedido, solicitante: $solicitante, proyecto: $proyecto, fecha: $fecha, estado: $estado, lastperson: $lastperson, unidad: $unidad, codigo: $codigo, pm: $pm, fechacambio: $fechacambio, comentario1: $comentario1)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EncabezadoExtra &&
        other.pedido == pedido &&
        other.solicitante == solicitante &&
        other.proyecto == proyecto &&
        other.fecha == fecha &&
        other.estado == estado &&
        other.lastperson == lastperson &&
        other.unidad == unidad &&
        other.codigo == codigo &&
        other.pm == pm &&
        other.fechacambio == fechacambio &&
        other.comentario1 == comentario1;
  }

  @override
  int get hashCode {
    return pedido.hashCode ^
        solicitante.hashCode ^
        proyecto.hashCode ^
        fecha.hashCode ^
        estado.hashCode ^
        lastperson.hashCode ^
        unidad.hashCode ^
        codigo.hashCode ^
        pm.hashCode ^
        fechacambio.hashCode ^
        comentario1.hashCode;
  }
}

class SingleExtra {
  String index;
  String nuevo;
  String id;
  String e4e;
  String descripcion;
  String ctdi;
  String ctdf;
  String um;
  String comentario2;
  String tipoenvio;
  String pdi;
  String pdiname;
  String ref;
  String wbe;
  String wbeproyecto;
  String wbeparte;
  String wbeestado;
  String estdespacho;
  String fechainicial;
  String m01q1;
  String m01q2;
  String m01qx;
  String m02q1;
  String m02q2;
  String m02qx;
  String m03q1;
  String m03q2;
  String m03qx;
  String m04q1;
  String m04q2;
  String m04qx;
  String m05q1;
  String m05q2;
  String m05qx;
  String m06q1;
  String m06q2;
  String m06qx;
  String m07q1;
  String m07q2;
  String m07qx;
  String m08q1;
  String m08q2;
  String m08qx;
  String m09q1;
  String m09q2;
  String m09qx;
  String m10q1;
  String m10q2;
  String m10qx;
  String m11q1;
  String m11q2;
  String m11qx;
  String m12q1;
  String m12q2;
  String m12qx;
  List<PlataformaSingle> wbes = [];
  String mensaje;
  String costo;
  String disponibles;

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

  Color get ctdError {
    if (aEnteroCero(ctdi) > aEnteroCero(disponibles) ||
        aEnteroCero(ctdi) <= 0) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  Color get pdiError {
    if (pdi.isEmpty) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  Color get tipoenvioError {
    if (tipoenvio.isEmpty) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  // Color get pdiError{
  //   if(pdi.isEmpty){
  //     return Colors.red;
  //   } else{
  //     return Colors.grey;
  //   }
  // }

  blanquearCamposE4e() {
    nuevo = '';
    id = '';
    descripcion = '';
    ctdi = '';
    ctdf = 'NO';
    um = '';
    comentario2 = '';
    tipoenvio = '';
    pdi = '';
    pdiname = '';
    // ref = '';
    wbe = '';
    wbeproyecto = '';
    wbeparte = '';
    wbeestado = '';
    estdespacho = '';
    fechainicial = '';
    m01q1 = '';
    m01q2 = '';
    m01qx = '';
    m02q1 = '';
    m02q2 = '';
    m02qx = '';
    m03q1 = '';
    m03q2 = '';
    m03qx = '';
    m04q1 = '';
    m04q2 = '';
    m04qx = '';
    m05q1 = '';
    m05q2 = '';
    m05qx = '';
    m06q1 = '';
    m06q2 = '';
    m06qx = '';
    m07q1 = '';
    m07q2 = '';
    m07qx = '';
    m08q1 = '';
    m08q2 = '';
    m08qx = '';
    m09q1 = '';
    m09q2 = '';
    m09qx = '';
    m10q1 = '';
    m10q2 = '';
    m10qx = '';
    m11q1 = '';
    m11q2 = '';
    m11qx = '';
    m12q1 = '';
    m12q2 = '';
    m12qx = '';
    mensaje = '';
    costo = '';
    disponibles = '';
    wbes = [];
  }

  int aEnteroCero(String n) {
    if (n.isEmpty) {
      return 0;
    } else {
      return int.parse(n) < 0 ? 0 : int.parse(n);
    }
  }

  SingleExtra({
    required this.index,
    required this.nuevo,
    required this.id,
    required this.e4e,
    required this.descripcion,
    required this.ctdi,
    required this.ctdf,
    required this.um,
    required this.comentario2,
    required this.tipoenvio,
    required this.pdi,
    required this.pdiname,
    required this.ref,
    required this.wbe,
    required this.wbeproyecto,
    required this.wbeparte,
    required this.wbeestado,
    required this.estdespacho,
    required this.fechainicial,
    required this.m01q1,
    required this.m01q2,
    required this.m01qx,
    required this.m02q1,
    required this.m02q2,
    required this.m02qx,
    required this.m03q1,
    required this.m03q2,
    required this.m03qx,
    required this.m04q1,
    required this.m04q2,
    required this.m04qx,
    required this.m05q1,
    required this.m05q2,
    required this.m05qx,
    required this.m06q1,
    required this.m06q2,
    required this.m06qx,
    required this.m07q1,
    required this.m07q2,
    required this.m07qx,
    required this.m08q1,
    required this.m08q2,
    required this.m08qx,
    required this.m09q1,
    required this.m09q2,
    required this.m09qx,
    required this.m10q1,
    required this.m10q2,
    required this.m10qx,
    required this.m11q1,
    required this.m11q2,
    required this.m11qx,
    required this.m12q1,
    required this.m12q2,
    required this.m12qx,
    required this.wbes,
    required this.mensaje,
    required this.costo,
    required this.disponibles,
  });

  SingleExtra copyWith({
    String? index,
    String? nuevo,
    String? id,
    String? e4e,
    String? descripcion,
    String? ctdi,
    String? ctdf,
    String? um,
    String? comentario2,
    String? tipoenvio,
    String? pdi,
    String? pdiname,
    String? ref,
    String? wbe,
    String? wbeproyecto,
    String? wbeparte,
    String? wbeestado,
    String? estdespacho,
    String? fechainicial,
    String? m01q1,
    String? m01q2,
    String? m01qx,
    String? m02q1,
    String? m02q2,
    String? m02qx,
    String? m03q1,
    String? m03q2,
    String? m03qx,
    String? m04q1,
    String? m04q2,
    String? m04qx,
    String? m05q1,
    String? m05q2,
    String? m05qx,
    String? m06q1,
    String? m06q2,
    String? m06qx,
    String? m07q1,
    String? m07q2,
    String? m07qx,
    String? m08q1,
    String? m08q2,
    String? m08qx,
    String? m09q1,
    String? m09q2,
    String? m09qx,
    String? m10q1,
    String? m10q2,
    String? m10qx,
    String? m11q1,
    String? m11q2,
    String? m11qx,
    String? m12q1,
    String? m12q2,
    String? m12qx,
    List<PlataformaSingle>? wbes,
    String? mensaje,
    String? costo,
    String? disponibles,
  }) {
    return SingleExtra(
      index: index ?? this.index,
      nuevo: nuevo ?? this.nuevo,
      id: id ?? this.id,
      e4e: e4e ?? this.e4e,
      descripcion: descripcion ?? this.descripcion,
      ctdi: ctdi ?? this.ctdi,
      ctdf: ctdf ?? this.ctdf,
      um: um ?? this.um,
      comentario2: comentario2 ?? this.comentario2,
      tipoenvio: tipoenvio ?? this.tipoenvio,
      pdi: pdi ?? this.pdi,
      pdiname: pdiname ?? this.pdiname,
      ref: ref ?? this.ref,
      wbe: wbe ?? this.wbe,
      wbeproyecto: wbeproyecto ?? this.wbeproyecto,
      wbeparte: wbeparte ?? this.wbeparte,
      wbeestado: wbeestado ?? this.wbeestado,
      estdespacho: estdespacho ?? this.estdespacho,
      fechainicial: fechainicial ?? this.fechainicial,
      m01q1: m01q1 ?? this.m01q1,
      m01q2: m01q2 ?? this.m01q2,
      m01qx: m01qx ?? this.m01qx,
      m02q1: m02q1 ?? this.m02q1,
      m02q2: m02q2 ?? this.m02q2,
      m02qx: m02qx ?? this.m02qx,
      m03q1: m03q1 ?? this.m03q1,
      m03q2: m03q2 ?? this.m03q2,
      m03qx: m03qx ?? this.m03qx,
      m04q1: m04q1 ?? this.m04q1,
      m04q2: m04q2 ?? this.m04q2,
      m04qx: m04qx ?? this.m04qx,
      m05q1: m05q1 ?? this.m05q1,
      m05q2: m05q2 ?? this.m05q2,
      m05qx: m05qx ?? this.m05qx,
      m06q1: m06q1 ?? this.m06q1,
      m06q2: m06q2 ?? this.m06q2,
      m06qx: m06qx ?? this.m06qx,
      m07q1: m07q1 ?? this.m07q1,
      m07q2: m07q2 ?? this.m07q2,
      m07qx: m07qx ?? this.m07qx,
      m08q1: m08q1 ?? this.m08q1,
      m08q2: m08q2 ?? this.m08q2,
      m08qx: m08qx ?? this.m08qx,
      m09q1: m09q1 ?? this.m09q1,
      m09q2: m09q2 ?? this.m09q2,
      m09qx: m09qx ?? this.m09qx,
      m10q1: m10q1 ?? this.m10q1,
      m10q2: m10q2 ?? this.m10q2,
      m10qx: m10qx ?? this.m10qx,
      m11q1: m11q1 ?? this.m11q1,
      m11q2: m11q2 ?? this.m11q2,
      m11qx: m11qx ?? this.m11qx,
      m12q1: m12q1 ?? this.m12q1,
      m12q2: m12q2 ?? this.m12q2,
      m12qx: m12qx ?? this.m12qx,
      wbes: wbes ?? this.wbes,
      mensaje: mensaje ?? this.mensaje,
      costo: costo ?? this.costo,
      disponibles: disponibles ?? this.disponibles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nuevo': nuevo,
      'id': id,
      'e4e': e4e,
      'descripcion': descripcion,
      'ctdi': ctdi,
      'ctdf': ctdf,
      'um': um,
      'comentario2': comentario2,
      'tipoenvio': tipoenvio,
      'pdi': pdi,
      'pdiname': pdiname,
      'ref': ref,
      'wbe': wbe,
      'wbeproyecto': wbeproyecto,
      'wbeparte': wbeparte,
      'wbeestado': wbeestado,
      'estdespacho': estdespacho,
      'fechainicial': fechainicial,
      'm01q1': m01q1,
      'm01q2': m01q2,
      'm01qx': m01qx,
      'm02q1': m02q1,
      'm02q2': m02q2,
      'm02qx': m02qx,
      'm03q1': m03q1,
      'm03q2': m03q2,
      'm03qx': m03qx,
      'm04q1': m04q1,
      'm04q2': m04q2,
      'm04qx': m04qx,
      'm05q1': m05q1,
      'm05q2': m05q2,
      'm05qx': m05qx,
      'm06q1': m06q1,
      'm06q2': m06q2,
      'm06qx': m06qx,
      'm07q1': m07q1,
      'm07q2': m07q2,
      'm07qx': m07qx,
      'm08q1': m08q1,
      'm08q2': m08q2,
      'm08qx': m08qx,
      'm09q1': m09q1,
      'm09q2': m09q2,
      'm09qx': m09qx,
      'm10q1': m10q1,
      'm10q2': m10q2,
      'm10qx': m10qx,
      'm11q1': m11q1,
      'm11q2': m11q2,
      'm11qx': m11qx,
      'm12q1': m12q1,
      'm12q2': m12q2,
      'm12qx': m12qx,
      'wbes': wbes.map((x) => x.toMap()).toList(),
      'mensaje': mensaje,
      'costo': costo,
      'disponibles': disponibles,
    };
  }

  factory SingleExtra.fromMap(Map<String, dynamic> map) {
    return SingleExtra(
      index: '',
      nuevo: map['nuevo'] ?? '',
      id: map['id'] ?? '',
      e4e: map['e4e'] ?? '',
      descripcion: map['descripcion'] ?? '',
      ctdi: map['ctdi'] ?? '',
      ctdf: map['ctdf'] ?? '',
      um: map['um'] ?? '',
      comentario2: map['comentario2'] ?? '',
      tipoenvio: map['tipoenvio'] ?? '',
      pdi: map['pdi'] ?? '',
      pdiname: map['pdiname'] ?? '',
      ref: map['ref'] ?? '',
      wbe: map['wbe'] ?? '',
      wbeproyecto: map['wbeproyecto'] ?? '',
      wbeparte: map['wbeparte'] ?? '',
      wbeestado: map['wbeestado'] ?? '',
      estdespacho: map['estdespacho'] ?? '',
      fechainicial: map['fechainicial'] ?? '',
      m01q1: map['m01q1'] ?? '',
      m01q2: map['m01q2'] ?? '',
      m01qx: map['m01qx'] ?? '',
      m02q1: map['m02q1'] ?? '',
      m02q2: map['m02q2'] ?? '',
      m02qx: map['m02qx'] ?? '',
      m03q1: map['m03q1'] ?? '',
      m03q2: map['m03q2'] ?? '',
      m03qx: map['m03qx'] ?? '',
      m04q1: map['m04q1'] ?? '',
      m04q2: map['m04q2'] ?? '',
      m04qx: map['m04qx'] ?? '',
      m05q1: map['m05q1'] ?? '',
      m05q2: map['m05q2'] ?? '',
      m05qx: map['m05qx'] ?? '',
      m06q1: map['m06q1'] ?? '',
      m06q2: map['m06q2'] ?? '',
      m06qx: map['m06qx'] ?? '',
      m07q1: map['m07q1'] ?? '',
      m07q2: map['m07q2'] ?? '',
      m07qx: map['m07qx'] ?? '',
      m08q1: map['m08q1'] ?? '',
      m08q2: map['m08q2'] ?? '',
      m08qx: map['m08qx'] ?? '',
      m09q1: map['m09q1'] ?? '',
      m09q2: map['m09q2'] ?? '',
      m09qx: map['m09qx'] ?? '',
      m10q1: map['m10q1'] ?? '',
      m10q2: map['m10q2'] ?? '',
      m10qx: map['m10qx'] ?? '',
      m11q1: map['m11q1'] ?? '',
      m11q2: map['m11q2'] ?? '',
      m11qx: map['m11qx'] ?? '',
      m12q1: map['m12q1'] ?? '',
      m12q2: map['m12q2'] ?? '',
      m12qx: map['m12qx'] ?? '',
      wbes: List<PlataformaSingle>.from(
          map['wbes']?.map((x) => PlataformaSingle.fromMap(x))),
      mensaje: map['mensaje'] ?? '',
      costo: map['costo'] ?? '',
      disponibles: map['disponibles'] ?? '',
    );
  }

  factory SingleExtra.fromInit(int index) {
    return SingleExtra(
      index: index.toString(),
      nuevo: '',
      id: '',
      e4e: '',
      descripcion: 'Descripción',
      ctdi: '',
      ctdf: 'NO',
      um: 'Um',
      comentario2: '',
      tipoenvio: '',
      pdi: '',
      pdiname: '',
      ref: '',
      wbe: '',
      wbeproyecto: '',
      wbeparte: '',
      wbeestado: '',
      estdespacho: '',
      fechainicial: '',
      m01q1: '',
      m01q2: '',
      m01qx: '',
      m02q1: '',
      m02q2: '',
      m02qx: '',
      m03q1: '',
      m03q2: '',
      m03qx: '',
      m04q1: '',
      m04q2: '',
      m04qx: '',
      m05q1: '',
      m05q2: '',
      m05qx: '',
      m06q1: '',
      m06q2: '',
      m06qx: '',
      m07q1: '',
      m07q2: '',
      m07qx: '',
      m08q1: '',
      m08q2: '',
      m08qx: '',
      m09q1: '',
      m09q2: '',
      m09qx: '',
      m10q1: '',
      m10q2: '',
      m10qx: '',
      m11q1: '',
      m11q2: '',
      m11qx: '',
      m12q1: '',
      m12q2: '',
      m12qx: '',
      wbes: [],
      mensaje: '',
      costo: '',
      disponibles: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleExtra.fromJson(String source) =>
      SingleExtra.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SingleExtra(nuevo: $nuevo, id: $id, e4e: $e4e, descripcion: $descripcion, ctdi: $ctdi, ctdf: $ctdf, um: $um, comentario2: $comentario2, tipoenvio: $tipoenvio, pdi: $pdi, pdiname: $pdiname, ref: $ref, wbe: $wbe, wbeproyecto: $wbeproyecto, wbeparte: $wbeparte, wbeestado: $wbeestado, estdespacho: $estdespacho, fechainicial: $fechainicial, m01q1: $m01q1, m01q2: $m01q2, m01qx: $m01qx, m02q1: $m02q1, m02q2: $m02q2, m02qx: $m02qx, m03q1: $m03q1, m03q2: $m03q2, m03qx: $m03qx, m04q1: $m04q1, m04q2: $m04q2, m04qx: $m04qx, m05q1: $m05q1, m05q2: $m05q2, m05qx: $m05qx, m06q1: $m06q1, m06q2: $m06q2, m06qx: $m06qx, m07q1: $m07q1, m07q2: $m07q2, m07qx: $m07qx, m08q1: $m08q1, m08q2: $m08q2, m08qx: $m08qx, m09q1: $m09q1, m09q2: $m09q2, m09qx: $m09qx, m10q1: $m10q1, m10q2: $m10q2, m10qx: $m10qx, m11q1: $m11q1, m11q2: $m11q2, m11qx: $m11qx, m12q1: $m12q1, m12q2: $m12q2, m12qx: $m12qx, wbes: $wbes, mensaje: $mensaje, costo: $costo, disponibles: $disponibles)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SingleExtra &&
        other.nuevo == nuevo &&
        other.id == id &&
        other.e4e == e4e &&
        other.descripcion == descripcion &&
        other.ctdi == ctdi &&
        other.ctdf == ctdf &&
        other.um == um &&
        other.comentario2 == comentario2 &&
        other.tipoenvio == tipoenvio &&
        other.pdi == pdi &&
        other.pdiname == pdiname &&
        other.ref == ref &&
        other.wbe == wbe &&
        other.wbeproyecto == wbeproyecto &&
        other.wbeparte == wbeparte &&
        other.wbeestado == wbeestado &&
        other.estdespacho == estdespacho &&
        other.fechainicial == fechainicial &&
        other.m01q1 == m01q1 &&
        other.m01q2 == m01q2 &&
        other.m01qx == m01qx &&
        other.m02q1 == m02q1 &&
        other.m02q2 == m02q2 &&
        other.m02qx == m02qx &&
        other.m03q1 == m03q1 &&
        other.m03q2 == m03q2 &&
        other.m03qx == m03qx &&
        other.m04q1 == m04q1 &&
        other.m04q2 == m04q2 &&
        other.m04qx == m04qx &&
        other.m05q1 == m05q1 &&
        other.m05q2 == m05q2 &&
        other.m05qx == m05qx &&
        other.m06q1 == m06q1 &&
        other.m06q2 == m06q2 &&
        other.m06qx == m06qx &&
        other.m07q1 == m07q1 &&
        other.m07q2 == m07q2 &&
        other.m07qx == m07qx &&
        other.m08q1 == m08q1 &&
        other.m08q2 == m08q2 &&
        other.m08qx == m08qx &&
        other.m09q1 == m09q1 &&
        other.m09q2 == m09q2 &&
        other.m09qx == m09qx &&
        other.m10q1 == m10q1 &&
        other.m10q2 == m10q2 &&
        other.m10qx == m10qx &&
        other.m11q1 == m11q1 &&
        other.m11q2 == m11q2 &&
        other.m11qx == m11qx &&
        other.m12q1 == m12q1 &&
        other.m12q2 == m12q2 &&
        other.m12qx == m12qx &&
        listEquals(other.wbes, wbes) &&
        other.mensaje == mensaje &&
        other.costo == costo &&
        other.disponibles == disponibles;
  }

  @override
  int get hashCode {
    return nuevo.hashCode ^
        id.hashCode ^
        e4e.hashCode ^
        descripcion.hashCode ^
        ctdi.hashCode ^
        ctdf.hashCode ^
        um.hashCode ^
        comentario2.hashCode ^
        tipoenvio.hashCode ^
        pdi.hashCode ^
        pdiname.hashCode ^
        ref.hashCode ^
        wbe.hashCode ^
        wbeproyecto.hashCode ^
        wbeparte.hashCode ^
        wbeestado.hashCode ^
        estdespacho.hashCode ^
        fechainicial.hashCode ^
        m01q1.hashCode ^
        m01q2.hashCode ^
        m01qx.hashCode ^
        m02q1.hashCode ^
        m02q2.hashCode ^
        m02qx.hashCode ^
        m03q1.hashCode ^
        m03q2.hashCode ^
        m03qx.hashCode ^
        m04q1.hashCode ^
        m04q2.hashCode ^
        m04qx.hashCode ^
        m05q1.hashCode ^
        m05q2.hashCode ^
        m05qx.hashCode ^
        m06q1.hashCode ^
        m06q2.hashCode ^
        m06qx.hashCode ^
        m07q1.hashCode ^
        m07q2.hashCode ^
        m07qx.hashCode ^
        m08q1.hashCode ^
        m08q2.hashCode ^
        m08qx.hashCode ^
        m09q1.hashCode ^
        m09q2.hashCode ^
        m09qx.hashCode ^
        m10q1.hashCode ^
        m10q2.hashCode ^
        m10qx.hashCode ^
        m11q1.hashCode ^
        m11q2.hashCode ^
        m11qx.hashCode ^
        m12q1.hashCode ^
        m12q2.hashCode ^
        m12qx.hashCode ^
        wbes.hashCode ^
        mensaje.hashCode ^
        costo.hashCode ^
        disponibles.hashCode;
  }
}
