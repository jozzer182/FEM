import 'disponibilidad_only_month.dart';

class AnoList {
  List<Mes> mesList = [];
  String e4e;
  String descripcion;
  String um;

  List<List<int>> get disponibilidadList {
    List<List<int>> list = [];
    for (int i = 0; i < mesList.length; i++) {
      Mes mes = mesList[i];
      list.add([
        i, //0
        mes.mes, //1
        mes.ano, //2
        mes.pmc, //3
        mes.ora, //4
        mes.ce, //5
        mes.demanda, //6
        mes.oe, //7
        mes.stock, //8
        mes.oferta, //9
        mes.proyectado, //10
      ]);
    }
    return list;
  }
  
  AnoList({
    required this.e4e,
    required this.descripcion,
    required this.um,
  });

  String get roturaStock {
    for (Mes mes in mesList) {
      print('mesList Proyectado: ${mes}');
      if (mes.proyectado <0) {
        return '${mes.mes.toString().padLeft(2, "0")}/${mes.ano}';
      }
    }
    return 'No hay rotura de stock';
  }

  factory AnoList.zero() {
    List<Mes> mesList = [];
    for (int i = 1; i < 13; i++) {
      mesList.add(Mes.zero());
    }
    return AnoList(
      e4e: '',
      descripcion: '',
      um: '',
    )..mesList = mesList;
  }
}
