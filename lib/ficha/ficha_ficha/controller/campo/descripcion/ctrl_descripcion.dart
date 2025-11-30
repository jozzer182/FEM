import 'package:fem_app/ficha/ficha_ficha/controller/campo/descripcion/ctrl_descripcion_e4e.dart';

import '../../../../../bloc/main__bl.dart';
import '../../../../../bloc/main_bloc.dart';
import '../../../../main/ficha/model/ficha_model.dart';
import '../../../model/ficha_reg/reg_enum.dart';
import '../../../model/ficha_reg/reg.dart';
import '../../inicial/ctrl_inicial.dart';
import 'ctrl_descripcion_cto.dart';
import 'ctrl_descripcion_descripcion_um.dart';
import 'ctrl_descripcion_wbe.dart';

class CtrlDescripcion {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  FichaReg fichaReg;

  CtrlDescripcion(this.bl, this.fichaReg) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  bool _reglasPre({
    required TipoRegFicha tipo,
    required String value,
  }) {
    return true;
  }

  cambiar({
    required TipoRegFicha tipo,
    required String value,
  }) {
    bool femExiste = fichaReg.item != '0';
    if (!femExiste) {
      _guardar; // previene el cambio
      return;
    }

    bool isOk = _reglasPre(
      tipo: tipo,
      value: value,
    );

    if (isOk) {
      fichaReg.setWithEnum(value: value, tipo: tipo);
      _reglasPos(tipo: tipo);
    }
    _guardar;
  }

  get _guardar {
    Ficha ficha = state().ficha!;
    return emit(state().copyWith(ficha: ficha));
  }

  _reglasPos({
    required TipoRegFicha tipo,
  }) {
    e4e.evaluar;
    cto.evaluar;
    wbe.evaluar;
    descripcionUm.evaluar;
    inicial.calculo;
  }

  CtrlDescripcionE4e get e4e => CtrlDescripcionE4e(bl, fichaReg);

  CtrlDescricpcionCto get cto => CtrlDescricpcionCto(bl, fichaReg);

  CtrlDescripcionWBE get wbe => CtrlDescripcionWBE(bl, fichaReg);

  CtrlDescripcionDescripcionUm get descripcionUm =>
      CtrlDescripcionDescripcionUm(bl, fichaReg);

  CtrlFfichaInicial get inicial => CtrlFfichaInicial(bl);    
}
