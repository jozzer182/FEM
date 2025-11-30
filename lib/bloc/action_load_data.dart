import 'package:fem_app/bloc/action_load_calculated.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/codigosconcomplementos/controller/codigosconcomplementos_controller.dart';
import 'package:fem_app/codigosporaprobar/controller/codigosporaprobar_controller.dart';

import '../alertaproyecto/controller/alertaproyecto_actions.dart';
import '../aportacion/controller/aportacion_actions.dart';
import '../budget/controller/budget_actions.dart';
import '../codigosadicionales/controller/codigosadicionales_controller.dart';
import '../codigoshabilitados/controller/codigoshabilitados_controller.dart';
import '../codigosoficiales/controller/codigosoficiales_action.dart';
import '../extratemp/controller/extra_actions.dart';
import '../fechas_fem/controller/fechasfem_actions.dart';
import '../fem/controller/fem_actions.dart';
import '../ficha/ficha_solpe/controller/solpe_list_controller.dart';
import '../mm60/controller/mm60_actions.dart';
import '../oe/controller/oe_actions.dart';
import '../oe_mes/controller/oemes_actions.dart';
import '../pdis/controller/pdis_actions.dart';
import '../pedidos/controller/pedidos_actions.dart';
import '../personas/controller/personas_actions.dart';
import '../plataforma/controller/plataforma_actions.dart';
import '../plataforma_mb51/controller/plataforma_mb51_controller.dart';
import '../resources/future_group_add.dart';
import '../sustitutos/controller/sustitutos_actions.dart';
import '../versiones/controller/versiones_actions.dart';
import '../wbe/controller/wbe_actions.dart';
import 'main__bl.dart';

onLoadData(Bl bl) async {
  try {
    MainState Function() state = bl.state;
    bool isLogged = state().user != null;
    if (!isLogged) {
      bl.mensaje(
          message:
              'Inicie sesión ó registrese si es la primera vez que ingresa.');
      return;
    }
    print('onLoadData');
    FutureGroupDelayed futureGeneral = FutureGroupDelayed();
    FutureGroupDelayed futureGroupFicha = FutureGroupDelayed();
    futureGroupFicha.addF(onLoadMm60(bl));
    futureGroupFicha.addF(onLoadFEM(bl));
    futureGroupFicha.addF(onLoadPlataforma(bl));
    futureGroupFicha.addF(onLoadOe(bl));
    futureGroupFicha.addF(onLoadBudget(bl));
    futureGroupFicha.addF(onLoadVersiones(bl));
    futureGroupFicha.addF(onLoadFechasFEM(bl));
    futureGroupFicha
        .addF(CodigosPorAprobarController(bl).onLoadCodigosPorAprobar);
    futureGroupFicha.addF(
        CodigosConComplementosController(bl).onLoadCodigosConComplementos);
    futureGroupFicha.close();
    futureGeneral
        .addF(futureGroupFicha.future.then((value) => onCalculatedData(bl)));

    FutureGroupDelayed futureGroup1 = FutureGroupDelayed();
    futureGroup1.addF(onLoadCodigosOficiales(bl));
    futureGroup1.addF(onLoadCodigosAdicionales(bl));
    futureGroup1.close();
    futureGeneral.addF(
        futureGroup1.future.then((value) => onCrearCodigosHabilitados(bl)));

    FutureGroupDelayed futureGroup2 = FutureGroupDelayed();
    futureGroup2.addF(onLoadExtra(bl));
    futureGroup2.addF(PlataformaMb51Controller(bl).obtener);
    // futureGroup2.addF();
    futureGroup2.addF(onLoadAlertaProyectos(bl));
    futureGroup2.addF(onLoadAportacion(bl));
    futureGroup2.addF(onLoadSustitutos(bl));
    futureGroup2.addF(onLoadWbe(bl));
    futureGroup2.addF(onLoadPdis(bl));
    futureGroup2.addF(onLoadPersonas(bl));
    futureGroup2.addF(onLoadPedidos(bl));
    futureGroup2.addF(onLoadOeMes(bl));
    futureGroup2.add(FichaSolPeListController(bl).obtener);

    futureGroup2.close();
    futureGeneral.addF(futureGroup2.future);

    futureGeneral.close();
    await futureGeneral.future;
    // await EstudioSolController(bl).obtener;
    // await PlataformaMb51Controller(bl).obtener;
    // await CodigosConComplementosController(bl).onLoadCodigosConComplementos;
  } catch (e) {
    bl.mensaje(message: e.toString());
  }
}
