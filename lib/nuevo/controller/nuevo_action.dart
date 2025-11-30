//modificar el listado de nuevos
import 'package:get/get.dart';

import '../../bloc/main_bloc.dart';
import '../../pdis/model/pdis_model.dart';
import '../../wbe/model/wbe_model.dart';

void onModNuevo(
  ModNuevo e,
  emit,
  MainState Function() state,
  add,
) async {
  if (e.tabla == "nuevo") {
    var ref = state().nuevo!.encabezado;
    if (e.campo == 'ano') {
      ref.ano = e.valor;
      state().nuevo!.enableDatesMethod(
            fechasFEM: state().fechasFEM!,
            ano: e.valor,
          );
    }
    if (e.campo == 'proyecto') {
      state().nuevo!.procesarProyecto(
            budget: state().budget!,
            e: e,
          );
    }
    if (e.campo == 'codigo') ref.codigo = e.valor;
    if (e.campo == 'unidad') ref.unidad = e.valor;
    if (e.campo == 'solicitante') ref.solicitante = e.valor;
    if (e.campo == 'pm') ref.pm = e.valor;
    if (e.campo == 'comentario1') ref.comentario1 = e.valor;
    if (e.campo == 'estado') ref.estado = e.valor;
    if (e.campo == 'estdespacho') ref.estdespacho = e.valor;
    if (e.campo == 'tipo') ref.tipo = e.valor;
    if (e.campo == 'fechainicial') ref.fechainicial = e.valor;
    if (e.campo == 'fechafinal') ref.fechafinal = e.valor;
    if (e.campo == 'fechacambio') ref.fechacambio = e.valor;
    if (e.campo == 'fechasolicitud') ref.fechasolicitud = e.valor;
  }
  if (e.tabla == "nuevoRows") {
    var ref = state().nuevo!;
    if (e.campo == 'agregar') ref.agregar;
    if (e.campo == 'quitar') ref.quitar;
    if (e.campo == 'resize') ref.resize(e.valor);
  }
  if (e.tabla == 'nuevoList') {
    var ref = state().nuevo!.nuevoList;
    if (e.campo == 'e4e') {
      ref[e.index ?? 0].e4e = e.valor;
      if (e.valor.length == 6) {
        state().nuevo!.procesarE4E(
              mm60: state().mm60!,
              plataforma: state().plataforma!,
              fem: state().fem!,
              e: e,
              disponibilidad: state().disponibilidad!,
            );
      }
    }
    if (e.campo == 'wbe') ref[e.index ?? 0].wbe = e.valor;
    if (e.campo == 'proyectowbe') ref[e.index ?? 0].proyectowbe = e.valor;
    if (e.campo == 'pdi') ref[e.index ?? 0].pdi = e.valor;
    if (e.campo == 'comentario2') ref[e.index ?? 0].comentario2 = e.valor;
    if (e.campo == 'circuito') {
      ref[e.index ?? 0].circuito = e.valor;
      // if (e.valor.length == 6) {
      state().nuevo!.procesarE4E(
            mm60: state().mm60!,
            plataforma: state().plataforma!,
            fem: state().fem!,
            e: ModNuevo(
                valor: ref[e.index ?? 0].e4e,
                campo: e.campo,
                tabla: e.tabla,
                index: e.index),
            disponibilidad: state().disponibilidad!,
          );
      // }
    }
    if (e.campo == 'm01q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm01q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm02q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm02q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm03q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm03q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm04q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm04q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm05q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm05q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm06q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm06q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm07q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm07q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm08q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm08q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm09q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm09q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm10q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm10q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm11q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm11q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm12q1') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
    if (e.campo == 'm12q2') {
      state().nuevo!.procesarCantidad(mm60: state().mm60!, e: e);
    }
  }

  if (e.tabla == 'nuevoSave') {
    emit(state().copyWith(isLoading: true));
    if (state().nuevo?.validar != null) {
      emit(state().copyWith(
        messageCounter: state().messageCounter + 1,
        dialogMessage: state().nuevo?.validar?.join('\n'),
      ));
    } else {
      String? respuesta;
      try {
        respuesta = await state().nuevo?.enviar;
        add(Load());
        Get.back();
      } catch (e) {
        emit(state().copyWith(
          errorCounter: state().errorCounter + 1,
          message:
              '🤕Error enviando los datos de la planilla: ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
        ));
      }
      emit(state().copyWith(
        messageCounter: state().messageCounter + 1,
        dialogMessage: respuesta ?? 'Error en el envío',
      ));
    }
  }

  if (e.tabla == "extra") {
    var ref = state().extra!.encabezado;
    if (e.campo == 'ano') {
      state().extra!.enableDatesMethod(
            fechasFEM: state().fechasFEM!,
          );
    }
    if (e.campo == 'proyecto') {
      state().extra!.procesarProyecto(
            budget: state().budget!,
            e: e,
          );
      state().extra!.enableDatesMethod(
            fechasFEM: state().fechasFEM!,
          );
    }
    if (e.campo == 'codigo') ref.codigo = e.valor;
    if (e.campo == 'unidad') ref.unidad = e.valor;
    if (e.campo == 'solicitante') ref.solicitante = e.valor;
    if (e.campo == 'pm') ref.pm = e.valor;
    if (e.campo == 'comentario1') ref.comentario1 = e.valor;
    if (e.campo == 'estado') ref.estado = e.valor;
    if (e.campo == 'fechacambio') ref.fechacambio = e.valor;
  }

  if (e.tabla == "extraRows") {
    var ref = state().extra!;
    if (e.campo == 'agregar') ref.agregar;
    if (e.campo == 'quitar') ref.quitar;
    if (e.campo == 'resize') ref.resize(e.valor);
  }
  if (e.tabla == 'extraList') {
    var ref = state().extra!.extraList;
    if (e.campo == 'e4e') {
      ref[e.index ?? 0].e4e = e.valor;
      if (e.valor.length == 6) {
        state().extra!.procesarE4E(
              mm60: state().mm60!,
              plataforma: state().plataforma!,
              fem: state().fem!,
              e: e,
              disponibilidad: state().disponibilidad!,
              state: state,
            );
      }
    }
    if (e.campo == 'ctd') {
      state().extra!.procesarCantidad(
            mm60: state().mm60!,
            e: e,
          );
    }
    if (e.campo == 'wbe') {
      WbeSingle wbe = state().wbe!.wbeList.firstWhere((o) => o.wbe == e.valor,
          orElse: () => WbeSingle.fromZero());
      ref[e.index ?? 0].wbe = e.valor;
      ref[e.index ?? 0].wbeparte = wbe.wbe1;
      ref[e.index ?? 0].wbeestado = wbe.status;
    }
    if (e.campo == 'proyectowbe') ref[e.index ?? 0].wbeproyecto = e.valor;
    if (e.campo == 'ctdf') ref[e.index ?? 0].ctdf = e.valor;
    if (e.campo == 'tipoenvio') ref[e.index ?? 0].tipoenvio = e.valor;
    if (e.campo == 'pdi') {
      ref[e.index ?? 0].pdi = e.valor;
      ref[e.index ?? 0].pdiname = (state().pdis!.pdisList.firstWhere(
          (o) => o.lote == e.valor,
          orElse: () => PdisSingle.fromZero())).almacen;
    }
    if (e.campo == 'comentario2') ref[e.index ?? 0].comentario2 = e.valor;
    if (e.campo == 'circuito') {
      ref[e.index ?? 0].ref = e.valor;
      state().extra!.procesarE4E(
            mm60: state().mm60!,
            plataforma: state().plataforma!,
            fem: state().fem!,
            e: ModNuevo(
                valor: ref[e.index ?? 0].e4e,
                campo: e.campo,
                tabla: e.tabla,
                index: e.index),
            disponibilidad: state().disponibilidad!,
            state: state,
          );
    }
  }

  if (e.tabla == 'extraSave') {
    emit(state().copyWith(isLoading: true));
    if (state().extra?.validar != null) {
      emit(state().copyWith(
        messageCounter: state().messageCounter + 1,
        dialogMessage: state().extra?.validar?.join('\n'),
      ));
    } else {
      List? respuestas;
      try {
        respuestas = await state().extra?.enviar;
        // await state().extra?.enviar;
        add(Load());
        Get.back();
      } catch (e) {
        emit(state().copyWith(
          errorCounter: state().errorCounter + 1,
          message:
              '🤕Error enviando los datos de la planilla: ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
        ));
      }
      respuestas?.join('\n') ?? add(Load());
      emit(state().copyWith(
        messageCounter: state().messageCounter + 1,
        dialogMessage: respuestas?.join('\n') ??
            'Error, consultar a yuly.barretorodriguez@enel.com, porque es posible que si se haya guardado',
      ));
    }
  }

  emit(state().copyWith(isLoading: false));
  emit(state().copyWith());
}
