import 'plataforma_mb51_single.dart';

class PlataformaMb51 {
 List<PlataformaMb51Mes> meses = [];
 
}

class PlataformaMb51Mes{
  String mes = '';
  List<PlataformaMb51Single> lista = [];
  PlataformaMb51Mes({required this.mes});

  int totalE4e(String e4e){
    int total = 0;
    for (var item in lista) {
      if(item.material == e4e){
        total += int.parse(item.ctd);
      }
    }
    return total;
  }
}


