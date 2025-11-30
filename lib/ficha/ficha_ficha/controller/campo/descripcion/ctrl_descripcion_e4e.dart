import 'package:flutter/material.dart';

import '../../../../../bloc/main__bl.dart';
import '../../../../../bloc/main_bloc.dart';
import '../../../../ficha_solicitados/model/ficha_solicitados_single_model.dart';
import '../../../model/ficha_reg/reg.dart';

class CtrlDescripcionE4e {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  FichaReg fichaReg;

  CtrlDescripcionE4e(this.bl, this.fichaReg) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  void get evaluar {
    _whenE4eIsEmpty();
    _whenE4eIsNotEmpty();
  }

  _whenE4eIsEmpty() {
    if (fichaReg.e4e.length != 6) {
      fichaReg.error.e4eColor = Colors.red;
      fichaReg.error.e4e = 'Se requiere un código E4E válido';
      fichaReg.error.wbeColor = null;
      fichaReg.error.wbeColorFill = Colors.transparent;
    }
  }

  _whenE4eIsNotEmpty() {
    if (fichaReg.e4e.length == 6) {
      fichaReg.error.e4eColor = null;
      fichaReg.error.e4e = '';
      _e4eIsHabilitado();
      _e4eRepetido();
      _e4eSolicitadoRepetido();
    }
  }

  _e4eIsHabilitado() {
    bool estaHabilitado = state()
        .codigosHabilitados!
        .codigoshabilitados
        .any((e) => e.e4e == fichaReg.e4e);
    if (!estaHabilitado) {
      fichaReg.error.e4eColor = Colors.red;
      fichaReg.error.e4e = 'CÓDIGO E4E NO ESTÁ HABILITADO';
      bl.mensaje(
          message:
              'La fila: ${fichaReg.item}  tiene el siguiente problema:\nNO HABILITADO: El código E4E no está habilitado en la tabla de códigos habilitados');
    } else {
      fichaReg.error.e4eColor = null;
      fichaReg.error.e4e = '';
    }
  }

  _e4eRepetido() {
    List<FichaReg> fichaModificada = state().ficha!.fficha.fichaModificada;
    List<String> e4eCtoFicha =
        fichaModificada.map((e) => '${e.circuito.trim()}${e.e4e}').toList();
    bool seRepiteEnFicha = e4eCtoFicha
            .where((e) => e == '${fichaReg.circuito.trim()}${fichaReg.e4e}')
            .length >
        1;
    if (seRepiteEnFicha) {
      fichaReg.error.e4eColor = Colors.red;
      fichaReg.error.e4e =
          'REPETIDO: La combinación E4E-Circuito ya está presente en la ficha';
      bl.mensaje(
          message:
              'La fila: ${fichaReg.item}  tiene el siguiente problema:\nREPETIDO: La combinación E4E-Circuito ya está presente en la ficha');
    }
  }

  _e4eSolicitadoRepetido() {
    //Dada la arquitectura, solo aplica para los nuevos-controlados (los que se les puede cambiar el e4e)
    //ya que CONTROLADO es sinonimo de SOLICITADO
    List<SolicitadoSingle> solicitados =
        state().ficha!.solicitados.solicitadosList;
    List<String> e4eCtoFicha =
        solicitados.map((e) => '${e.circuito.trim()}${e.e4e}').toList();
    bool seRepiteEnSolicitados = e4eCtoFicha
            .where((e) => e == '${fichaReg.circuito.trim()}${fichaReg.e4e}')
            .isNotEmpty;
    if (seRepiteEnSolicitados) {
      fichaReg.error.e4eColor = Colors.red;
      fichaReg.error.e4e =
          'REPETIDO: La combinación E4E-Circuito ya está presente en los solicitados, por favor elimínelo en SOLICITADOS e intente nuevamente';
      bl.mensaje(
          message:
              'La fila: ${fichaReg.item}  tiene el siguiente problema:\nREPETIDO: La combinación E4E-Circuito ya está presente en los solicitados, por favor eliminelo e intente nuevamente');
    }
  }
}
