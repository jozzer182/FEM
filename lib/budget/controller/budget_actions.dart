import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../model/budget_model.dart';

onLoadBudget(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  Budget budget = Budget();
  try {
    await budget.obtener();
    emit(state().copyWith(budget: budget));
  } catch (e) {
    bl.errorCarga("Budget", e);
  }
}
