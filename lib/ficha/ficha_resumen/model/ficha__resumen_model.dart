import '../../../budget/model/budget_model.dart';
import '../../../fem/model/fem_model_single_fem.dart';
import '../../../mm60/model/mm60_model.dart';
import '../../../resources/a_entero_2.dart';
import '../../../versiones/model/versiones_model.dart';

class FResumen {
  int year = 2023;
  List<BudgetSingle> budget = [];
  int tm01 = 0;
  int tm02 = 0;
  int tm03 = 0;
  int tm04 = 0;
  int tm05 = 0;
  int tm06 = 0;
  int tm07 = 0;
  int tm08 = 0;
  int tm09 = 0;
  int tm10 = 0;
  int tm11 = 0;
  int tm12 = 0;
  int tm01ped = 0;
  int tm02ped = 0;
  int tm03ped = 0;
  int tm04ped = 0;
  int tm05ped = 0;
  int tm06ped = 0;
  int tm07ped = 0;
  int tm08ped = 0;
  int tm09ped = 0;
  int tm10ped = 0;
  int tm11ped = 0;
  int tm12ped = 0;
  int tm01of = 0;
  int tm02of = 0;
  int tm03of = 0;
  int tm04of = 0;
  int tm05of = 0;
  int tm06of = 0;
  int tm07of = 0;
  int tm08of = 0;
  int tm09of = 0;
  int tm10of = 0;
  int tm11of = 0;
  int tm12of = 0;
  int get budgetMaterial {
    if (budget.isEmpty) {
      return 0;
    }
    if (budget
        .where((e) => e.naturaleza.toLowerCase() == 'materiales')
        .isEmpty) {
      return 0;
    }
    return budget
        .where((e) => e.naturaleza.toLowerCase() == 'materiales')
        .map((e) => e.campo(year))
        .reduce((value, element) => value + element);
  }

  int get budgetTotal {
    if (budget.isEmpty) {
      return 0;
    }
    return budget
        .map((e) => e.campo(year))
        .reduce((value, element) => value + element);
  }

  int get total => [
        tm01,
        tm02,
        tm03,
        tm04,
        tm05,
        tm06,
        tm07,
        tm08,
        tm09,
        tm10,
        tm11,
        tm12
      ].reduce((curr, next) => curr + next);
  int get totalof => [
        tm01of,
        tm02of,
        tm03of,
        tm04of,
        tm05of,
        tm06of,
        tm07of,
        tm08of,
        tm09of,
        tm10of,
        tm11of,
        tm12of
      ].reduce((curr, next) => curr + next);
  int get totalped => [
        tm01ped,
        tm02ped,
        tm03ped,
        tm04ped,
        tm05ped,
        tm06ped,
        tm07ped,
        tm08ped,
        tm09ped,
        tm10ped,
        tm11ped,
        tm12ped
      ].reduce((curr, next) => curr + next);
  int get tmax => [
        tm01,
        tm02,
        tm03,
        tm04,
        tm05,
        tm06,
        tm07,
        tm08,
        tm09,
        tm10,
        tm11,
        tm12
      ].reduce((curr, next) => curr > next ? curr : next);
  int get tmofmax => [
        tm01of,
        tm02of,
        tm03of,
        tm04of,
        tm05of,
        tm06of,
        tm07of,
        tm08of,
        tm09of,
        tm10of,
        tm11of,
        tm12of
      ].reduce((curr, next) => curr > next ? curr : next);

  FResumen({
    required this.year,
    required List<SingleFEM> ficha,
    required Mm60 mm60,
    required Budget budgetAll,
    required List<VersionesSingle> version,
  }) {
    for (int i = 0; i < ficha.length; i++) {
      ficha[i].item = (i + 1).toString().padLeft(2, '0');
      if (ficha[i].wbe.isEmpty) {
        int precio = aEntero(mm60.mm60List
            .firstWhere((e) => e.material == ficha[i].e4e,
                orElse: Mm60Single.fromInit)
            .precio);
        tm01 += ficha[i].m01 * precio;
        tm02 += ficha[i].m02 * precio;
        tm03 += ficha[i].m03 * precio;
        tm04 += ficha[i].m04 * precio;
        tm05 += ficha[i].m05 * precio;
        tm06 += ficha[i].m06 * precio;
        tm07 += ficha[i].m07 * precio;
        tm08 += ficha[i].m08 * precio;
        tm09 += ficha[i].m09 * precio;
        tm10 += ficha[i].m10 * precio;
        tm11 += ficha[i].m11 * precio;
        tm12 += ficha[i].m12 * precio;
        tm01ped += ficha[i].m01ped * precio;
        tm02ped += ficha[i].m02ped * precio;
        tm03ped += ficha[i].m03ped * precio;
        tm04ped += ficha[i].m04ped * precio;
        tm05ped += ficha[i].m05ped * precio;
        tm06ped += ficha[i].m06ped * precio;
        tm07ped += ficha[i].m07ped * precio;
        tm08ped += ficha[i].m08ped * precio;
        tm09ped += ficha[i].m09ped * precio;
        tm10ped += ficha[i].m10ped * precio;
        tm11ped += ficha[i].m11ped * precio;
        tm12ped += ficha[i].m12ped * precio;
      }
    }
    budget = budgetAll.budgetList
        .where(
            (e) => ficha[0].proyecto.toLowerCase() == e.proyecto.toLowerCase())
        .toList();
    for (VersionesSingle registro in version) {
      int precio = aEntero(mm60.mm60List
          .firstWhere((e) => e.material == registro.e4e,
              orElse: Mm60Single.fromInit)
          .precio);
      Iterable<SingleFEM> fem = ficha.where((e) => e.e4e == registro.e4e);
      if (fem.isNotEmpty && fem.first.wbe.isNotEmpty) {
        continue;
      }
      tm01of += aEntero(registro.m01) * precio;
      tm02of += aEntero(registro.m02) * precio;
      tm03of += aEntero(registro.m03) * precio;
      tm04of += aEntero(registro.m04) * precio;
      tm05of += aEntero(registro.m05) * precio;
      tm06of += aEntero(registro.m06) * precio;
      tm07of += aEntero(registro.m07) * precio;
      tm08of += aEntero(registro.m08) * precio;
      tm09of += aEntero(registro.m09) * precio;
      tm10of += aEntero(registro.m10) * precio;
      tm11of += aEntero(registro.m11) * precio;
      tm12of += aEntero(registro.m12) * precio;
    }
  }
}
