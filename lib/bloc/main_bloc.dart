// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:fem_app/bloc/main__metodos.dart';
import 'package:fem_app/codigosporaprobar/controller/codigosporaprobar_controller.dart';
import 'package:fem_app/codigosporaprobar/model/codigosporaprobar_model.dart';
import 'package:fem_app/desplazartiempo/model/desplazartiempo_model.dart';
import 'package:fem_app/estudiosolicitudes/general/model/estudiosol_model.dart';
import 'package:fem_app/ficha/ficha_solicitados/controller/ficha_solicitados_controller.dart';
import 'package:fem_app/mensaje/controller/mensaje_actions.dart';
import 'package:fem_app/user/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fem_app/alertaproyecto/model/alertaproyecto_model.dart';
import 'package:fem_app/aportacion/model/aportacion_model.dart';
import 'package:fem_app/bloc/action_cargar2023.dart';
import 'package:fem_app/bloc/action_color.dart';
import 'package:fem_app/budget/model/budget_model.dart';
import 'package:fem_app/codigosadicionales/model/codigosadicionales_model.dart';
import 'package:fem_app/codigoshabilitados/model/codigoshabilitados_model.dart';
import 'package:fem_app/codigosoficiales/model/codigosoficiales_model.dart';
import 'package:fem_app/disponibilidad/model/disponibilidad_model.dart';
import 'package:fem_app/extratemp/model/extra_model.dart';
import 'package:fem_app/fechas_fem/model/fechasfem_model.dart';
import 'package:fem_app/fem/model/fem_model.dart';
import 'package:fem_app/fem/model/fem_model_dem.dart';
import 'package:fem_app/ficha/main/ficha/controller/fichas_action.dart';
import 'package:fem_app/ficha/main/ficha/model/ficha_model.dart';
import 'package:fem_app/ficha/main/fichas/model/fichas_model.dart';
import 'package:fem_app/mm60/model/mm60_model.dart';
import 'package:fem_app/nuevo/model/nuevo_model.dart';
import 'package:fem_app/oe/model/oe_model.dart';
import 'package:fem_app/oe/model/oe_sum_model.dart';
import 'package:fem_app/oe_mes/model/oemes_model.dart';
import 'package:fem_app/pdis/model/pdis_model.dart';
import 'package:fem_app/pedidos/model/pedidos_model.dart';
import 'package:fem_app/personas/model/personas_model.dart';
import 'package:fem_app/plataforma/model/plataforma_model.dart';
import 'package:fem_app/sustitutos/model/sustitutos_model.dart';
import 'package:fem_app/versiones/model/versiones_model.dart';
import 'package:fem_app/wbe/model/wbe_model.dart';

import '../analisiscodigo/controller/analisiscodigo_controller.dart';
import '../analisiscodigo/model/analisiscodigo_model.dart';
import '../codigosconcomplementos/controller/codigosconcomplementos_controller.dart';
import '../codigosconcomplementos/model/codigosconcomplementos_model.dart';
import '../desplazartiempo/controller/desplazar_ctrl.dart';
import '../estudiosolicitudes/general/controller/estudiosol_controller.dart';
import '../fem/controller/fem_actions.dart';
import '../fem/model/fem_model_single_fem.dart';
import '../ficha/ficha_eliminados/controller/ficha_eliminados_controller.dart';
import '../ficha/ficha_ficha/controller/ctrl_ficha.dart';
import '../ficha/ficha_agendados/controller/ficha_pedidos_controller.dart';
import '../ficha/ficha_solpe/controller/solpe_doc/solpe_doc_controller.dart';
import '../ficha/ficha_solpe/controller/solpe_list_controller.dart';
import '../ficha/ficha_solpe/model/solpe_doc.dart';
import '../ficha/ficha_solpe/model/solpe_list.dart';
import '../historico/controller/historico_controller.dart';
import '../nuevo/controller/nuevo_action.dart';
import '../plataforma_mb51/model/plataforma_mb51.dart';
import '../user/controller/user_actions.dart';
import 'action_load.dart';
import 'action_loading.dart';
import 'action_porcentaje.dart';
import 'main__bl.dart';

