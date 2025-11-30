import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/pedidos_model.dart';

Future onLoadPedidos(Bl bl) async {
  Pedidos pedidos = Pedidos();
  MainState Function() state = bl.state;
  try {
    await pedidos.obtener();
    bl.emit(state().copyWith(pedidos: pedidos));
  } catch (e) {
    bl.errorCarga("Pedidos", e);
  }
}
