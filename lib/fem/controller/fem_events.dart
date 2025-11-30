part of '../../bloc/main_bloc.dart';

class LoadFem extends MainEvent {}


class AddCesta extends MainEvent {
  final String pedido;
  final SingleFEM singleFEM;
  final String year;
  final bool isSingle;
  AddCesta({
    required this.pedido,
    required this.singleFEM,
    required this.year,
    required this.isSingle,
  });
}

class ModFemList extends MainEvent {
  final String year;
  final SingleFEM singleFEM;
  final String field;
  final String value;
  final String? mes;
  final String? q;
  ModFemList({
    required this.year,
    required this.singleFEM,
    required this.field,
    required this.value,
    this.mes,
    this.q,
  });
}

class ModFemDB extends MainEvent {
  final String year;
  final SingleFEM singleFEM;
  ModFemDB({
    required this.year,
    required this.singleFEM,
  });
}


class ModNuevo extends MainEvent {
  final String valor;
  final String campo;
  final String tabla;
  final int? index;
  ModNuevo({
    required this.valor,
    required this.campo,
    required this.tabla,
    this.index,
  });
}

class DeleteCesta extends MainEvent {
  final String id;
  final String pedido;
  final SingleFEM  singleFEM;
  DeleteCesta({
    required this.id,
    required this.pedido,
    required this.singleFEM,
  });
}

class HoldCtd extends MainEvent {
  final SingleFEM singleFEM;
  final String year;
  HoldCtd({
    required this.singleFEM,
    required this.year,
  });
}