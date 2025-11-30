import 'dart:math';

import 'package:fem_app/disponibilidad/model/disponibilidad_ano_list.dart';
import 'package:fem_app/disponibilidad/model/disponibilidad_only_month.dart';
import 'package:fem_app/fechas_fem/model/fechasfem_model.dart';
import 'package:fem_app/fem/model/fem_model.dart';
import 'package:fem_app/mm60/model/mm60_model.dart';
import 'package:fem_app/oe/model/oe_model.dart';
import 'package:fem_app/plataforma/model/plataforma_model.dart';
import 'package:fem_app/versiones/model/versiones_model.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../fem/model/fem_sumsingle_model.dart';
import '../../nuevo/model/nuevo_model.dart';
import '../../resources/sumar_meses.dart';
import '../../versiones/model/versiones_model_sumsingle.dart';
import '../model/disponibilidad_mes_model.dart';
import '../model/disponibilidad_model.dart';

class DisponibilidadController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  DisponibilidadController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  Future<void> get crearConFechasOptimizado async {
    Disponibilidad disponibilidad = Disponibilidad();
    Mm60 mm60 = state().mm60!;
    Plataforma plataforma = state().plataforma!;
    Oe oe = state().oe!;
    Fem fem = state().fem!;
    Versiones versiones = state().versiones!;
    FechasFEM fechasFEM = state().fechasFEM!;
    Map plataformaByE4e = plataforma.plataformaByE4e;
    List<AnoList> anoList = disponibilidad.anoList;
    Map oeByE4e = oe.oeByE4e;
    DateTime fechaActual = DateTime.now();
    fechaActual = DateTime(fechaActual.year, fechaActual.month, 1);
    int anoActual = fechaActual.year;
    int anoSiguiente = anoActual + 1;
    List<int> years = [anoActual, anoSiguiente];
    try {
      List<String> e4eList = obtenerE4E(
        years: years,
        fem: fem,
        versiones: versiones,
        plataformaByE4e: plataformaByE4e,
        oeE4eList: oe.e4eList,
      );
      //Corrección por material ya entregado

      // Map dontRepeat = {};

      for (int year in years) {
        List<int> correccion = fechasFEM.correccionAno(year);
        List<FemSumSingle> ficha = fem.obtenerAnoSum(year);
        List<VersionSumSingle> version = versiones.obtenerAnoSum(year);
        Map<int, EnableDateInt> enableDatesInt =
            state().fechasFEM!.enableDatesInt(year);
        int esteMes = fechaActual.month;
        int esteAno = fechaActual.year;
        if (year == esteAno) {
          emit(state().copyWith(
            porcentajecargadisponibilidad: '70%',
          ));
          await Future.delayed(const Duration(microseconds: 1));
        } else {
          emit(state().copyWith(
            porcentajecargadisponibilidad: '100%',
          ));
          await Future.delayed(const Duration(microseconds: 1));
        }
        for (int j = 0; j < e4eList.length; j++) {
          String e4e = e4eList[j];
          // print('e4e: $e4e ano:$year');
          Mm60Single mm60Single = buscarMm60(e4e, mm60);
          String descripcion = mm60Single.descripcion;
          String um = mm60Single.um;
          bool isNotCreated = anoList.where((e) => e.e4e == e4e).isEmpty;
          if (isNotCreated) {
            anoList.add(AnoList(e4e: e4e, descripcion: descripcion, um: um));
          }
          AnoList anoListSingle = anoList.firstWhere((e) => e.e4e == e4e);
          List<int> pmcPorMes = ficha
              .firstWhere((e) => e.e4e == e4e,
                  orElse: () => FemSumSingle.fromInit())
              .filtradoFechasFem(enableDatesInt: enableDatesInt);
          pmcPorMes = [
            pmcPorMes[0] * correccion[0],
            pmcPorMes[1] * correccion[1],
            pmcPorMes[2] * correccion[2],
            pmcPorMes[3] * correccion[3],
            pmcPorMes[4] * correccion[4],
            pmcPorMes[5] * correccion[5],
            pmcPorMes[6] * correccion[6],
            pmcPorMes[7] * correccion[7],
            pmcPorMes[8] * correccion[8],
            pmcPorMes[9] * correccion[9],
            pmcPorMes[10] * correccion[10],
            pmcPorMes[11] * correccion[11],
          ];
          List<int> oraPorMes = version
              .firstWhere(
                (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ora',
                orElse: () => VersionSumSingle.zero(),
              )
              .spots;
          oraPorMes = [
            oraPorMes[0] * correccion[0],
            oraPorMes[1] * correccion[1],
            oraPorMes[2] * correccion[2],
            oraPorMes[3] * correccion[3],
            oraPorMes[4] * correccion[4],
            oraPorMes[5] * correccion[5],
            oraPorMes[6] * correccion[6],
            oraPorMes[7] * correccion[7],
            oraPorMes[8] * correccion[8],
            oraPorMes[9] * correccion[9],
            oraPorMes[10] * correccion[10],
            oraPorMes[11] * correccion[11],
          ];
          List<int> cePorMes = version
              .firstWhere(
                (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ce',
                orElse: () => VersionSumSingle.zero(),
              )
              .spots;
          cePorMes = [
            cePorMes[0] * correccion[0],
            cePorMes[1] * correccion[1],
            cePorMes[2] * correccion[2],
            cePorMes[3] * correccion[3],
            cePorMes[4] * correccion[4],
            cePorMes[5] * correccion[5],
            cePorMes[6] * correccion[6],
            cePorMes[7] * correccion[7],
            cePorMes[8] * correccion[8],
            cePorMes[9] * correccion[9],
            cePorMes[10] * correccion[10],
            cePorMes[11] * correccion[11],
          ];
          // 2.7.toInt();
          List<int> oePorMes = [
            oeByE4e['${e4e}1$year'] == null
                ? 0
                : oeByE4e['${e4e}1$year']['ctd'].toInt(),
            oeByE4e['${e4e}2$year'] == null
                ? 0
                : oeByE4e['${e4e}2$year']['ctd'].toInt(),
            oeByE4e['${e4e}3$year'] == null
                ? 0
                : oeByE4e['${e4e}3$year']['ctd'].toInt(),
            oeByE4e['${e4e}4$year'] == null
                ? 0
                : oeByE4e['${e4e}4$year']['ctd'].toInt(),
            oeByE4e['${e4e}5$year'] == null
                ? 0
                : oeByE4e['${e4e}5$year']['ctd'].toInt(),
            oeByE4e['${e4e}6$year'] == null
                ? 0
                : oeByE4e['${e4e}6$year']['ctd'].toInt(),
            oeByE4e['${e4e}7$year'] == null
                ? 0
                : oeByE4e['${e4e}7$year']['ctd'].toInt(),
            oeByE4e['${e4e}8$year'] == null
                ? 0
                : oeByE4e['${e4e}8$year']['ctd'].toInt(),
            oeByE4e['${e4e}9$year'] == null
                ? 0
                : oeByE4e['${e4e}9$year']['ctd'].toInt(),
            oeByE4e['${e4e}10$year'] == null
                ? 0
                : oeByE4e['${e4e}10$year']['ctd'].toInt(),
            oeByE4e['${e4e}11$year'] == null
                ? 0
                : oeByE4e['${e4e}11$year']['ctd'].toInt(),
            oeByE4e['${e4e}12$year'] == null
                ? 0
                : oeByE4e['${e4e}12$year']['ctd'].toInt(),
          ];
          // if(e4e == '330627'){
          //   print('oePorMes: $oePorMes');
          //   print('{e4e}7year: ${e4e}12$year');
          //   print('oeByE4e[{e4e}7year]: ${oeByE4e["${e4e}7$year"]}');
          // }
          List<int> stockPorMes = List.filled(12, 0);
          if (esteAno == year && plataformaByE4e[e4e] != null) {
            stockPorMes[esteMes - 1] = plataformaByE4e[e4e]['ctd'] ?? 0;
          }
          List<int> ofertaPorMes = [
            oePorMes[0] + stockPorMes[0],
            oePorMes[1] + stockPorMes[1],
            oePorMes[2] + stockPorMes[2],
            oePorMes[3] + stockPorMes[3],
            oePorMes[4] + stockPorMes[4],
            oePorMes[5] + stockPorMes[5],
            oePorMes[6] + stockPorMes[6],
            oePorMes[7] + stockPorMes[7],
            oePorMes[8] + stockPorMes[8],
            oePorMes[9] + stockPorMes[9],
            oePorMes[10] + stockPorMes[10],
            oePorMes[11] + stockPorMes[11],
          ];
          List<int> demandaPorMes = [
            pmcPorMes[0] + oraPorMes[0] + cePorMes[0],
            pmcPorMes[1] + oraPorMes[1] + cePorMes[1],
            pmcPorMes[2] + oraPorMes[2] + cePorMes[2],
            pmcPorMes[3] + oraPorMes[3] + cePorMes[3],
            pmcPorMes[4] + oraPorMes[4] + cePorMes[4],
            pmcPorMes[5] + oraPorMes[5] + cePorMes[5],
            pmcPorMes[6] + oraPorMes[6] + cePorMes[6],
            pmcPorMes[7] + oraPorMes[7] + cePorMes[7],
            pmcPorMes[8] + oraPorMes[8] + cePorMes[8],
            pmcPorMes[9] + oraPorMes[9] + cePorMes[9],
            pmcPorMes[10] + oraPorMes[10] + cePorMes[10],
            pmcPorMes[11] + oraPorMes[11] + cePorMes[11],
          ];
          List<int> proyectadoPorMes = List.filled(12, 0);
          if (year != esteAno) {
            esteMes = 1;
          }
          for (int i = esteMes - 1; i < 12; i++) {
            proyectadoPorMes[i] = ofertaPorMes[i] - demandaPorMes[i];
            if (i != 0) {
              proyectadoPorMes[i] += proyectadoPorMes[i - 1];
            }
            if (i == 0 && year != esteAno) {
              // sumar la posicion 11 del ano anterior
              proyectadoPorMes[i] += anoListSingle.mesList.last.proyectado;
            }
          }
          // List<Mes> mesList = [];
          for (int i = 0; i < 12; i++) {
            anoListSingle.mesList.add(
              Mes(
                mes: i + 1,
                ano: year,
                pmc: pmcPorMes[i],
                ora: oraPorMes[i],
                ce: cePorMes[i],
                demanda: demandaPorMes[i],
                oe: oePorMes[i],
                stock: stockPorMes[i],
                oferta: ofertaPorMes[i],
                proyectado: proyectadoPorMes[i],
              ),
            );
          }
        }
      }

      // print('anoList: $anoList');

      int anoActivo = fechasFEM.anoActivo;
      int mesActivo = fechasFEM.mesActivo;

      for (AnoList ano in anoList) {
        // if (ano.e4e == '330627') {
        //   print('ano.e4e: ${ano.e4e}');
        //   // print('mesActivo: $mesActivo');
        //   print('ano.mesList: ${ano.mesList}');
        // }
        Mes mesActivoSingle = ano.mesList
            .firstWhere((e) => e.mes == mesActivo && e.ano == anoActivo);
        int index = ano.mesList.indexOf(mesActivoSingle);
        int esteMes = fechaActual.month;
        List<Mes> mesList = ano.mesList.sublist(esteMes - 1, index + 1);
        int totalOe = mesList.fold(0, (a, b) => a + b.oe);
        int totalPmc = mesList.fold(0, (a, b) => a + b.pmc);
        int totalOra = mesList.fold(0, (a, b) => a + b.ora);
        int totalCe = mesList.fold(0, (a, b) => a + b.ce);
        int plataforma = mesList.fold(0, (a, b) => a + b.stock);

        disponibilidad.disponibilidadList.add(
          DisponibilidadSingle(
            e4e: ano.e4e,
            descripcion: ano.descripcion,
            um: ano.um,
            plataforma: plataforma.toString(),
            oe: totalOe.toString(),
            fem: totalPmc.toString(),
            otros: (totalOra + totalCe).toString(),
            total: mesActivoSingle.proyectado.toString(),
            mesFin: '${mesActivo.toString().padLeft(2, "0")}/$anoActivo',
          ),
        );
      }

      // print('anoList.length: ${anoList.length}');
      // print(
      //     'anoList 330627: ${anoList.where((element) => element.e4e == '330627').first.mesList}');
      emit(state().copyWith(disponibilidad: disponibilidad));
    } catch (e) {
      bl.errorCarga('Cálculo disponibilidad', e);
    }
  }

  Future<void> get crearConFechas async {
    Disponibilidad disponibilidad = Disponibilidad();
    Mm60 mm60 = state().mm60!;
    Plataforma plataforma = state().plataforma!;
    Oe oe = state().oe!;
    Fem fem = state().fem!;
    Versiones versiones = state().versiones!;
    FechasFEM fechasFEM = state().fechasFEM!;
    Map plataformaByE4e = plataforma.plataformaByE4e;
    List<AnoList> anoList = disponibilidad.anoList;
    Map oeByE4e = oe.oeByE4e;
    //-=----------------------------
    // Definir el año actual y año siguiente
    DateTime fechaActual = DateTime.now();
    fechaActual = DateTime(fechaActual.year, fechaActual.month, 1);
    int anoActual = fechaActual.year;
    int anoSiguiente = anoActual + 1;
    List<String> e4eList = obtenerE4E(
      years: [anoActual, anoSiguiente],
      fem: fem,
      versiones: versiones,
      plataformaByE4e: plataformaByE4e,
      oeE4eList: oe.e4eList,
    );

    Map dontRepeat = {};

    for (int j = 0; j < e4eList.length; j++) {
      String e4e = e4eList[j];
      await informarAvance(j, e4eList, dontRepeat);
      Mm60Single mm60Single = buscarMm60(e4e, mm60);
      String descripcion = mm60Single.descripcion;
      String um = mm60Single.um;
      bool isNotCreated = anoList.where((e) => e.e4e == e4e).isEmpty;
      if (isNotCreated) {
        anoList.add(AnoList(e4e: e4e, descripcion: descripcion, um: um));
      }
      AnoList anoListSingle = anoList.firstWhere((e) => e.e4e == e4e);
      for (MonthYear mesAno in monthYearList()) {
        List<FemSumSingle> ficha = fem.obtenerAnoSum(mesAno.year);
        List<VersionSumSingle> version = versiones.obtenerAnoSum(mesAno.year);
        // List<String> e4eListDemanda = e4eListDemandaFunc(ficha, version);
        int pmc = 0;
        int ora = 0;
        int ce = 0;
        int demanda = 0;
        EnableDateInt mesStatus =
            fechasFEM.enableDatesInt(mesAno.year)[mesAno.month]!;
        bool esteMes =
            mesAno.year == anoActual && mesAno.month == fechaActual.month;

        if (!mesStatus.entredoQ2) {
          pmc = ficha
              .firstWhere((e) => e.e4e == e4e,
                  orElse: () => FemSumSingle.fromInit())
              .campoyEstado(
                mesAno.month,
                entregadoQ1: mesStatus.entredoQ1,
                entregadoQ2: mesStatus.entredoQ2,
                abiertoQ1: mesStatus.pedidoActivoq1,
                abiertoQ2: mesStatus.pedidoActivoq2,
              );
          ora = version
              .firstWhere(
                (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ora',
                orElse: () => VersionSumSingle.zero(),
              )
              .campo(mesAno.month);
          ce = version
              .firstWhere(
                (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ce',
                orElse: () => VersionSumSingle.zero(),
              )
              .campo(mesAno.month);
          demanda = pmc + ora + ce;
        } else {
          pmc = ficha
              .firstWhere((e) => e.e4e == e4e,
                  orElse: () => FemSumSingle.fromInit())
              .campo(mesAno.month * 100 + 4); //pedido q1 + pedido q2 + ex
          if (esteMes) {
            pmc = 0;
          }
          ora = version
              .firstWhere(
                (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ora',
                orElse: () => VersionSumSingle.zero(),
              )
              .campo(mesAno.month);
          ce = version
              .firstWhere(
                (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ce',
                orElse: () => VersionSumSingle.zero(),
              )
              .campo(mesAno.month);
          demanda = pmc + ora + ce;
          // continue;
        }
        int oe = 0;
        if (oeByE4e['$e4e${mesAno.monthYear}'] != null) {
          oe = oeByE4e['$e4e${mesAno.monthYear}']['ctd'].floor().toInt();
        }
        int stock = 0;
        if (esteMes && plataformaByE4e[e4e] != null) {
          stock = plataformaByE4e[e4e]['ctd'];
        }
        int oferta = oe + stock;
        int proyectado = 0;
        bool esteMesMayor =
            (mesAno.year == anoActual && mesAno.month >= fechaActual.month) ||
                mesAno.year > anoActual;
        if (esteMesMayor) {
          proyectado = oe + stock - demanda;
        }
        if (esteMesMayor) {
          proyectado = proyectado +
              (anoListSingle.mesList.isNotEmpty
                  ? anoListSingle.mesList.last.proyectado
                  : 0);
        }
        anoListSingle.mesList.add(
          Mes(
            mes: mesAno.month,
            ano: mesAno.year,
            pmc: pmc,
            ora: ora,
            ce: ce,
            demanda: demanda,
            oe: oe,
            stock: stock,
            oferta: oferta,
            proyectado: proyectado,
          ),
        );
      }
    }
    int anoActivo = fechasFEM.anoActivo;
    int mesActivo = fechasFEM.mesActivo;

    for (AnoList ano in anoList) {
      Mes mesActivoSingle = ano.mesList.firstWhere((e) => e.mes == mesActivo);
      int index = ano.mesList.indexOf(mesActivoSingle);
      List<Mes> mesList = ano.mesList.sublist(0, index + 1);
      int totalOe = mesList.fold(0, (a, b) => a + b.oe);
      int totalPmc = mesList.fold(0, (a, b) => a + b.pmc);
      int totalOra = mesList.fold(0, (a, b) => a + b.ora);
      int totalCe = mesList.fold(0, (a, b) => a + b.ce);
      int plataforma = mesList.fold(0, (a, b) => a + b.stock);

      disponibilidad.disponibilidadList.add(
        DisponibilidadSingle(
          e4e: ano.e4e,
          descripcion: ano.descripcion,
          um: ano.um,
          plataforma: plataforma.toString(),
          oe: totalOe.toString(),
          fem: totalPmc.toString(),
          otros: (totalOra + totalCe).toString(),
          total: mesActivoSingle.proyectado.toString(),
          mesFin: '${mesActivo.toString().padLeft(2, "0")}/$anoActivo',
        ),
      );
    }

    // print('anoList.length: ${anoList.length}');
    // print(
    //     'anoList 330627: ${anoList.where((element) => element.e4e == '330627').first.mesList}');
    emit(state().copyWith(disponibilidad: disponibilidad));
  }

  Future<void> get crear async {
    Disponibilidad disponibilidad = Disponibilidad();
    Mm60 mm60 = state().mm60!;
    Plataforma plataforma = state().plataforma!;
    Oe oe = state().oe!;
    Fem fem = state().fem!;
    Versiones versiones = state().versiones!;
    //---------------------------------------------------------------

    Map plataformaByE4e = plataforma.plataformaByE4e;
    Map oeByE4e = oe.oeByE4e;
    DateTime fechaActual = DateTime.now();
    fechaActual = DateTime(fechaActual.year, fechaActual.month, 1);
    int anoActual = fechaActual.year;
    int mesActual = fechaActual.month;
    int mesesParaQuatrimestre = 0;
    for (int i = mesActual; i < 17; i++) {
      // print('i: $i, i % 4: ${i % 4}');
      if (i - mesActual >= 4 && i % 4 == 0) {
        mesesParaQuatrimestre = i - mesActual;
        i = 17;
      }
    }

    // Sumar 8 meses a la fecha actual
    DateTime nuevaFecha = sumarMeses(fechaActual, mesesParaQuatrimestre);
    int ano8Meses = nuevaFecha.year;
    int mes8meses = nuevaFecha.month;
    // print('Ano (8meses): $ano8Meses, mes: $mes8meses');

    List<int> anos = [];
    anos.add(anoActual);
    if (anoActual != ano8Meses) {
      anos.add(ano8Meses);
    }

    int mesinicio = mesActual;
    int mesfin = mes8meses;

    if (anoActual != ano8Meses) {
      mesinicio = 0;
      mesfin = 12;
    }

    List<String> e4eList = obtenerE4E(
      years: anos,
      fem: fem,
      versiones: versiones,
      plataformaByE4e: plataformaByE4e,
      oeE4eList: oe.e4eList,
    );
    // print('e4eList.length: ${e4eList.length}');
    // print('e4eList: $e4eList');

    for (int ano in anos) {
      //obtener la ficha FEM el año actual
      List<FemSumSingle> ficha = [];
      if (ano == 2024) ficha = fem.f2024Sum;
      if (ano == 2025) ficha = fem.f2025Sum;
      if (ano == 2026) ficha = fem.f2026Sum;
      if (ano == 2027) ficha = fem.f2027Sum;
      if (ano == 2028) ficha = fem.f2028Sum;

      //obtener la version oficial
      List<VersionSumSingle> version = [];
      if (ano == 2024) version = versiones.version2024;
      if (ano == 2025) version = versiones.version2025;
      if (ano == 2026) version = versiones.version2026;
      if (ano == 2027) version = versiones.version2027;
      if (ano == 2028) version = versiones.version2028;

      //Lista e4e combinado de version y ficha
      List<String> e4eListDemanda = [];
      for (int j = 0; j < ficha.length; j++) {
        FemSumSingle row = ficha[j];
        e4eListDemanda.add(row.e4e);
      }
      for (int j = 0; j < version.length; j++) {
        VersionSumSingle row = version[j];
        e4eListDemanda.add(row.e4e);
      }
      e4eListDemanda = e4eListDemanda.toSet().toList();
      e4eListDemanda.sort();
      // print('e4eListDemanda: ${e4eListDemanda.length}');

      if (ano == anoActual) {
        mesinicio = mesActual;
      } else {
        mesinicio = 1;
      }
      if (anoActual == ano8Meses) {
        mesfin = mes8meses;
      } else if (ano == anoActual) {
        mesfin = 12;
      } else {
        mesfin = mes8meses;
      }

      Map dontRepeat = {};
      for (int j = 0; j < e4eList.length; j++) {
        String e4e = e4eList[j];
        await informarAvance(j, e4eList, dontRepeat);
        Mm60Single mm60Single = mm60.mm60List.firstWhere(
            (e) => e.material == e4e,
            orElse: () => Mm60Single.fromInit());
        String descripcion = mm60Single.descripcion;
        String um = mm60Single.um;
        if (disponibilidad.disponibilidadMesList
            .where((e) => e.e4e == e4e)
            .isEmpty) {
          disponibilidad.disponibilidadMesList.add(
            DisponibilidadMesSingle(
              e4e: e4e,
              descripcion: descripcion,
              um: um,
            ),
          );
        }
        DisponibilidadMesSingle disponible = disponibilidad
            .disponibilidadMesList
            .firstWhere((e) => e.e4e == e4e);
        for (int i = mesinicio; i <= mesfin; i++) {
          String mes = i.toString().padLeft(2, "0");
          int pmc = 0;
          int ora = 0;
          int ce = 0;
          int demanda = 0;
          if (e4eListDemanda.contains(e4e)) {
            int j = i;
            if (i == mesinicio && ano == anoActual) {
              if (fechaActual.day < 15) {
                j = i * 100 + 2;
              } else {
                j = i * 100 + 3;
              }
            }
            pmc = ficha
                .firstWhere((e) => e.e4e == e4e,
                    orElse: () => FemSumSingle.fromInit())
                .campo(j);

            ora = version
                .firstWhere(
                  (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ora',
                  orElse: () => VersionSumSingle.zero(),
                )
                .campo(i);
            ce = version
                .firstWhere(
                  (e) => e.e4e == e4e && e.unidad.toLowerCase() == 'ce',
                  orElse: () => VersionSumSingle.zero(),
                )
                .campo(i);
            demanda = pmc + ora + ce;
          }
          int oe = 0;
          if (oeByE4e['$e4e$i$ano'] != null) {
            oe = oeByE4e['$e4e$i$ano']['ctd'].floor().toInt();
          }
          int stock = 0;
          if (ano == anoActual &&
              i == mesinicio &&
              plataformaByE4e[e4e] != null) {
            stock = plataformaByE4e[e4e]['ctd'];
          }
          int oferta = oe + stock;
          int proyectado = oe + stock - demanda;
          disponible.asignar('m${mes}pmc', pmc);
          disponible.asignar('m${mes}ora', ora);
          disponible.asignar('m${mes}ce', ce);
          disponible.asignar('m${mes}demanda', demanda);
          disponible.asignar('m${mes}oe', oe);
          disponible.asignar('m${mes}stock', stock);
          disponible.asignar('m${mes}oferta', oferta);
          if (i != mesinicio) {
            proyectado += disponible
                    .toMap()['m${(i - 1).toString().padLeft(2, "0")}proyectado']
                as int;
          } else if (ano != anoActual) {
            proyectado += disponible
                    .toMap()['m${(12).toString().padLeft(2, "0")}proyectado']
                as int;
          }
          disponible.asignar('m${mes}proyectado', proyectado);
        }
      }
    }
    for (DisponibilidadMesSingle disponibilidadMes
        in disponibilidad.disponibilidadMesList) {
      if (mesActual > 0 && mesActual <= 4) {
        disponibilidad.disponibilidadList.add(
          DisponibilidadSingle(
            e4e: disponibilidadMes.e4e,
            descripcion: disponibilidadMes.descripcion,
            um: disponibilidadMes.um,
            plataforma: disponibilidadMes.totalStock.toString(),
            oe: disponibilidadMes.totalOe.toString(),
            fem: disponibilidadMes.totalPmc.toString(),
            otros: (disponibilidadMes.totalOra + disponibilidadMes.totalCe)
                .toString(),
            total: disponibilidadMes.m08proyectado!.toString(),
            mesFin: '08/$ano8Meses',
          ),
        );
      } else if (mesActual > 4 && mesActual <= 8) {
        disponibilidad.disponibilidadList.add(
          DisponibilidadSingle(
            e4e: disponibilidadMes.e4e,
            descripcion: disponibilidadMes.descripcion,
            um: disponibilidadMes.um,
            plataforma: disponibilidadMes.totalStock.toString(),
            oe: disponibilidadMes.totalOe.toString(),
            fem: disponibilidadMes.totalPmc.toString(),
            otros: (disponibilidadMes.totalOra + disponibilidadMes.totalCe)
                .toString(),
            total: disponibilidadMes.m12proyectado!.toString(),
            mesFin: '12/$ano8Meses',
          ),
        );
      } else if (mesActual > 8 && mesActual <= 12) {
        disponibilidad.disponibilidadList.add(
          DisponibilidadSingle(
            e4e: disponibilidadMes.e4e,
            descripcion: disponibilidadMes.descripcion,
            um: disponibilidadMes.um,
            plataforma: disponibilidadMes.totalStock.toString(),
            oe: disponibilidadMes.totalOe.toString(),
            fem: disponibilidadMes.totalPmc.toString(),
            otros: (disponibilidadMes.totalOra + disponibilidadMes.totalCe)
                .toString(),
            total: disponibilidadMes.m04proyectado!.toString(),
            mesFin: '04/$ano8Meses',
          ),
        );
      }
    }
    disponibilidad.escazesList = disponibilidad.disponibilidadList
        .where((e) => (int.parse(e.fem) > 0 && int.parse(e.total) <= 0))
        .toList();
    disponibilidad.escazesListSearch = [...disponibilidad.escazesList];
    disponibilidad.disponibilidadListSearch = [
      ...disponibilidad.disponibilidadList
    ];

    //---------------------------------------------------------------
    emit(state().copyWith(disponibilidad: disponibilidad));
  }

  Future<void> informarAvance(
    int j,
    List<String> e4eList,
    Map<dynamic, dynamic> dontRepeat,
  ) async {
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

  List<String> e4eListDemandaFunc(
    List<FemSumSingle> ficha,
    List<VersionSumSingle> version,
  ) {
    List<String> e4eListDemanda = [];
    for (int j = 0; j < ficha.length; j++) {
      FemSumSingle row = ficha[j];
      e4eListDemanda.add(row.e4e);
    }
    for (int j = 0; j < version.length; j++) {
      VersionSumSingle row = version[j];
      e4eListDemanda.add(row.e4e);
    }
    e4eListDemanda = e4eListDemanda.toSet().toList();
    e4eListDemanda.sort();
    return e4eListDemanda;
  }

  Mm60Single buscarMm60(String e4e, Mm60 mm60) {
    return mm60.mm60List.firstWhere(
      (e) => e.material == e4e,
      orElse: () => Mm60Single.fromInit(),
    );
  }

  List<MonthYear> monthYearList() {
    List<MonthYear> monthYearList = [];
    int currentYear = DateTime.now().year;

    for (int year = currentYear; year <= currentYear + 1; year++) {
      for (int month = 1; month <= 12; month++) {
        monthYearList.add(MonthYear(month: month, year: year));
      }
    }

    return monthYearList;
  }

  double ala3(int j) => sqrt(sqrt(sqrt(j)));
}

class MonthYear {
  int month;
  int year;
  MonthYear({
    required this.month,
    required this.year,
  });

  String get monthYear => '$month$year';
}
