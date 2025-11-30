import 'package:fem_app/resources/a_entero_2.dart';
import 'package:flutter/material.dart';

import '../../../../../bloc/main__bl.dart';
import '../../../../../bloc/main_bloc.dart';
import '../../../../main/ficha/model/ficha_model.dart';
import '../../../model/ficha__ficha_model.dart';
import '../../../model/ficha_reg/reg.dart';
import 'ctrl_disponible.dart';

class CtrlNumeros {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late Ficha ficha;
  late FFicha fficha;
  late FichaReg fichaReg;

  CtrlNumeros(this.bl, this.fichaReg) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    ficha = state().ficha!;
    fficha = state().ficha!.fficha;
  }

  cambiarLight({
    required String mes,
    required String value,
  }) {
    bool femExiste = fichaReg.item != '0';
    if (!femExiste) {
      _guardar(ficha); // previene el cambio
      return;
    }

    bool q1Activo = fichaReg.agendado.activoQuincena.get('$mes-1');
    bool q2Activo = fichaReg.agendado.activoQuincena.get('$mes-2');

    int q1agendado = fichaReg.agendado.quincena.get('$mes-1');
    int q2agendado = fichaReg.agendado.quincena.get('$mes-2');
    int qxagendado = fichaReg.agendado.quincena.get('$mes-x');

    if (q1Activo && q2Activo) {
      if (q1agendado == 0 && q2agendado == 0) _cambiarQ1toCero(mes, value);
      if (q1agendado != 0 && q2agendado == 0) _cambiarQ2careQ1(mes, value);
      if (q1agendado == 0 && q2agendado != 0) _cambiarQ1careQ2(mes, value);
      if (q1agendado != 0 && q2agendado != 0) {
        fichaReg.error.setError(
          mes: mes,
          error: 'No se puede cambiar, ya que ambas quincenas están agendadas.',
        );
        fichaReg.error.setColor(mes: mes, color: Colors.red);
      }
    }

    if (!q1Activo && q2Activo) {
      if (q1agendado == 0 && qxagendado == 0) _cambiarjustQ2(mes, value);
      if (q1agendado != 0 || qxagendado != 0) _cambiarQ2careQ1(mes, value);
    }

    if (!q1Activo && !q2Activo) {
      if (aEntero(value) > 0) {
        bl.mensaje(
            message:
                'NO ACTIVO | e4e: ${fichaReg.e4e} mes: $mes, value: $value');
      }
      // fichaReg.error.setError(
      //   mes: mes,
      //   error: 'No deberias ver este mensaje, ya que no hay quincenas activas.',
      // );
      // fichaReg.error.setColor(mes: mes, color: Colors.red);
    }
  }

  cambiar({
    required String mes,
    required String value,
  }) {
    cambiarLight(mes: mes, value: value);
    _reglasPos();
    _guardar(ficha);
  }

  _guardar(Ficha ficha) {
    return emit(state().copyWith(ficha: ficha));
  }

  _reglasPos() {
    disponible.evaluar;
  }

  CtrlNumerosDisponible get disponible => CtrlNumerosDisponible(bl, fichaReg);

  _cambiarQ1toCero(String mes, String value) {
    fichaReg.error.setError(mes: mes, error: '');
    fichaReg.error.setColor(mes: mes, color: null);
    fichaReg.setWithQuincena('$mes-1', '0');
    fichaReg.setWithQuincena('$mes-2', value);
  }

  _cambiarjustQ2(String mes, String value) {
    fichaReg.error.setError(mes: mes, error: '');
    fichaReg.error.setColor(mes: mes, color: null);
    fichaReg.setWithQuincena('$mes-2', value);
  }

  _cambiarQ2careQ1(String mes, String value) {
    int q1agendado = fichaReg.agendado.quincena.get('$mes-1');
    int qxagendado = fichaReg.agendado.quincena.get('$mes-x');
    int agendado = q1agendado + qxagendado;
    int valor = aEntero(value);
    int delta = valor - agendado;
    if (delta < 0) {
      fichaReg.error.setError(
        mes: mes,
        error:
            'Valor no puede ser menor a $agendado que es lo agendado en la primera quincena y/o lo extratemporal.',
      );
      fichaReg.error.setColor(mes: mes, color: Colors.red);
      fichaReg.setWithQuincena('$mes-2', delta.toString());
    } else {
      fichaReg.error.setError(mes: mes, error: '');
      fichaReg.error.setColor(mes: mes, color: null);
      fichaReg.setWithQuincena('$mes-2', delta.toString());
    }
  }

  _cambiarQ1careQ2(String mes, String value) {
    int q2agendado = fichaReg.agendado.quincena.get('$mes-2');
    int qxagendado = fichaReg.agendado.quincena.get('$mes-x');
    int agendado = q2agendado + qxagendado;
    int valor = aEntero(value);
    int delta = valor - agendado;
    if (delta < 0) {
      fichaReg.error.setError(
        mes: mes,
        error:
            'Valor no puede ser menor a $agendado que es lo agendado en la segunda quincena y/o lo extratemporal.',
      );
      fichaReg.error.setColor(mes: mes, color: Colors.red);
    } else {
      fichaReg.error.setError(mes: mes, error: '');
      fichaReg.error.setColor(mes: mes, color: null);
      fichaReg.setWithQuincena('$mes-1', delta.toString());
    }
  }
}
