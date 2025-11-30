import 'package:fem_app/ficha/ficha_eliminados/model/ficha_eliminados_single_model.dart';
import 'package:fem_app/resources/titulo.dart';

class Eliminados {
  List<EliminadosSingle> cambiosList = [];
  bool isEmpty = false;

  List<ToCelda> titles = [
    ToCelda(flex: 1, valor: "E4e"),
    ToCelda(flex: 4, valor: "Descripción"),
    ToCelda(flex: 2, valor: "Cambio"),
    ToCelda(flex: 2, valor: "Razón"),
    ToCelda(flex: 2, valor: "Persona"),
    ToCelda(flex: 2, valor: "Fecha"),
  ];

  Eliminados();
}
