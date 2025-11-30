import '../../../../../bloc/main__bl.dart';
import '../../../../../bloc/main_bloc.dart';
import '../../../../../codigoshabilitados/model/codigoshabilitados_model.dart';
import '../../../model/ficha_reg/reg.dart';

class CtrlDescripcionDescripcionUm {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  FichaReg fichaReg;

  CtrlDescripcionDescripcionUm(this.bl, this.fichaReg) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  void get evaluar {
    _e4eToDescripcionUm;
  }

  get _e4eToDescripcionUm {
    fichaReg.descripcion = state()
        .codigosHabilitados!
        .codigoshabilitados
        .firstWhere(
          (e) => e.e4e == fichaReg.e4e,
          orElse: () => CodigoHabilitado.fromInit(),
        )
        .descripcion;
    fichaReg.um = state()
        .codigosHabilitados!
        .codigoshabilitados
        .firstWhere(
          (e) => e.e4e == fichaReg.e4e,
          orElse: () => CodigoHabilitado.fromInit(),
        )
        .um;
  }
}
