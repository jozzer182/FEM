import 'package:fem_app/budget/model/budget_model.dart';
import 'package:fem_app/ficha/ficha_eliminados/model/ficha_eliminados_model.dart';
import 'package:fem_app/ficha/ficha_ficha/model/ficha__ficha_model.dart';
import 'package:fem_app/ficha/ficha_agendados/model/ficha__pedidos_model.dart';
import 'package:fem_app/ficha/ficha_resumen/model/ficha__resumen_model.dart';
import 'package:fem_app/ficha/ficha_solicitados/model/ficha_solicitados_model.dart';

import '../../../../disponibilidad/model/disponibilidad_model.dart';
import '../../../../fechas_fem/model/fechasfem_model.dart';
import '../../../../fem/model/fem_model_single_fem.dart';
import '../../../../mm60/model/mm60_model.dart';
import '../../../../versiones/model/versiones_model.dart';
import '../../../ficha_ficha/model/ficha_reg/reg.dart';
import '../../../ficha_oficial/model/ficha__oficial_model.dart';

class Ficha {
  late FResumen resumen;
  late FPedidos fichaPedidos;
  late FFicha fficha;
  late FOficial oficial;
  Eliminados cambios = Eliminados();
  Solicitados solicitados = Solicitados();

  Ficha({
    required List<SingleFEM> ficha,
    required Mm60 mm60,
    required Budget budgetAll,
    required int year,
    required List<VersionesSingle> version,
    required Disponibilidad disponibilidad,
    required FechasFEM fechasFEM,
  }) {
    resumen = FResumen(
      year: year,
      budgetAll: budgetAll,
      mm60: mm60,
      version: version,
      ficha: ficha,
    );
    fichaPedidos = FPedidos(
      ficha: ficha,
      fechasFEM: fechasFEM,
    );
    fficha = FFicha(
      ficha: ficha.map((e) => FichaReg.fromSingleFEM(e)).toList(),
      version: version,
      disponibilidad: disponibilidad,
      year: year,
    );
    oficial = FOficial(
      version: version,
    );
  }
}
