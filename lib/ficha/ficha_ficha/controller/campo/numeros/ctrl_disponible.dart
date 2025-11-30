import 'package:fem_app/ficha/ficha_ficha/model/ficha__ficha_model.dart';

import '../../../../../bloc/main__bl.dart';
import '../../../../../bloc/main_bloc.dart';
import '../../../model/ficha_reg/reg.dart';
import '../../inicial/ctrl_disponible.dart';

class CtrlNumerosDisponible {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late FichaReg fichaReg;
  late FFicha fficha;
  CtrlNumerosDisponible(this.bl, this.fichaReg) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    fficha = state().ficha!.fficha;
  }

  void get evaluar {
    _correccionDisponibilidad;
  }

  void get _correccionDisponibilidad {
    CtrlFfichaInicialDisponibilidad disponibilidad = CtrlFfichaInicialDisponibilidad(bl);
    disponibilidad.calcular;
  }

}
