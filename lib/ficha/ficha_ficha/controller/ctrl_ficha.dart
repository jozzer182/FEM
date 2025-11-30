import 'package:fem_app/bloc/main__bl.dart';
import 'package:fem_app/ficha/ficha_ficha/model/ficha__ficha_model.dart';

import '../../../bloc/main_bloc.dart';
import '../../main/ficha/model/ficha_model.dart';
import '../model/ficha_reg/reg.dart';
import 'campo/descripcion/ctrl_descripcion.dart';
import 'campo/numeros/ctrl_numeros.dart';
import 'ctrl_ficha_cambios.dart';
import 'ctrl_ficha_pegar_excel.dart';
import 'guardar/ctrl_ficha_guardar.dart';
import 'ctrl_ficha_lista.dart';
import 'inicial/ctrl_inicial.dart';

class FichaFichaController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late Ficha ficha;
  late FFicha fficha;

  FichaFichaController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    ficha = state().ficha!;
    fficha = state().ficha!.fficha;
  }

  void editar(bool editar) {
    fficha.editar = editar;
    fficha.fichaModificada = fficha.ficha.map((e) => e.copyWith()).toList();
    inicial.calculo;
    emit(state().copyWith(ficha: ficha));
  }

  void verDinero(bool verDinero) {
    fficha.verDinero = verDinero;
    fficha.fichaModificada = fficha.ficha.map((e) => e.copyWith()).toList();
    emit(state().copyWith(ficha: ficha));
  }

  CtrlDescripcion campoDescripcion({
    required String item,
  }) {
    Ficha ficha = state().ficha!;
    FFicha fficha = ficha.fficha;
    String year = state().year!;
    List<FichaReg> fichaModificada = fficha.fichaModificada;
    FichaReg fichaReg = fichaModificada.firstWhere(
      (e) => e.item == item,
      orElse: () => FichaReg.fromInit(0, year.substring(2)),
    );
    return CtrlDescripcion(bl, fichaReg);
  }

  CtrlNumeros campoNumeros({
    required String item,
  }) {
    Ficha ficha = state().ficha!;
    FFicha fficha = ficha.fficha;
    String year = state().year!;
    List<FichaReg> fichaModificada = fficha.fichaModificada;
    FichaReg fichaReg = fichaModificada.firstWhere(
      (e) => e.item == item,
      orElse: () => FichaReg.fromInit(0, year.substring(2)),
    );
    return CtrlNumeros(bl, fichaReg);
  }

  String get validar {
    String mensaje = '';
    List<FichaReg> fichaModificada = fficha.fichaModificada;
    for (var fichaReg in fichaModificada) {
      if (fichaReg.error.hayErrores) {
        mensaje += fichaReg.error.errores;
      }
    }
    return mensaje;
  }

  setMesDestino(String mes) {
    fficha.mesDestino = mes;
    emit(state().copyWith(ficha: ficha));
  }

  setMesOrigen(String mes) {
    fficha.mesOrigen = mes;
    emit(state().copyWith(ficha: ficha));
  }

  get realizarDesplazamiento {
    for (FichaReg fichaReg in fficha.fichaModificada) {
      String cantidadPlanificada =
          fichaReg.planificado.mes.get(fficha.mesOrigen);
      campoNumeros(item: fichaReg.item)
          .cambiar(mes: fficha.mesOrigen, value: '0');
      campoNumeros(item: fichaReg.item)
          .cambiar(mes: fficha.mesDestino, value: cantidadPlanificada);
    }
  }

  CtrlFfichaInicial get inicial => CtrlFfichaInicial(bl);

  CtrlFFichaGuardar get guardar => CtrlFFichaGuardar(bl);

  CtrlFFichaCambios get cambios => CtrlFFichaCambios(bl);

  CtrlFfichaLista get lista => CtrlFfichaLista(bl);

  CtrlFfichaPegarExcel get ctrlFichaPegarExcel => CtrlFfichaPegarExcel(bl);
}
