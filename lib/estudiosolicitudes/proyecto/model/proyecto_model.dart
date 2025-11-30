import '../../general/model/estudiosol_reg.dart';

class EstudioProyecto {
  List<EstudioSolReg> list = [];
  String proyecto = '';
  EstudioProyecto({
    this.list = const [],
    this.proyecto = '',
  });


  // factory EstudioProyecto.filter({
  //   required String filter,
  // }) {
  //   return EstudioProyecto(
  //     list: list.where((element) => element.year == filter).toList(),
  //     proyecto: '',
  //   );
  // }
}
