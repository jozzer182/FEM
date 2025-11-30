import 'dart:convert';

import 'package:fem_app/estudiosolicitudes/general/model/estudiosol_model.dart';
import 'package:fem_app/estudiosolicitudes/general/model/estudiosol_reg.dart';
import 'package:http/http.dart';

import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../fem/model/fem_model_single_fem.dart';
import '../../../resources/constant/apis.dart';
import '../../../resources/future_group_add.dart';
import '../../proyecto/controller/proyecto_controller.dart';
import 'estudiosol_llamadas.dart';

class EstudioSolController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  EstudioSol estudioSolInit = EstudioSol();

  EstudioSolController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get obtener async {
    estudioSolInit = EstudioSol();
    bl.startLoading;
    List<int> years = [
      2024,
      2025,
      2026,
      2027,
      2028,
    ];
    FutureGroupDelayed futureGroup = FutureGroupDelayed();
    for (int year in years) {
      futureGroup.addF(obtenerAno(year));
    }
    futureGroup.close();
    await futureGroup.future;
    try {
      proyecto.crear(estudioSolInit);
    } catch (e) {
      bl.errorCarga("Crear Proyecto", e);
    }
    emit(state().copyWith(estudioSol: estudioSolInit));
    bl.stopLoading;
  }

  EstudioProyectoController get proyecto => EstudioProyectoController(bl);

  obtenerAno(int year) async {
    try {
      List<EstudioSolReg> estudiosolList = estudioSolInit.list;
      Map<String, Object> dataSend = {
        'dataReq': {
          'libro': 'f${year}_solicitados',
          'hoja': 'reg',
        },
        'fname': "getHoja"
      };
      late Response response;
      // print('Estudio Solicitudes REQUEST: ${jsonEncode(dataSend)}');
      estudiosolList.clear();
      response = await post(
        Uri.parse(Api.fem),
        body: jsonEncode(dataSend),
      );
      var dataAsListMap = jsonDecode(response.body);
      if (dataAsListMap is! List || dataAsListMap.isEmpty) {
        return;
      }
      for (Map item in dataAsListMap) {
        estudiosolList.add(
            EstudioSolReg.fromMap(item as Map<String, dynamic>)..year = year);
      }
    } catch (e) {
      bl.errorCarga("Obtener Solicitados $year", e);
    }
  }

  setSolicitudEnviar(EstudioSolReg solicitud) {
    EstudioSol estudioSol = state().estudioSol!;
    estudioSol.solicitudEnviar = solicitud;
    emit(state().copyWith(estudioSol: estudioSol));
  }

  setComentario(String comentario) {
    EstudioSol estudioSol = state().estudioSol!;
    estudioSol.comentario = comentario;
    emit(state().copyWith(estudioSol: estudioSol));
  }

  enviarSolicitud(bool aprobar) async {
    await proyecto.enviarSolicitud(aprobar);
    await obtener;
  }

  setListEnviar(List<EstudioSolReg> listEnviar) {
    EstudioSol estudioSol = state().estudioSol!;
    estudioSol.listEnviar.clear();
    estudioSol.listEnviar = listEnviar;
    emit(state().copyWith(estudioSol: estudioSol));
  }

  enviarSolicitudList(bool aprobar) async {
    List<EstudioSolReg> listEnviar = state().estudioSol!.listEnviar;
    if (listEnviar.isEmpty) return;
    String comentario = state().estudioSol!.comentario;
    FutureGroupDelayed futureGroup = FutureGroupDelayed();
    futureGroup.add(llamadas.borrarSolicitudes(listEnviar));
    List<EstudioSolReg> listaFEM = [];
    List<EstudioSolReg> listaEliminados = [];
    for (EstudioSolReg solicitud in listEnviar) {
      solicitud.razonrespuesta = comentario;
      solicitud.respuesta = aprobar ? 'Aprobado' : 'Rechazado';
      solicitud.personarespuesta = state().user!.email;
      solicitud.fecharespuesta = DateTime.now().toString();
      bool esNuevo = listEnviar.first.id.isEmpty;
      if (aprobar) {
        if (esNuevo) {
          solicitud.fechainicial = solicitud.fecha;
          solicitud.solicitante = solicitud.persona;
          solicitud.comentario2 = solicitud.razon;
          listaFEM.add(solicitud);
        } else {
          List<SingleFEM> listFEM = state().fem!.obtenerAno(solicitud.year);
          SingleFEM fem = listFEM.firstWhere(
            (element) => element.id == solicitud.id,
            orElse: () => SingleFEM.fromInit(1),
          );
          EstudioSolReg solicitudVieja = EstudioSolReg.fromSingleFEM(fem)
            ..year = solicitud.year
            ..cambio = solicitud.cambio
            ..razon = solicitud.razon
            ..persona = solicitud.persona
            ..fecha = solicitud.fecha
            ..razonrespuesta = comentario
            ..respuesta = 'Aprobado(Reemplazado)'
            ..personarespuesta = state().user!.email
            ..fecharespuesta = DateTime.now().toString();
          listaFEM.add(solicitud);
          listaEliminados.add(solicitudVieja);
        }
      } else {
        solicitud.cambio = 'Rechazado - ${solicitud.cambio}';
        listaEliminados.add(solicitud);
      }
    }
    if (listaFEM.isNotEmpty) futureGroup.add(llamadas.agregarFEMs(listaFEM));
    if (listaEliminados.isNotEmpty) {
      futureGroup.add(llamadas.agregarEliminados(listaEliminados));
    }
    futureGroup.close();
    await futureGroup.future;

    await obtener;
  }

  EstudioSolLlamadasController get llamadas => EstudioSolLlamadasController(bl);
}
