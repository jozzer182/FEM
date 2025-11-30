import 'package:fem_app/ficha/ficha_solicitados/model/ficha_solicitados_single_model.dart';

import '../../../resources/titulo.dart';

class Solicitados {
  List<SolicitadoSingle> solicitadosList = [];
  bool isEmpty = false;

  List<ToCelda> titles = [
    ToCelda(flex: 1, valor: "E4e"),
    ToCelda(flex: 4, valor: "Descripción"),
    ToCelda(flex: 2, valor: "Cambio"),
    ToCelda(flex: 2, valor: "Razón"),
    ToCelda(flex: 2, valor: "Persona"),
    ToCelda(flex: 2, valor: "Fecha"),
  ];

  Solicitados();
}