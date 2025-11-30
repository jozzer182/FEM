import '../../fem/model/fem_model_single_fem.dart';

class DesplazarTiempo {
  bool soloNuevo = false;
  String razon = '';
  String cambios = '';
  List<String> para = ['jose.zarabandad@enel.com'];

  List<SingleFEM> f2024 = [];
  List<SingleFEM> f2025 = [];
  List<SingleFEM> f2026 = [];
  List<SingleFEM> f2027 = [];
  List<SingleFEM> f2028 = [];

  List<SingleFEM> f2024Modificada = [];
  List<SingleFEM> f2025Modificada = [];
  List<SingleFEM> f2026Modificada = [];
  List<SingleFEM> f2027Modificada = [];
  List<SingleFEM> f2028Modificada = [];

  List<SingleFEM> f2024Nuevos = [];
  List<SingleFEM> f2025Nuevos = [];
  List<SingleFEM> f2026Nuevos = [];
  List<SingleFEM> f2027Nuevos = [];
  List<SingleFEM> f2028Nuevos = [];

  List<SingleFEM> f2024Cambios = [];
  List<SingleFEM> f2025Cambios = [];
  List<SingleFEM> f2026Cambios = [];
  List<SingleFEM> f2027Cambios = [];
  List<SingleFEM> f2028Cambios = [];

  List<List<SingleFEM>> get allFEM => [
        f2024,
        f2025,
        f2026,
        f2027,
        f2028,
      ];

  List<List<SingleFEM>> get allFEMModificada => [
        f2024Modificada,
        f2025Modificada,
        f2026Modificada,
        f2027Modificada,
        f2028Modificada,
      ];

  List<List<SingleFEM>> get allFEMNuevos => [
        f2024Nuevos,
        f2025Nuevos,
        f2026Nuevos,
        f2027Nuevos,
        f2028Nuevos,
      ];

  List<List<SingleFEM>> get allFEMCambios => [
        f2024Cambios,
        f2025Cambios,
        f2026Cambios,
        f2027Cambios,
        f2028Cambios,
      ];
}
