import 'package:fem_app/ficha/ficha_ficha/controller/guardar/ctrl_guardar_libres.dart';
import 'package:fem_app/resources/future_group_add.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../../main/ficha/model/ficha_model.dart';
import '../../model/ficha__ficha_model.dart';
import 'ctrl_guardar_controlados.dart';
import 'ctrl_guardar_eliminados.dart';

class CtrlFFichaGuardar {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late Ficha ficha;
  late FFicha fficha;

  CtrlFFichaGuardar(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    ficha = state().ficha!;
    fficha = state().ficha!.fficha;
  }

  Future<void> get guardar async {
    //se debe validar al lado del API la funcionalidad de guardar y agregar al mismo tiempo
    bl.startLoading;
    bl.mensajeFlotante(message: 'Por favor espere a que se recargue la página');
    FutureGroupDelayed fg = FutureGroupDelayed();
    if (fficha.libres.isNotEmpty) {
      fg.add(guardarLibres.enviar);
    }
    if (fficha.eliminados.isNotEmpty) {
      fg.add(guardarEliminados.enviar);
    }
    if (fficha.controlados.isNotEmpty) {
      fg.add(guardarControlados.enviar);
    }
    fg.close();
    await fg.future;
    bl.stopLoading;
    bl.recargar;
  }

  CtrlFFichaGuardarLibres get guardarLibres => CtrlFFichaGuardarLibres(bl);

  CtrlFFichaGuardarEliminados get guardarEliminados =>
      CtrlFFichaGuardarEliminados(bl);

  CtrlFFichaGuardarControlados get guardarControlados =>
      CtrlFFichaGuardarControlados(bl);
}
