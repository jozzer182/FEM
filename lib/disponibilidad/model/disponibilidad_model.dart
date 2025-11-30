import 'dart:convert';
import 'dart:math';

import 'package:fem_app/versiones/model/versiones_model.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../fem/model/fem_model.dart';
import '../../fem/model/fem_sumsingle_model.dart';
import '../../resources/titulo.dart';
import 'disponibilidad_ano_list.dart';
import 'disponibilidad_mes_model.dart';

class Disponibilidad {
  List<DisponibilidadSingle> disponibilidadList = [];
  List<DisponibilidadSingle> disponibilidadListSearch = [];
  List<DisponibilidadSingle> escazesList = [];
  List<DisponibilidadSingle> escazesListSearch = [];
  List<DisponibilidadMesSingle> disponibilidadMesList = [];
  List<AnoList> anoList = [];

  int view = 70;
  Map itemsAndFlex = {
    'e4e': [2, 'e4e'],
    'descripcion': [6, 'descripcion'],
    'um': [2, 'um'],
    'plataforma': [2, 'plataforma'],
    'oe': [2, 'oe'],
    'fem': [2, 'fem'],
    'otros': [2, 'otros'],
    'total': [2, 'total'],
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
    ToCelda(valor: 'E4E', flex: 2),
    ToCelda(valor: 'Descripción', flex: 6),
    ToCelda(valor: 'UM', flex: 2),
    ToCelda(valor: 'Plataforma', flex: 2),
    ToCelda(valor: 'OE', flex: 2),
    ToCelda(valor: 'FEM', flex: 2),
    ToCelda(valor: 'Otros', flex: 2),
    ToCelda(valor: 'Total', flex: 2),
  ];

