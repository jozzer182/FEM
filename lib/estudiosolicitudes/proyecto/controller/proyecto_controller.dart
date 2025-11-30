import '../../../bloc/main__bl.dart';
import '../../../bloc/main_bloc.dart';
import '../../../fem/model/fem_model_single_fem.dart';
import '../../../resources/future_group_add.dart';
import '../../general/model/estudiosol_model.dart';
import '../../general/model/estudiosol_reg.dart';
import '../model/proyecto_model.dart';
import 'proyecto_llamadas.dart';

class EstudioProyectoController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  EstudioProyectoController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  void crear(EstudioSol estudioSol) {
    List<EstudioSolReg> solicitudesList = estudioSol.list;
    for (EstudioSolReg solicitud in solicitudesList) {
      if (solicitud.proyecto != '') {
        EstudioProyecto estudioProyecto = EstudioProyecto(
          proyecto: solicitud.proyecto,
          list: [solicitud],
        );
        if (estudioSol.listProyecto.isEmpty) {
          estudioSol.listProyecto.add(estudioProyecto);
        } else {
          bool existe = false;
          for (EstudioProyecto elementProyecto in estudioSol.listProyecto) {
            if (elementProyecto.proyecto == solicitud.proyecto) {
              elementProyecto.list.add(solicitud);
              existe = true;
              break;
            }
          }
          if (!existe) {
            estudioSol.listProyecto.add(estudioProyecto);
          }
        }
      }
    }
  }

  Future enviarSolicitud(bool aprobar) async {
    EstudioSolReg? solicitudEnviar = state().estudioSol!.solicitudEnviar;
    if (solicitudEnviar == null) return;
    String comentario = state().estudioSol!.comentario;
    solicitudEnviar.razonrespuesta = comentario;
    solicitudEnviar.respuesta = aprobar ? 'Aprobado' : 'Rechazado';
    solicitudEnviar.personarespuesta = state().user!.email;
    solicitudEnviar.fecharespuesta = DateTime.now().toString();
    bool esNuevo = solicitudEnviar.id.isEmpty;
    FutureGroupDelayed futureGroup = FutureGroupDelayed();
    futureGroup.add(llamadas.borrarSolicitud(solicitudEnviar));
    if (esNuevo) {
      if (aprobar) {
        solicitudEnviar.fechainicial = solicitudEnviar.fecha;
        solicitudEnviar.solicitante = solicitudEnviar.persona;
        solicitudEnviar.comentario2 = solicitudEnviar.razon;
        futureGroup.add(llamadas.agregarFEM(solicitudEnviar));
      } else {
        solicitudEnviar.cambio = 'Nuevo (Rechazado)';
        futureGroup.add(llamadas.agregarEliminados(solicitudEnviar));
      }
    } else {
      if (aprobar) {
        //Encontrar registro viejo
        List<SingleFEM> listFEM = state().fem!.obtenerAno(solicitudEnviar.year);
        SingleFEM fem = listFEM.firstWhere(
          (element) => element.id == solicitudEnviar.id,
          orElse: () => SingleFEM.fromInit(1),
        );
        EstudioSolReg solicitudVieja = EstudioSolReg.fromSingleFEM(fem)
          ..year = solicitudEnviar.year
          ..cambio = solicitudEnviar.cambio
          ..razon = solicitudEnviar.razon
          ..persona = solicitudEnviar.persona
          ..fecha = solicitudEnviar.fecha
          ..razonrespuesta = comentario
          ..respuesta = 'Aprobado(Reemplazado)'
          ..personarespuesta = state().user!.email
          ..fecharespuesta = DateTime.now().toString();
        futureGroup.add(llamadas.agregarFEM(solicitudEnviar));
        futureGroup.add(llamadas.agregarEliminados(solicitudVieja));
      } else {
        futureGroup.add(llamadas.agregarEliminados(solicitudEnviar));
      }
    }
    futureGroup.close();
    await futureGroup.future;
  }

  EstudioProyectoLLamadasController get llamadas =>
      EstudioProyectoLLamadasController(bl);
}
