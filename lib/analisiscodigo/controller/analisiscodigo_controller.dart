import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';

class AnalisisCodigoController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  AnalisisCodigoController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  void setTotalOe(int value){
    emit(state().copyWith(analisisCodigo: state().analisisCodigo!.copyWith(totalOe: value)));
  }

  void setTotalFem(int value){
    emit(state().copyWith(analisisCodigo: state().analisisCodigo!.copyWith(totalFem: value)));
  }

  void setTotalOraCe(int value){
    emit(state().copyWith(analisisCodigo: state().analisisCodigo!.copyWith(totalOraCe: value)));
  }
}