  buscar(String busqueda) {
    disponibilidadListSearch = disponibilidadList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  buscarEscazes(String busqueda) {
    escazesListSearch = escazesList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  // Future crearMes({
  //   required Mm60 mm60,
  //   required Plataforma plataforma,
  //   required Oe oe,
  //   required Fem fem,
  //   required Versiones versiones,
  //   required Bl bl,
  // }) async {
  //   Map plataformaByE4e = plataforma.plataformaByE4e;
  //   Map oeByE4e = oe.oeByE4e;
  //   DateTime fechaActual = DateTime.now();
  //   fechaActual = DateTime(fechaActual.year, fechaActual.month, 1);
  //   int anoActual = fechaActual.year;
  //   int mesActual = fechaActual.month;
  //   int mesesParaQuatrimestre = 0;
  //   for (int i = mesActual; i < 17; i++) {
  //     // print('i: $i, i % 4: ${i % 4}');
  //     if (i - mesActual >= 4 && i % 4 == 0) {
  //       mesesParaQuatrimestre = i - mesActual;
  //       i = 17;
  //     }
  //   }

  //   // Sumar 8 meses a la fecha actual
  //   DateTime nuevaFecha = sumarMeses(fechaActual, mesesParaQuatrimestre);
  //   int ano8Meses = nuevaFecha.year;
  //   int mes8meses = nuevaFecha.month;
  //   // print('Ano (8meses): $ano8Meses, mes: $mes8meses');

  //   List<int> anos = [];
  //   anos.add(anoActual);
  //   if (anoActual != ano8Meses) {
  //     anos.add(ano8Meses);
  //   }

  //   int mesinicio = mesActual;
  //   int mesfin = mes8meses;

  //   if (anoActual != ano8Meses) {
  //     mesinicio = 0;
  //     mesfin = 12;
  //   }

  //   List<String> e4eList = obtenerE4E(
  //     years: anos,
  //     fem: fem,
  //     versiones: versiones,
  //     plataformaByE4e: plataformaByE4e,
  //     oeE4eList: oe.e4eList,
  //   );
  //   // print('e4eList.length: ${e4eList.length}');
  //   // print('e4eList: $e4eList');

  //   for (int ano in anos) {
  //     //obtener la ficha FEM el año actual
  //     List<FemSumSingle> ficha = [];
  //     if (ano == 2024) ficha = fem.f2024Sum;
  //     if (ano == 2025) ficha = fem.f2025Sum;
  //     if (ano == 2026) ficha = fem.f2026Sum;
  //     if (ano == 2027) ficha = fem.f2027Sum;
  //     if (ano == 2028) ficha = fem.f2028Sum;

  //     //obtener la version oficial
  //     List<VersionSumSingle> version = [];
  //     if (ano == 2024) version = versiones.version2024;
  //     if (ano == 2025) version = versiones.version2025;
  //     if (ano == 2026) version = versiones.version2026;
  //     if (ano == 2027) version = versiones.version2027;
  //     if (ano == 2028) version = versiones.version2028;

  //     //Lista e4e combinado de version y ficha
  //     List<String> e4eListDemanda = [];
  //     for (int j = 0; j < ficha.length; j++) {
  //       FemSumSingle row = ficha[j];
  //       e4eListDemanda.add(row.e4e);
  //     }
  //     for (int j = 0; j < version.length; j++) {
  //       VersionSumSingle row = version[j];
  //       e4eListDemanda.add(row.e4e);
  //     }
  //     e4eListDemanda = e4eListDemanda.toSet().toList();
  //     e4eListDemanda.sort();
  //     // print('e4eListDemanda: ${e4eListDemanda.length}');

  //     if (ano == anoActual) {
  //       mesinicio = mesActual;
  //     } else {
  //       mesinicio = 1;
  //     }
  //     if (anoActual == ano8Meses) {
  //       mesfin = mes8meses;
  //     } else if (ano == anoActual) {
  //       mesfin = 12;
  //     } else {
  //       mesfin = mes8meses;
  //     }

  //     Map dontRepeat = {};
  //     for (int j = 0; j < e4eList.length; j++) {
  //       String e4e = e4eList[j];
  //       await informarAvance(j, e4eList, dontRepeat, bl);
  //       Mm60Single mm60Single = mm60.mm60List.firstWhere(
  //           (e) => e.material == e4e,
  //           orElse: () => Mm60Single.fromInit());
  //       String descripcion = mm60Single.descripcion;
  //       String um = mm60Single.um;
  //       if (disponibilidadMesList.where((e) => e.e4e == e4e).isEmpty) {
  //         disponibilidadMesList.add(
  //           DisponibilidadMesSingle(
  //             e4e: e4e,
  //             descripcion: descripcion,
  //             um: um,
  //           ),
  //         );
  //       }
  //       DisponibilidadMesSingle disponible =
  //           disponibilidadMesList.firstWhere((e) => e.e4e == e4e);
  //       for (int i = mesinicio; i <= mesfin; i++) {
  //         String mes = i.toString().padLeft(2, "0");
  //         int pmc = 0;
  //         int ora = 0;
  //         int ce = 0;
  //         int demanda = 0;
  //         if (e4eListDemanda.contains(e4e)) {
  //           int j = i;
  //           if (i == mesinicio && ano == anoActual) {
  //             if (fechaActual.day < 15) {
  //               j = i * 100 + 2;
  //             } else {
  //               j = i * 100 + 3;
  //             }
  //           }
  //           pmc = ficha
  //               .firstWhere((e) => e.e4e == e4e,
  //                   orElse: () => FemSumSingle.fromInit())
  //               .campo(j);

  //           ora = version
  //               .firstWhere(
  //                 (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ora',
  //                 orElse: () => VersionSumSingle.zero(),
  //               )
  //               .campo(i);
  //           ce = version
  //               .firstWhere(
  //                 (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ce',
  //                 orElse: () => VersionSumSingle.zero(),
  //               )
  //               .campo(i);
  //           demanda = pmc + ora + ce;
  //         }
  //         int oe = 0;
  //         if (oeByE4e['$e4e$i$ano'] != null) {
  //           oe = oeByE4e['$e4e$i$ano']['ctd'].floor().toInt();
  //         }
  //         int stock = 0;
  //         if (ano == anoActual &&
  //             i == mesinicio &&
  //             plataformaByE4e[e4e] != null) {
  //           stock = plataformaByE4e[e4e]['ctd'];
  //         }
  //         int oferta = oe + stock;
  //         int proyectado = oe + stock - demanda;
  //         disponible.asignar('m${mes}pmc', pmc);
  //         disponible.asignar('m${mes}ora', ora);
  //         disponible.asignar('m${mes}ce', ce);
  //         disponible.asignar('m${mes}demanda', demanda);
  //         disponible.asignar('m${mes}oe', oe);
  //         disponible.asignar('m${mes}stock', stock);
  //         disponible.asignar('m${mes}oferta', oferta);
  //         if (i != mesinicio) {
  //           proyectado += disponible
  //                   .toMap()['m${(i - 1).toString().padLeft(2, "0")}proyectado']
  //               as int;
  //         } else if (ano != anoActual) {
  //           proyectado += disponible
  //                   .toMap()['m${(12).toString().padLeft(2, "0")}proyectado']
  //               as int;
  //         }
  //         disponible.asignar('m${mes}proyectado', proyectado);
  //       }
  //     }
  //   }
  //   for (DisponibilidadMesSingle disponibilidadMes in disponibilidadMesList) {
  //     if (mesActual > 0 && mesActual <= 4) {
  //       disponibilidadList.add(
  //         DisponibilidadSingle(
  //           e4e: disponibilidadMes.e4e,
  //           descripcion: disponibilidadMes.descripcion,
  //           um: disponibilidadMes.um,
  //           plataforma: disponibilidadMes.totalStock.toString(),
  //           oe: disponibilidadMes.totalOe.toString(),
  //           fem: disponibilidadMes.totalPmc.toString(),
  //           otros: (disponibilidadMes.totalOra + disponibilidadMes.totalCe)
  //               .toString(),
  //           total: disponibilidadMes.m08proyectado!.toString(),
  //           mesFin: '08/$ano8Meses',
  //         ),
  //       );
  //     } else if (mesActual > 4 && mesActual <= 8) {
  //       disponibilidadList.add(
  //         DisponibilidadSingle(
  //           e4e: disponibilidadMes.e4e,
  //           descripcion: disponibilidadMes.descripcion,
  //           um: disponibilidadMes.um,
  //           plataforma: disponibilidadMes.totalStock.toString(),
  //           oe: disponibilidadMes.totalOe.toString(),
  //           fem: disponibilidadMes.totalPmc.toString(),
  //           otros: (disponibilidadMes.totalOra + disponibilidadMes.totalCe)
  //               .toString(),
  //           total: disponibilidadMes.m12proyectado!.toString(),
  //           mesFin: '12/$ano8Meses',
  //         ),
  //       );
  //     } else if (mesActual > 8 && mesActual <= 12) {
  //       disponibilidadList.add(
  //         DisponibilidadSingle(
  //           e4e: disponibilidadMes.e4e,
  //           descripcion: disponibilidadMes.descripcion,
  //           um: disponibilidadMes.um,
  //           plataforma: disponibilidadMes.totalStock.toString(),
  //           oe: disponibilidadMes.totalOe.toString(),
  //           fem: disponibilidadMes.totalPmc.toString(),
  //           otros: (disponibilidadMes.totalOra + disponibilidadMes.totalCe)
  //               .toString(),
  //           total: disponibilidadMes.m04proyectado!.toString(),
  //           mesFin: '04/$ano8Meses',
  //         ),
  //       );
  //     }
  //   }
  //   escazesList = disponibilidadList
  //       .where((e) => (int.parse(e.fem) > 0 && int.parse(e.total) <= 0))
  //       .toList();
  //   escazesListSearch = [...escazesList];
  //   // print('disponibilidadList: ${disponibilidadList}');
  //   disponibilidadListSearch = [...disponibilidadList];
  //   // print('disponibilidadMesList: ${disponibilidadMesList}');
  // }

  Future<void> informarAvance(
    int j,
    List<String> e4eList,
    Map<dynamic, dynamic> dontRepeat,
    Bl bl,
  ) async {
    var emit = bl.emit;
    MainState Function() state = bl.state;
    int porcentajeAvance = (j * 100 / e4eList.length).ceil();
    bool isMultipleOf10 = porcentajeAvance % 10 == 0;
    bool isNewKey = !dontRepeat.containsKey(porcentajeAvance);
    if (isMultipleOf10 && isNewKey) {
      dontRepeat[porcentajeAvance] = true;
      double numerator = ala3(j) * 100;
      double denominator = ala3(e4eList.length);
      emit(state().copyWith(
        porcentajecargadisponibilidad: '${(numerator / denominator).ceil()}%',
      ));
      await Future.delayed(const Duration(microseconds: 1));
    }
  }

  double ala3(int j) => sqrt(sqrt(sqrt(j)));
}

List<String> obtenerE4E({
  required List<int> years,
  required Fem fem,
  required Versiones versiones,
  required Map plataformaByE4e,
  required List<String> oeE4eList,
}) {
  // print('years: ${years[0]}, ${years[1]}');
  List<String> e4e = [];
  for (int index = 0; index < years.length; index++) {
    int year = years[index];
    List<FemSumSingle> ficha = [];
    if (year == 2024) ficha = fem.f2024Sum;
    if (year == 2025) ficha = fem.f2025Sum;
    if (year == 2026) ficha = fem.f2026Sum;
    if (year == 2027) ficha = fem.f2027Sum;
    if (year == 2028) ficha = fem.f2028Sum;
    for (int j = 0; j < ficha.length; j++) {
      FemSumSingle row = ficha[j];
      e4e.add(row.e4e);
    }
    //para la version
    List<VersionesSingle> version = [];
    if (year == 2024) version = versiones.v2024;
    if (year == 2025) version = versiones.v2025;
    if (year == 2026) version = versiones.v2026;
    if (year == 2027) version = versiones.v2027;
    if (year == 2028) version = versiones.v2028;
    for (int j = 0; j < version.length; j++) {
      VersionesSingle row = version[j];
      e4e.add(row.e4e);
    }
  }
  //para la plataforma
  for (String e4ePlataforma in plataformaByE4e.keys) {
    e4e.add(e4ePlataforma);
  }
  // para la oe
  e4e.addAll(oeE4eList);
  List<String> e4eUnique = e4e.toSet().toList();
  //remove lenght less than 6
  e4eUnique.removeWhere((element) => element.length < 6);
  e4eUnique.sort();
  return e4eUnique;
}

class DisponibilidadSingle {
  String e4e;
  String descripcion;
  String um;
  String plataforma;
  String oe;
  String fem;
  String otros;
  String total;
  String mesFin;
  DisponibilidadSingle({
    required this.e4e,
    required this.descripcion,
    required this.um,
    required this.plataforma,
    required this.oe,
    required this.fem,
    required this.otros,
    required this.total,
    required this.mesFin,
  });

  List<String> toList() {
    return [
      e4e,
      descripcion,
      um,
      plataforma,
      oe,
      fem,
      otros,
      total,
    ];
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: e4e, flex: 2),
        ToCelda(valor: descripcion, flex: 6),
        ToCelda(valor: um, flex: 2),
        ToCelda(valor: plataforma, flex: 2),
        ToCelda(valor: oe, flex: 2),
        ToCelda(valor: fem, flex: 2),
        ToCelda(valor: otros, flex: 2),
        ToCelda(valor: total, flex: 2),
      ];

  DisponibilidadSingle copyWith({
    String? e4e,
    String? descripcion,
    String? um,
    String? plataforma,
    String? oe,
    String? fem,
    String? otros,
    String? total,
  }) {
    return DisponibilidadSingle(
      e4e: e4e ?? this.e4e,
      descripcion: descripcion ?? this.descripcion,
      um: um ?? this.um,
      plataforma: plataforma ?? this.plataforma,
      oe: oe ?? this.oe,
      fem: fem ?? this.fem,
      otros: otros ?? this.otros,
      total: total ?? this.total,
      mesFin: mesFin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'e4e': e4e,
      'descripcion': descripcion,
      'um': um,
      'plataforma': plataforma,
      'oe': oe,
      'fem': fem,
      'otros': otros,
      'total': total,
      'mesFin': mesFin,
    };
  }

  factory DisponibilidadSingle.fromMap(Map<String, dynamic> map) {
    return DisponibilidadSingle(
      e4e: map['e4e'] ?? '',
      descripcion: map['descripcion'] ?? '',
      um: map['um'] ?? '',
      plataforma: map['plataforma'] ?? '',
      oe: map['oe'] ?? '',
      fem: map['fem'] ?? '',
      otros: map['otros'] ?? '',
      total: map['total'] ?? '',
      mesFin: map['mesFin'] ?? '',
    );
  }

  factory DisponibilidadSingle.fromInit() {
    return DisponibilidadSingle(
      e4e: '',
      descripcion: '',
      um: '',
      plataforma: '0',
      oe: '0',
      fem: '0',
      otros: '0',
      total: '0',
      mesFin: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DisponibilidadSingle.fromJson(String source) =>
      DisponibilidadSingle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisponibilidadSingle(e4e: $e4e, descripcion: $descripcion, um: $um, plataforma: $plataforma, oe: $oe, fem: $fem, otros: $otros, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisponibilidadSingle &&
        other.e4e == e4e &&
        other.descripcion == descripcion &&
        other.um == um &&
        other.plataforma == plataforma &&
        other.oe == oe &&
        other.fem == fem &&
        other.otros == otros &&
        other.total == total;
  }

  @override
  int get hashCode {
    return e4e.hashCode ^
        descripcion.hashCode ^
        um.hashCode ^
        plataforma.hashCode ^
        oe.hashCode ^
        fem.hashCode ^
        otros.hashCode ^
        total.hashCode;
  }
}
