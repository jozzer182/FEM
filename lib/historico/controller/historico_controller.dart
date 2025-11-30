import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../fem/model/fem_model_single_fem.dart';
import '../model/historico_model.dart';

class HistoricoController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  HistoricoController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  Future<List<SingleFEM>> obtenerFicha(String year) async {
    Historico historico = Historico();
    try {
      List<SingleFEM> ficha = await historico.obtener(year);
      return ficha;
    } catch (e) {
      bl.errorCarga("Histórico", e);
      return [];
    }
  }
}