part 'main_event.dart';
part 'main_state.dart';
part '../fem/controller/fem_events.dart';
part '../mensaje/controller/mensaje_events.dart';
part '../user/controller/user_events.dart';
part '../codigosadicionales/controller/codigosadicionales_events.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<Load>(((event, emit) => onLoad(Bl(emit, passState, add))));
    // on<NewMessage>((ev, em) => onNewMessage(ev, em, passState));
    on<Loading>((ev, em) => onLoading(ev, em, passState));
    on<ThemeChange>((ev, em) => onThemeChange(ev, em, passState));
    on<ThemeColorChange>((ev, em) => onThemeColorChange(ev, em, passState));
    on<Mensaje>((ev, em) => onMensaje(ev, em, passState));
    on<CambiarUsuario>((ev, em) => onCambiarUsuario(ev, em, passState));
    on<Cargar2023>((ev, em) => onCargar2023(ev, em, passState));
    on<CambiarPorcentajeCarga>((ev, em) {
      return onCambiarPorcentajeCarga(ev, em, passState);
    });
    on<CambiarPorcentajeCargaDisponibilidad>((ev, em) {
      return onCambiarPorcentajeCargaDisponibilidad(ev, em, passState);
    });
    //FEM ACTIONS
    on<LoadFem>((ev, em) => onLoadFEM(Bl(emit, passState, add)));
    on<AddCesta>((ev, em) => onAddCesta(ev, em, passState));
    on<DeleteCesta>((ev, em) => onDeleteCesta(ev, em, passState));
    on<ModFemList>((ev, em) => onModFemList(ev, em, passState));
    on<ModFemDB>((ev, em) => onModFemDB(ev, em, passState));
    on<HoldCtd>((ev, em) => onHoldCtd(ev, em, passState));
    on<ModNuevo>((ev, em) => onModNuevo(ev, em, passState, add));
  }
  MainState passState() => state;
  Metodos metodos() => Metodos(Bl(emit, passState, add));
  FichasController fichasController() =>
      FichasController(Bl(emit, passState, add));
  HistoricoController historicoController() =>
      HistoricoController(Bl(emit, passState, add));
  CodigosPorAprobarController codigosPorAprobarController() =>
      CodigosPorAprobarController(Bl(emit, passState, add));
  CodigosConComplementosController codigosConComplementosController() =>
      CodigosConComplementosController(Bl(emit, passState, add));
  FichaPedidosController fichaPedidosController() =>
      FichaPedidosController(Bl(emit, passState, add));
  FichaEliminadosController fichaCambiosController() =>
      FichaEliminadosController(Bl(emit, passState, add));
  FichaSolicitadosController fichaSolicitadosController() =>
      FichaSolicitadosController(Bl(emit, passState, add));
  FichaFichaController fichaFichaController() =>
      FichaFichaController(Bl(emit, passState, add));
  AnalisisCodigoController analisisCodigoController() =>
      AnalisisCodigoController(Bl(emit, passState, add));
  EstudioSolController estudioSolController() =>
      EstudioSolController(Bl(emit, passState, add));

  DesplazarTiempoController desplazarTiempoController() =>
      DesplazarTiempoController(Bl(emit, passState, add));
  FichaSolPeListController get fichaSolPeListController =>
      FichaSolPeListController(bl);
  SolPeDocController get solPeDocController => SolPeDocController(bl);

  Bl get bl => Bl(emit, passState, add);
  load() => onLoad(Bl(emit, passState, add));
  mensaje({
    required String message,
    Color messageColor = Colors.red,
  }) {
    emit(
      state.copyWith(
        message: message,
        messageColor: messageColor,
        errorCounter: state.errorCounter + 1,
      ),
    );
  }
}
