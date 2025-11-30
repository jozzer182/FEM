import 'package:fem_app/ficha/main/fichas/model/fichas_model.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../model/ficha_enum.dart';
import '../model/ficha_model.dart';

class FichasController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  FichasController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  Future<void> onCrearFichas() async {
    var emit = bl.emit;
    MainState Function() state = bl.state;
    Fichas fichas = Fichas();
    try {
      await fichas.crear(
        fem: state().fem!,
        mm60: state().mm60!,
        budgetAll: state().budget!,
        versiones: state().versiones!,
        disponibilidad: state().disponibilidad!,
        bl: bl,
        fechasFEM: state().fechasFEM!,
      );
      emit(state().copyWith(fichas: fichas));
    } catch (e) {
      bl.errorCarga("Fichas", e);
    }
  }

  onSeleccionarYear({
    required String year,
  }) {
    try {
      emit(state().copyWith(year: year));
    } catch (e) {
      bl.mensaje(
        message: '🤕Error seleccionando año ⚠️$e => ${e.runtimeType},' +
            'intente recargar la página🔄',
      );
    }
  }

  onSeleccionarFicha({
    required Ficha ficha,
  }) {
    try {
      emit(state().copyWith(ficha: ficha));
    } catch (e) {
      bl.mensaje(
        message: '🤕Error seleccionando ficha ⚠️$e => ${e.runtimeType}',
      );
    }
  }

  onCambiarFicha({
    required CampoFicha campo,
    required String valor,
    required int item,
  }) async {
    Ficha ficha = state().ficha!;
    // ficha.asignar(
    //   valor: valor,
    //   item: item,
    //   campo: campo,
    // );
    //esperar 100 milisegundos
    await Future.delayed(const Duration(milliseconds: 100), () {
      emit(state().copyWith(ficha: ficha));
    });
  }
}
