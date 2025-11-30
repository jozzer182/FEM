import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../pedidos/model/pedidos_model.dart';
import '../model/extra_model.dart';

onLoadExtra(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Extra extra = Extra();
  try {
    await extra.obtener();
    await extra.crear2;
    extra.extraListBD.sort((a, b) => sortByPedidoExtra(a, b));
    extra.extraListSearchBD.sort((a, b) => sortByPedidoExtra(a, b));
    emit(state().copyWith(extra: extra));
  } catch (e) {
    bl.errorCarga("Extra", e);
  }
}

sortByPedidoExtra(PedidosSingle a, PedidosSingle b) {
  return toOrderString2(b.pedido).compareTo(toOrderString2(a.pedido));
}

String toOrderString2(String input) {
  if (input.isEmpty) {
    return '00000000';
  }
  List<String> partes = input.replaceAll('E', '').split('|');
  String mes = partes[0];
  String ano = partes[1];

  return '20$ano$mes';
}
