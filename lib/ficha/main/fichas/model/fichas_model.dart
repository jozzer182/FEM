import 'package:async/async.dart';
import 'package:fem_app/versiones/model/versiones_model.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../../../budget/model/budget_model.dart';
import '../../../../disponibilidad/model/disponibilidad_model.dart';
import '../../../../fechas_fem/model/fechasfem_model.dart';
import '../../../../fem/model/fem_model.dart';
import '../../../../fem/model/fem_model_single_fem.dart';
import '../../../../mm60/model/mm60_model.dart';
import '../../ficha/model/ficha_model.dart';

class Fichas {
  List<Ficha> f2022 = [];
  List<Ficha> f2023 = [];
  List<Ficha> f2024 = [];
  List<Ficha> f2025 = [];
  List<Ficha> f2026 = [];
  List<Ficha> f2027 = [];
  List<Ficha> f2028 = [];

  Future<void> crear({
    required Fem fem,
    required Mm60 mm60,
    required Budget budgetAll,
    required Versiones versiones,
    required Disponibilidad disponibilidad,
    required Bl bl,
    required FechasFEM fechasFEM,
  }) async {
    List<List<SingleFEM>> femList = [
      fem.f2023,
      fem.f2024,
      fem.f2025,
      fem.f2026,
      fem.f2027,
      fem.f2028,
    ];
    List<List<Ficha>> fichasList = [f2023, f2024, f2025, f2026, f2027, f2028];
    List<List<VersionesSingle>> versionList = [
      versiones.v2023,
      versiones.v2024,
      versiones.v2025,
      versiones.v2026,
      versiones.v2027,
      versiones.v2028,
    ];
    FutureGroup futureGroup = FutureGroup();
    for (int i = 0; i < femList.length; i++) {
      Map proyectosUnicos = {};
      for (SingleFEM e in femList[i]) {
        if (proyectosUnicos[e.proyecto] == null) {
          proyectosUnicos[e.proyecto] = {
            'proyecto': e.proyecto,
          };
        }
      }
      futureGroup.add(
        Future.delayed(
          Duration.zero,
          () => agregarFichasALista(
            proyectos: proyectosUnicos.keys.map((e) => e.toString()).toList(),
            fichasList: fichasList,
            femList: femList,
            versionList: versionList,
            i: i,
            mm60: mm60,
            budgetAll: budgetAll,
            disponibilidad: disponibilidad,
            bl: bl,
            fechasFEM: fechasFEM,
          ),
        ),
      );
    }
    futureGroup.close();
    await futureGroup.future;
    // print('fichas: ${fichas.length}');
  }

  Future agregarFichasALista({
    required List<String> proyectos,
    required List<List<Ficha>> fichasList,
    required List<List<SingleFEM>> femList,
    required List<List<VersionesSingle>> versionList,
    required int i,
    required Mm60 mm60,
    required Budget budgetAll,
    required Disponibilidad disponibilidad,
    required Bl bl,
    required FechasFEM fechasFEM,
  }) async {
    var emit = bl.emit;
    MainState Function() state = bl.state;
    for (String proyecto in proyectos) {
      await Future.delayed(const Duration(milliseconds: 1));
      fichasList[i].add(
        Ficha(
          version: versionList[i]
              .where((e) => e.proyecto.toLowerCase() == proyecto.toLowerCase())
              .toList(),
          ficha: femList[i]
              .where((e) => e.proyecto.toLowerCase() == proyecto.toLowerCase())
              .toList(),
          mm60: mm60,
          budgetAll: budgetAll,
          year: 2023 + i,
          disponibilidad: disponibilidad,
          fechasFEM: fechasFEM,
        ),
      );
    }
    emit(state().copyWith(porcentajecarga: 17 + state().porcentajecarga));
  }
}
