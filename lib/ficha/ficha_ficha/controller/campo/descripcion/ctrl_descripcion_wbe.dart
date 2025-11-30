import 'package:flutter/material.dart';
import 'package:statistics/statistics.dart';

import '../../../../../bloc/main__bl.dart';
import '../../../../../bloc/main_bloc.dart';
import '../../../../../plataforma/model/plataforma_model.dart';
import '../../../model/ficha_reg/reg.dart';

class CtrlDescripcionWBE {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  FichaReg fichaReg;

  CtrlDescripcionWBE(this.bl, this.fichaReg) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  void get evaluar {
    _e4eToWbe;
  }

  get _e4eToWbe {
    List<PlataformaSingle> plataformaList = state()
        .plataforma!
        .plataformaList
        .where((e) => e.material == fichaReg.e4e && !e.wbe.contains('CTEC'))
        .toList();
    fichaReg.error.wbeColor = null;
    fichaReg.error.wbeColorFill = Colors.transparent;
    fichaReg.error.wbe = '';
    bool isMandatory = plataformaList.all((e) => e.wbe.isNotEmpty);
    bool isNotRequired =
        plataformaList.all((e) => e.wbe.isEmpty) || plataformaList.isEmpty;
    // print('isNotRequired: $isNotRequired');
    if (isMandatory) {
      fichaReg.error.wbeColor = fichaReg.wbe.isEmpty ? Colors.red : null;
      fichaReg.error.wbe = fichaReg.wbe.isEmpty ? 'Se requiere una WBE' : '';
    }
    if (isNotRequired) {
      fichaReg.error.wbeColor = Colors.grey;
      fichaReg.error.wbeColorFill = Colors.grey;
    }
  }
}
