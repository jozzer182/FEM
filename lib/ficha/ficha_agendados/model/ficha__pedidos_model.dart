import 'package:fem_app/ficha/ficha_eliminados/model/ficha_eliminados_single_model.dart';

import '../../../fechas_fem/model/fechasfem_model.dart';
import '../../../fem/model/fem_model_single_fem.dart';

class FPedidos {
  List<SingleFEM> ficha;
  late List<SingleFEM> fichaModificada;
  FechasFEM fechasFEM;
  bool editar = false;
  List<EliminadosSingle> cambios = [];
  List<SingleFEM> nuevos = [];
  
  FPedidos({
    required this.ficha,
    required this.fechasFEM,
  }) {
    fichaModificada = ficha.map((e) => e.copyWith()).toList();
  }
}
