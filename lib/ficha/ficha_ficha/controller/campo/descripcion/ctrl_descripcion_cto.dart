import 'package:flutter/material.dart';

import '../../../../../bloc/main__bl.dart';
import '../../../../../bloc/main_bloc.dart';
import '../../../model/ficha_reg/reg.dart';

class CtrlDescricpcionCto {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  FichaReg fichaReg;

  CtrlDescricpcionCto(this.bl, this.fichaReg) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  void get evaluar {
    _whenCtoIsNotEmpty();
  }

  _whenCtoIsNotEmpty() {
      fichaReg.error.circuitoColor = null;
      fichaReg.error.circuito = '';
      _ctoRepetido();
  }

  _ctoRepetido() {
    List<FichaReg> fichaModificada = state().ficha!.fficha.fichaModificada;
    List<String> e4eCtoFicha =
        fichaModificada.map((e) => '${e.circuito.trim()}${e.e4e}').toList();
    bool seRepiteEnFicha = e4eCtoFicha.where((e) => e == '${fichaReg.circuito.trim()}${fichaReg.e4e}').length > 1;
    if (seRepiteEnFicha) {
      fichaReg.error.circuitoColor = Colors.red;
      fichaReg.error.circuito =
          'REPETIDO: La combinación E4E-Circuito ya está presente en la ficha';
    }
  }
}
