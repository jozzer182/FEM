import 'dart:convert';
import 'package:flutter/widgets.dart';

class DisponibilidadMesSingle {
  String e4e;
  String descripcion;
  String um;
  int? m01pmc;
  int? m01ora;
  int? m01ce;
  int? m01demanda;
  int? m01oe;
  int? m01stock;
  int? m01oferta;
  int? m01proyectado;
  int? m02pmc;
  int? m02ora;
  int? m02ce;
  int? m02demanda;
  int? m02oe;
  int? m02stock;
  int? m02oferta;
  int? m02proyectado;
  int? m03pmc;
  int? m03ora;
  int? m03ce;
  int? m03demanda;
  int? m03oe;
  int? m03stock;
  int? m03oferta;
  int? m03proyectado;
  int? m04pmc;
  int? m04ora;
  int? m04ce;
  int? m04demanda;
  int? m04oe;
  int? m04stock;
  int? m04oferta;
  int? m04proyectado;
  int? m05pmc;
  int? m05ora;
  int? m05ce;
  int? m05demanda;
  int? m05oe;
  int? m05stock;
  int? m05oferta;
  int? m05proyectado;
  int? m06pmc;
  int? m06ora;
  int? m06ce;
  int? m06demanda;
  int? m06oe;
  int? m06stock;
  int? m06oferta;
  int? m06proyectado;
  int? m07pmc;
  int? m07ora;
  int? m07ce;
  int? m07demanda;
  int? m07oe;
  int? m07stock;
  int? m07oferta;
  int? m07proyectado;
  int? m08pmc;
  int? m08ora;
  int? m08ce;
  int? m08demanda;
  int? m08oe;
  int? m08stock;
  int? m08oferta;
  int? m08proyectado;
  int? m09pmc;
  int? m09ora;
  int? m09ce;
  int? m09demanda;
  int? m09oe;
  int? m09stock;
  int? m09oferta;
  int? m09proyectado;
  int? m10pmc;
  int? m10ora;
  int? m10ce;
  int? m10demanda;
  int? m10oe;
  int? m10stock;
  int? m10oferta;
  int? m10proyectado;
  int? m11pmc;
  int? m11ora;
  int? m11ce;
  int? m11demanda;
  int? m11oe;
  int? m11stock;
  int? m11oferta;
  int? m11proyectado;
  int? m12pmc;
  int? m12ora;
  int? m12ce;
  int? m12demanda;
  int? m12oe;
  int? m12stock;
  int? m12oferta;
  int? m12proyectado;
  DisponibilidadMesSingle({
    required this.e4e,
    required this.descripcion,
    required this.um,
    this.m01pmc,
    this.m01ora,
    this.m01ce,
    this.m01demanda,
    this.m01oe,
    this.m01stock,
    this.m01oferta,
    this.m01proyectado,
    this.m02pmc,
    this.m02ora,
    this.m02ce,
    this.m02demanda,
    this.m02oe,
    this.m02stock,
    this.m02oferta,
    this.m02proyectado,
    this.m03pmc,
    this.m03ora,
    this.m03ce,
    this.m03demanda,
    this.m03oe,
    this.m03stock,
    this.m03oferta,
    this.m03proyectado,
    this.m04pmc,
    this.m04ora,
    this.m04ce,
    this.m04demanda,
    this.m04oe,
    this.m04stock,
    this.m04oferta,
    this.m04proyectado,
    this.m05pmc,
    this.m05ora,
    this.m05ce,
    this.m05demanda,
    this.m05oe,
    this.m05stock,
    this.m05oferta,
    this.m05proyectado,
    this.m06pmc,
    this.m06ora,
    this.m06ce,
    this.m06demanda,
    this.m06oe,
    this.m06stock,
    this.m06oferta,
    this.m06proyectado,
    this.m07pmc,
    this.m07ora,
    this.m07ce,
    this.m07demanda,
    this.m07oe,
    this.m07stock,
    this.m07oferta,
    this.m07proyectado,
    this.m08pmc,
    this.m08ora,
    this.m08ce,
    this.m08demanda,
    this.m08oe,
    this.m08stock,
    this.m08oferta,
    this.m08proyectado,
    this.m09pmc,
    this.m09ora,
    this.m09ce,
    this.m09demanda,
    this.m09oe,
    this.m09stock,
    this.m09oferta,
    this.m09proyectado,
    this.m10pmc,
    this.m10ora,
    this.m10ce,
    this.m10demanda,
    this.m10oe,
    this.m10stock,
    this.m10oferta,
    this.m10proyectado,
    this.m11pmc,
    this.m11ora,
    this.m11ce,
    this.m11demanda,
    this.m11oe,
    this.m11stock,
    this.m11oferta,
    this.m11proyectado,
    this.m12pmc,
    this.m12ora,
    this.m12ce,
    this.m12demanda,
    this.m12oe,
    this.m12stock,
    this.m12oferta,
    this.m12proyectado,
  });

  int get totalStock =>
      (m01stock ?? 0) +
      (m02stock ?? 0) +
      (m03stock ?? 0) +
      (m04stock ?? 0) +
      (m05stock ?? 0) +
      (m06stock ?? 0) +
      (m07stock ?? 0) +
      (m08stock ?? 0) +
      (m09stock ?? 0) +
      (m10stock ?? 0) +
      (m11stock ?? 0) +
      (m12stock ?? 0);

  int get totalOe =>
      (m01oe ?? 0) +
      (m02oe ?? 0) +
      (m03oe ?? 0) +
      (m04oe ?? 0) +
      (m05oe ?? 0) +
      (m06oe ?? 0) +
      (m07oe ?? 0) +
      (m08oe ?? 0) +
      (m09oe ?? 0) +
      (m10oe ?? 0) +
      (m11oe ?? 0) +
      (m12oe ?? 0);

  int get totalPmc =>
      (m01pmc ?? 0) +
      (m02pmc ?? 0) +
      (m03pmc ?? 0) +
      (m04pmc ?? 0) +
      (m05pmc ?? 0) +
      (m06pmc ?? 0) +
      (m07pmc ?? 0) +
      (m08pmc ?? 0) +
      (m09pmc ?? 0) +
      (m10pmc ?? 0) +
      (m11pmc ?? 0) +
      (m12pmc ?? 0);

  int get totalOra =>
      (m01ora ?? 0) +
      (m02ora ?? 0) +
      (m03ora ?? 0) +
      (m04ora ?? 0) +
      (m05ora ?? 0) +
      (m06ora ?? 0) +
      (m07ora ?? 0) +
      (m08ora ?? 0) +
      (m09ora ?? 0) +
      (m10ora ?? 0) +
      (m11ora ?? 0) +
      (m12ora ?? 0);

  int get totalCe =>
      (m01ce ?? 0) +
      (m02ce ?? 0) +
      (m03ce ?? 0) +
      (m04ce ?? 0) +
      (m05ce ?? 0) +
      (m06ce ?? 0) +
      (m07ce ?? 0) +
      (m08ce ?? 0) +
      (m09ce ?? 0) +
      (m10ce ?? 0) +
      (m11ce ?? 0) +
      (m12ce ?? 0);

  asignar(String campo, int valor) {
    if (campo == 'm01pmc') m01pmc = valor;
    if (campo == 'm01ora') m01ora = valor;
    if (campo == 'm01ce') m01ce = valor;
    if (campo == 'm01demanda') m01demanda = valor;
    if (campo == 'm01oe') m01oe = valor;
    if (campo == 'm01stock') m01stock = valor;
    if (campo == 'm01oferta') m01oferta = valor;
    if (campo == 'm01proyectado') m01proyectado = valor;
    if (campo == 'm02pmc') m02pmc = valor;
    if (campo == 'm02ora') m02ora = valor;
    if (campo == 'm02ce') m02ce = valor;
    if (campo == 'm02demanda') m02demanda = valor;
    if (campo == 'm02oe') m02oe = valor;
    if (campo == 'm02stock') m02stock = valor;
    if (campo == 'm02oferta') m02oferta = valor;
    if (campo == 'm02proyectado') m02proyectado = valor;
    if (campo == 'm03pmc') m03pmc = valor;
    if (campo == 'm03ora') m03ora = valor;
    if (campo == 'm03ce') m03ce = valor;
    if (campo == 'm03demanda') m03demanda = valor;
    if (campo == 'm03oe') m03oe = valor;
    if (campo == 'm03stock') m03stock = valor;
    if (campo == 'm03oferta') m03oferta = valor;
    if (campo == 'm03proyectado') m03proyectado = valor;
    if (campo == 'm04pmc') m04pmc = valor;
    if (campo == 'm04ora') m04ora = valor;
    if (campo == 'm04ce') m04ce = valor;
    if (campo == 'm04demanda') m04demanda = valor;
    if (campo == 'm04oe') m04oe = valor;
    if (campo == 'm04stock') m04stock = valor;
    if (campo == 'm04oferta') m04oferta = valor;
    if (campo == 'm04proyectado') m04proyectado = valor;
    if (campo == 'm05pmc') m05pmc = valor;
    if (campo == 'm05ora') m05ora = valor;
    if (campo == 'm05ce') m05ce = valor;
    if (campo == 'm05demanda') m05demanda = valor;
    if (campo == 'm05oe') m05oe = valor;
    if (campo == 'm05stock') m05stock = valor;
    if (campo == 'm05oferta') m05oferta = valor;
    if (campo == 'm05proyectado') m05proyectado = valor;
    if (campo == 'm06pmc') m06pmc = valor;
    if (campo == 'm06ora') m06ora = valor;
    if (campo == 'm06ce') m06ce = valor;
    if (campo == 'm06demanda') m06demanda = valor;
    if (campo == 'm06oe') m06oe = valor;
    if (campo == 'm06stock') m06stock = valor;
    if (campo == 'm06oferta') m06oferta = valor;
    if (campo == 'm06proyectado') m06proyectado = valor;
    if (campo == 'm07pmc') m07pmc = valor;
    if (campo == 'm07ora') m07ora = valor;
    if (campo == 'm07ce') m07ce = valor;
    if (campo == 'm07demanda') m07demanda = valor;
    if (campo == 'm07oe') m07oe = valor;
    if (campo == 'm07stock') m07stock = valor;
    if (campo == 'm07oferta') m07oferta = valor;
    if (campo == 'm07proyectado') m07proyectado = valor;
    if (campo == 'm08pmc') m08pmc = valor;
    if (campo == 'm08ora') m08ora = valor;
    if (campo == 'm08ce') m08ce = valor;
    if (campo == 'm08demanda') m08demanda = valor;
    if (campo == 'm08oe') m08oe = valor;
    if (campo == 'm08stock') m08stock = valor;
    if (campo == 'm08oferta') m08oferta = valor;
    if (campo == 'm08proyectado') m08proyectado = valor;
    if (campo == 'm09pmc') m09pmc = valor;
    if (campo == 'm09ora') m09ora = valor;
    if (campo == 'm09ce') m09ce = valor;
    if (campo == 'm09demanda') m09demanda = valor;
    if (campo == 'm09oe') m09oe = valor;
    if (campo == 'm09stock') m09stock = valor;
    if (campo == 'm09oferta') m09oferta = valor;
    if (campo == 'm09proyectado') m09proyectado = valor;
    if (campo == 'm10pmc') m10pmc = valor;
    if (campo == 'm10ora') m10ora = valor;
    if (campo == 'm10ce') m10ce = valor;
    if (campo == 'm10demanda') m10demanda = valor;
    if (campo == 'm10oe') m10oe = valor;
    if (campo == 'm10stock') m10stock = valor;
    if (campo == 'm10oferta') m10oferta = valor;
    if (campo == 'm10proyectado') m10proyectado = valor;
    if (campo == 'm11pmc') m11pmc = valor;
    if (campo == 'm11ora') m11ora = valor;
    if (campo == 'm11ce') m11ce = valor;
    if (campo == 'm11demanda') m11demanda = valor;
    if (campo == 'm11oe') m11oe = valor;
    if (campo == 'm11stock') m11stock = valor;
    if (campo == 'm11oferta') m11oferta = valor;
    if (campo == 'm11proyectado') m11proyectado = valor;
    if (campo == 'm12pmc') m12pmc = valor;
    if (campo == 'm12ora') m12ora = valor;
    if (campo == 'm12ce') m12ce = valor;
    if (campo == 'm12demanda') m12demanda = valor;
    if (campo == 'm12oe') m12oe = valor;
    if (campo == 'm12stock') m12stock = valor;
    if (campo == 'm12oferta') m12oferta = valor;
    if (campo == 'm12proyectado') m12proyectado = valor;
  }

  int get disponibilidadFinal {
    if (m09proyectado == null) {
      return m08proyectado!;
    }
    if (m05proyectado == null) {
      return m04proyectado!;
    }
    return m12proyectado!;
  }

  int campo(int n) {
    if (n == 1) return m01proyectado??0;
    if (n == 2) return m02proyectado??0;
    if (n == 3) return m03proyectado??0;
    if (n == 4) return m04proyectado??0;
    if (n == 5) return m05proyectado??0;
    if (n == 6) return m06proyectado??0;
    if (n == 7) return m07proyectado??0;
    if (n == 8) return m08proyectado??0;
    if (n == 9) return m09proyectado??0;
    if (n == 10) return m10proyectado??0;
    if (n == 11) return m11proyectado??0;
    if (n == 12) return m12proyectado??0;
    return 0;
  }

  bool get roturaStock {
    for (int i = 1; i <= 12; i++) {
      if (campo(i) < 0) return true;
    }
    return false;
  }

  String? get roturaStockMes {
    for (int i = 1; i <= 12; i++) {
      if (campo(i) < 0) return i.toString().padLeft(2, "0");
    }
    return null;
  }

  DisponibilidadMesSingle copyWith({
    String? e4e,
    String? descripcion,
    String? um,
    ValueGetter<int?>? m01pmc,
    ValueGetter<int?>? m01ora,
    ValueGetter<int?>? m01ce,
    ValueGetter<int?>? m01demanda,
    ValueGetter<int?>? m01oe,
    ValueGetter<int?>? m01stock,
    ValueGetter<int?>? m01oferta,
    ValueGetter<int?>? m01proyectado,
    ValueGetter<int?>? m02pmc,
    ValueGetter<int?>? m02ora,
    ValueGetter<int?>? m02ce,
    ValueGetter<int?>? m02demanda,
    ValueGetter<int?>? m02oe,
    ValueGetter<int?>? m02stock,
    ValueGetter<int?>? m02oferta,
    ValueGetter<int?>? m02proyectado,
    ValueGetter<int?>? m03pmc,
    ValueGetter<int?>? m03ora,
    ValueGetter<int?>? m03ce,
    ValueGetter<int?>? m03demanda,
    ValueGetter<int?>? m03oe,
    ValueGetter<int?>? m03stock,
    ValueGetter<int?>? m03oferta,
    ValueGetter<int?>? m03proyectado,
    ValueGetter<int?>? m04pmc,
    ValueGetter<int?>? m04ora,
    ValueGetter<int?>? m04ce,
    ValueGetter<int?>? m04demanda,
    ValueGetter<int?>? m04oe,
    ValueGetter<int?>? m04stock,
    ValueGetter<int?>? m04oferta,
    ValueGetter<int?>? m04proyectado,
    ValueGetter<int?>? m05pmc,
    ValueGetter<int?>? m05ora,
    ValueGetter<int?>? m05ce,
    ValueGetter<int?>? m05demanda,
    ValueGetter<int?>? m05oe,
    ValueGetter<int?>? m05stock,
    ValueGetter<int?>? m05oferta,
    ValueGetter<int?>? m05proyectado,
    ValueGetter<int?>? m06pmc,
    ValueGetter<int?>? m06ora,
    ValueGetter<int?>? m06ce,
    ValueGetter<int?>? m06demanda,
    ValueGetter<int?>? m06oe,
    ValueGetter<int?>? m06stock,
    ValueGetter<int?>? m06oferta,
    ValueGetter<int?>? m06proyectado,
    ValueGetter<int?>? m07pmc,
    ValueGetter<int?>? m07ora,
    ValueGetter<int?>? m07ce,
    ValueGetter<int?>? m07demanda,
    ValueGetter<int?>? m07oe,
    ValueGetter<int?>? m07stock,
    ValueGetter<int?>? m07oferta,
    ValueGetter<int?>? m07proyectado,
    ValueGetter<int?>? m08pmc,
    ValueGetter<int?>? m08ora,
    ValueGetter<int?>? m08ce,
    ValueGetter<int?>? m08demanda,
    ValueGetter<int?>? m08oe,
    ValueGetter<int?>? m08stock,
    ValueGetter<int?>? m08oferta,
    ValueGetter<int?>? m08proyectado,
    ValueGetter<int?>? m09pmc,
    ValueGetter<int?>? m09ora,
    ValueGetter<int?>? m09ce,
    ValueGetter<int?>? m09demanda,
    ValueGetter<int?>? m09oe,
    ValueGetter<int?>? m09stock,
    ValueGetter<int?>? m09oferta,
    ValueGetter<int?>? m09proyectado,
    ValueGetter<int?>? m10pmc,
    ValueGetter<int?>? m10ora,
    ValueGetter<int?>? m10ce,
    ValueGetter<int?>? m10demanda,
    ValueGetter<int?>? m10oe,
    ValueGetter<int?>? m10stock,
    ValueGetter<int?>? m10oferta,
    ValueGetter<int?>? m10proyectado,
    ValueGetter<int?>? m11pmc,
    ValueGetter<int?>? m11ora,
    ValueGetter<int?>? m11ce,
    ValueGetter<int?>? m11demanda,
    ValueGetter<int?>? m11oe,
    ValueGetter<int?>? m11stock,
    ValueGetter<int?>? m11oferta,
    ValueGetter<int?>? m11proyectado,
    ValueGetter<int?>? m12pmc,
    ValueGetter<int?>? m12ora,
    ValueGetter<int?>? m12ce,
    ValueGetter<int?>? m12demanda,
    ValueGetter<int?>? m12oe,
    ValueGetter<int?>? m12stock,
    ValueGetter<int?>? m12oferta,
    ValueGetter<int?>? m12proyectado,
  }) {
    return DisponibilidadMesSingle(
      e4e: e4e ?? this.e4e,
      descripcion: descripcion ?? this.descripcion,
      um: um ?? this.um,
      m01pmc: m01pmc?.call() ?? this.m01pmc,
      m01ora: m01ora?.call() ?? this.m01ora,
      m01ce: m01ce?.call() ?? this.m01ce,
      m01demanda: m01demanda?.call() ?? this.m01demanda,
      m01oe: m01oe?.call() ?? this.m01oe,
      m01stock: m01stock?.call() ?? this.m01stock,
      m01oferta: m01oferta?.call() ?? this.m01oferta,
      m01proyectado: m01proyectado?.call() ?? this.m01proyectado,
      m02pmc: m02pmc?.call() ?? this.m02pmc,
      m02ora: m02ora?.call() ?? this.m02ora,
      m02ce: m02ce?.call() ?? this.m02ce,
      m02demanda: m02demanda?.call() ?? this.m02demanda,
      m02oe: m02oe?.call() ?? this.m02oe,
      m02stock: m02stock?.call() ?? this.m02stock,
      m02oferta: m02oferta?.call() ?? this.m02oferta,
      m02proyectado: m02proyectado?.call() ?? this.m02proyectado,
      m03pmc: m03pmc?.call() ?? this.m03pmc,
      m03ora: m03ora?.call() ?? this.m03ora,
      m03ce: m03ce?.call() ?? this.m03ce,
      m03demanda: m03demanda?.call() ?? this.m03demanda,
      m03oe: m03oe?.call() ?? this.m03oe,
      m03stock: m03stock?.call() ?? this.m03stock,
      m03oferta: m03oferta?.call() ?? this.m03oferta,
      m03proyectado: m03proyectado?.call() ?? this.m03proyectado,
      m04pmc: m04pmc?.call() ?? this.m04pmc,
      m04ora: m04ora?.call() ?? this.m04ora,
      m04ce: m04ce?.call() ?? this.m04ce,
      m04demanda: m04demanda?.call() ?? this.m04demanda,
      m04oe: m04oe?.call() ?? this.m04oe,
      m04stock: m04stock?.call() ?? this.m04stock,
      m04oferta: m04oferta?.call() ?? this.m04oferta,
      m04proyectado: m04proyectado?.call() ?? this.m04proyectado,
      m05pmc: m05pmc?.call() ?? this.m05pmc,
      m05ora: m05ora?.call() ?? this.m05ora,
      m05ce: m05ce?.call() ?? this.m05ce,
      m05demanda: m05demanda?.call() ?? this.m05demanda,
      m05oe: m05oe?.call() ?? this.m05oe,
      m05stock: m05stock?.call() ?? this.m05stock,
      m05oferta: m05oferta?.call() ?? this.m05oferta,
      m05proyectado: m05proyectado?.call() ?? this.m05proyectado,
      m06pmc: m06pmc?.call() ?? this.m06pmc,
      m06ora: m06ora?.call() ?? this.m06ora,
      m06ce: m06ce?.call() ?? this.m06ce,
      m06demanda: m06demanda?.call() ?? this.m06demanda,
      m06oe: m06oe?.call() ?? this.m06oe,
      m06stock: m06stock?.call() ?? this.m06stock,
      m06oferta: m06oferta?.call() ?? this.m06oferta,
      m06proyectado: m06proyectado?.call() ?? this.m06proyectado,
      m07pmc: m07pmc?.call() ?? this.m07pmc,
      m07ora: m07ora?.call() ?? this.m07ora,
      m07ce: m07ce?.call() ?? this.m07ce,
      m07demanda: m07demanda?.call() ?? this.m07demanda,
      m07oe: m07oe?.call() ?? this.m07oe,
      m07stock: m07stock?.call() ?? this.m07stock,
      m07oferta: m07oferta?.call() ?? this.m07oferta,
      m07proyectado: m07proyectado?.call() ?? this.m07proyectado,
      m08pmc: m08pmc?.call() ?? this.m08pmc,
      m08ora: m08ora?.call() ?? this.m08ora,
      m08ce: m08ce?.call() ?? this.m08ce,
      m08demanda: m08demanda?.call() ?? this.m08demanda,
      m08oe: m08oe?.call() ?? this.m08oe,
      m08stock: m08stock?.call() ?? this.m08stock,
      m08oferta: m08oferta?.call() ?? this.m08oferta,
      m08proyectado: m08proyectado?.call() ?? this.m08proyectado,
      m09pmc: m09pmc?.call() ?? this.m09pmc,
      m09ora: m09ora?.call() ?? this.m09ora,
      m09ce: m09ce?.call() ?? this.m09ce,
      m09demanda: m09demanda?.call() ?? this.m09demanda,
      m09oe: m09oe?.call() ?? this.m09oe,
      m09stock: m09stock?.call() ?? this.m09stock,
      m09oferta: m09oferta?.call() ?? this.m09oferta,
      m09proyectado: m09proyectado?.call() ?? this.m09proyectado,
      m10pmc: m10pmc?.call() ?? this.m10pmc,
      m10ora: m10ora?.call() ?? this.m10ora,
      m10ce: m10ce?.call() ?? this.m10ce,
      m10demanda: m10demanda?.call() ?? this.m10demanda,
      m10oe: m10oe?.call() ?? this.m10oe,
      m10stock: m10stock?.call() ?? this.m10stock,
      m10oferta: m10oferta?.call() ?? this.m10oferta,
      m10proyectado: m10proyectado?.call() ?? this.m10proyectado,
      m11pmc: m11pmc?.call() ?? this.m11pmc,
      m11ora: m11ora?.call() ?? this.m11ora,
      m11ce: m11ce?.call() ?? this.m11ce,
      m11demanda: m11demanda?.call() ?? this.m11demanda,
      m11oe: m11oe?.call() ?? this.m11oe,
      m11stock: m11stock?.call() ?? this.m11stock,
      m11oferta: m11oferta?.call() ?? this.m11oferta,
      m11proyectado: m11proyectado?.call() ?? this.m11proyectado,
      m12pmc: m12pmc?.call() ?? this.m12pmc,
      m12ora: m12ora?.call() ?? this.m12ora,
      m12ce: m12ce?.call() ?? this.m12ce,
      m12demanda: m12demanda?.call() ?? this.m12demanda,
      m12oe: m12oe?.call() ?? this.m12oe,
      m12stock: m12stock?.call() ?? this.m12stock,
      m12oferta: m12oferta?.call() ?? this.m12oferta,
      m12proyectado: m12proyectado?.call() ?? this.m12proyectado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'e4e': e4e,
      'descripcion': descripcion,
      'um': um,
      'm01pmc': m01pmc,
      'm01ora': m01ora,
      'm01ce': m01ce,
      'm01demanda': m01demanda,
      'm01oe': m01oe,
      'm01stock': m01stock,
      'm01oferta': m01oferta,
      'm01proyectado': m01proyectado,
      'm02pmc': m02pmc,
      'm02ora': m02ora,
      'm02ce': m02ce,
      'm02demanda': m02demanda,
      'm02oe': m02oe,
      'm02stock': m02stock,
      'm02oferta': m02oferta,
      'm02proyectado': m02proyectado,
      'm03pmc': m03pmc,
      'm03ora': m03ora,
      'm03ce': m03ce,
      'm03demanda': m03demanda,
      'm03oe': m03oe,
      'm03stock': m03stock,
      'm03oferta': m03oferta,
      'm03proyectado': m03proyectado,
      'm04pmc': m04pmc,
      'm04ora': m04ora,
      'm04ce': m04ce,
      'm04demanda': m04demanda,
      'm04oe': m04oe,
      'm04stock': m04stock,
      'm04oferta': m04oferta,
      'm04proyectado': m04proyectado,
      'm05pmc': m05pmc,
      'm05ora': m05ora,
      'm05ce': m05ce,
      'm05demanda': m05demanda,
      'm05oe': m05oe,
      'm05stock': m05stock,
      'm05oferta': m05oferta,
      'm05proyectado': m05proyectado,
      'm06pmc': m06pmc,
      'm06ora': m06ora,
      'm06ce': m06ce,
      'm06demanda': m06demanda,
      'm06oe': m06oe,
      'm06stock': m06stock,
      'm06oferta': m06oferta,
      'm06proyectado': m06proyectado,
      'm07pmc': m07pmc,
      'm07ora': m07ora,
      'm07ce': m07ce,
      'm07demanda': m07demanda,
      'm07oe': m07oe,
      'm07stock': m07stock,
      'm07oferta': m07oferta,
      'm07proyectado': m07proyectado,
      'm08pmc': m08pmc,
      'm08ora': m08ora,
      'm08ce': m08ce,
      'm08demanda': m08demanda,
      'm08oe': m08oe,
      'm08stock': m08stock,
      'm08oferta': m08oferta,
      'm08proyectado': m08proyectado,
      'm09pmc': m09pmc,
      'm09ora': m09ora,
      'm09ce': m09ce,
      'm09demanda': m09demanda,
      'm09oe': m09oe,
      'm09stock': m09stock,
      'm09oferta': m09oferta,
      'm09proyectado': m09proyectado,
      'm10pmc': m10pmc,
      'm10ora': m10ora,
      'm10ce': m10ce,
      'm10demanda': m10demanda,
      'm10oe': m10oe,
      'm10stock': m10stock,
      'm10oferta': m10oferta,
      'm10proyectado': m10proyectado,
      'm11pmc': m11pmc,
      'm11ora': m11ora,
      'm11ce': m11ce,
      'm11demanda': m11demanda,
      'm11oe': m11oe,
      'm11stock': m11stock,
      'm11oferta': m11oferta,
      'm11proyectado': m11proyectado,
      'm12pmc': m12pmc,
      'm12ora': m12ora,
      'm12ce': m12ce,
      'm12demanda': m12demanda,
      'm12oe': m12oe,
      'm12stock': m12stock,
      'm12oferta': m12oferta,
      'm12proyectado': m12proyectado,
    };
  }

  factory DisponibilidadMesSingle.fromMap(Map<String, dynamic> map) {
    return DisponibilidadMesSingle(
      e4e: map['e4e'] ?? '',
      descripcion: map['descripcion'] ?? '',
      um: map['um'] ?? '',
      m01pmc: map['m01pmc']?.toInt(),
      m01ora: map['m01ora']?.toInt(),
      m01ce: map['m01ce']?.toInt(),
      m01demanda: map['m01demanda']?.toInt(),
      m01oe: map['m01oe']?.toInt(),
      m01stock: map['m01stock']?.toInt(),
      m01oferta: map['m01oferta']?.toInt(),
      m01proyectado: map['m01proyectado']?.toInt(),
      m02pmc: map['m02pmc']?.toInt(),
      m02ora: map['m02ora']?.toInt(),
      m02ce: map['m02ce']?.toInt(),
      m02demanda: map['m02demanda']?.toInt(),
      m02oe: map['m02oe']?.toInt(),
      m02stock: map['m02stock']?.toInt(),
      m02oferta: map['m02oferta']?.toInt(),
      m02proyectado: map['m02proyectado']?.toInt(),
      m03pmc: map['m03pmc']?.toInt(),
      m03ora: map['m03ora']?.toInt(),
      m03ce: map['m03ce']?.toInt(),
      m03demanda: map['m03demanda']?.toInt(),
      m03oe: map['m03oe']?.toInt(),
      m03stock: map['m03stock']?.toInt(),
      m03oferta: map['m03oferta']?.toInt(),
      m03proyectado: map['m03proyectado']?.toInt(),
      m04pmc: map['m04pmc']?.toInt(),
      m04ora: map['m04ora']?.toInt(),
      m04ce: map['m04ce']?.toInt(),
      m04demanda: map['m04demanda']?.toInt(),
      m04oe: map['m04oe']?.toInt(),
      m04stock: map['m04stock']?.toInt(),
      m04oferta: map['m04oferta']?.toInt(),
      m04proyectado: map['m04proyectado']?.toInt(),
      m05pmc: map['m05pmc']?.toInt(),
      m05ora: map['m05ora']?.toInt(),
      m05ce: map['m05ce']?.toInt(),
      m05demanda: map['m05demanda']?.toInt(),
      m05oe: map['m05oe']?.toInt(),
      m05stock: map['m05stock']?.toInt(),
      m05oferta: map['m05oferta']?.toInt(),
      m05proyectado: map['m05proyectado']?.toInt(),
      m06pmc: map['m06pmc']?.toInt(),
      m06ora: map['m06ora']?.toInt(),
      m06ce: map['m06ce']?.toInt(),
      m06demanda: map['m06demanda']?.toInt(),
      m06oe: map['m06oe']?.toInt(),
      m06stock: map['m06stock']?.toInt(),
      m06oferta: map['m06oferta']?.toInt(),
      m06proyectado: map['m06proyectado']?.toInt(),
      m07pmc: map['m07pmc']?.toInt(),
      m07ora: map['m07ora']?.toInt(),
      m07ce: map['m07ce']?.toInt(),
      m07demanda: map['m07demanda']?.toInt(),
      m07oe: map['m07oe']?.toInt(),
      m07stock: map['m07stock']?.toInt(),
      m07oferta: map['m07oferta']?.toInt(),
      m07proyectado: map['m07proyectado']?.toInt(),
      m08pmc: map['m08pmc']?.toInt(),
      m08ora: map['m08ora']?.toInt(),
      m08ce: map['m08ce']?.toInt(),
      m08demanda: map['m08demanda']?.toInt(),
      m08oe: map['m08oe']?.toInt(),
      m08stock: map['m08stock']?.toInt(),
      m08oferta: map['m08oferta']?.toInt(),
      m08proyectado: map['m08proyectado']?.toInt(),
      m09pmc: map['m09pmc']?.toInt(),
      m09ora: map['m09ora']?.toInt(),
      m09ce: map['m09ce']?.toInt(),
      m09demanda: map['m09demanda']?.toInt(),
      m09oe: map['m09oe']?.toInt(),
      m09stock: map['m09stock']?.toInt(),
      m09oferta: map['m09oferta']?.toInt(),
      m09proyectado: map['m09proyectado']?.toInt(),
      m10pmc: map['m10pmc']?.toInt(),
      m10ora: map['m10ora']?.toInt(),
      m10ce: map['m10ce']?.toInt(),
      m10demanda: map['m10demanda']?.toInt(),
      m10oe: map['m10oe']?.toInt(),
      m10stock: map['m10stock']?.toInt(),
      m10oferta: map['m10oferta']?.toInt(),
      m10proyectado: map['m10proyectado']?.toInt(),
      m11pmc: map['m11pmc']?.toInt(),
      m11ora: map['m11ora']?.toInt(),
      m11ce: map['m11ce']?.toInt(),
      m11demanda: map['m11demanda']?.toInt(),
      m11oe: map['m11oe']?.toInt(),
      m11stock: map['m11stock']?.toInt(),
      m11oferta: map['m11oferta']?.toInt(),
      m11proyectado: map['m11proyectado']?.toInt(),
      m12pmc: map['m12pmc']?.toInt(),
      m12ora: map['m12ora']?.toInt(),
      m12ce: map['m12ce']?.toInt(),
      m12demanda: map['m12demanda']?.toInt(),
      m12oe: map['m12oe']?.toInt(),
      m12stock: map['m12stock']?.toInt(),
      m12oferta: map['m12oferta']?.toInt(),
      m12proyectado: map['m12proyectado']?.toInt(),
    );
  }

  factory DisponibilidadMesSingle.fromInit() {
    return DisponibilidadMesSingle(
      e4e: '',
      descripcion: '',
      um: '',
      m01pmc: 0,
      m01ora: 0,
      m01ce: 0,
      m01demanda: 0,
      m01oe: 0,
      m01stock: 0,
      m01oferta: 0,
      m01proyectado: 0,
      m02pmc: 0,
      m02ora: 0,
      m02ce: 0,
      m02demanda: 0,
      m02oe: 0,
      m02stock: 0,
      m02oferta: 0,
      m02proyectado: 0,
      m03pmc: 0,
      m03ora: 0,
      m03ce: 0,
      m03demanda: 0,
      m03oe: 0,
      m03stock: 0,
      m03oferta: 0,
      m03proyectado: 0,
      m04pmc: 0,
      m04ora: 0,
      m04ce: 0,
      m04demanda: 0,
      m04oe: 0,
      m04stock: 0,
      m04oferta: 0,
      m04proyectado: 0,
      m05pmc: 0,
      m05ora: 0,
      m05ce: 0,
      m05demanda: 0,
      m05oe: 0,
      m05stock: 0,
      m05oferta: 0,
      m05proyectado: 0,
      m06pmc: 0,
      m06ora: 0,
      m06ce: 0,
      m06demanda: 0,
      m06oe: 0,
      m06stock: 0,
      m06oferta: 0,
      m06proyectado: 0,
      m07pmc: 0,
      m07ora: 0,
      m07ce: 0,
      m07demanda: 0,
      m07oe: 0,
      m07stock: 0,
      m07oferta: 0,
      m07proyectado: 0,
      m08pmc: 0,
      m08ora: 0,
      m08ce: 0,
      m08demanda: 0,
      m08oe: 0,
      m08stock: 0,
      m08oferta: 0,
      m08proyectado: 0,
      m09pmc: 0,
      m09ora: 0,
      m09ce: 0,
      m09demanda: 0,
      m09oe: 0,
      m09stock: 0,
      m09oferta: 0,
      m09proyectado: 0,
      m10pmc: 0,
      m10ora: 0,
      m10ce: 0,
      m10demanda: 0,
      m10oe: 0,
      m10stock: 0,
      m10oferta: 0,
      m10proyectado: 0,
      m11pmc: 0,
      m11ora: 0,
      m11ce: 0,
      m11demanda: 0,
      m11oe: 0,
      m11stock: 0,
      m11oferta: 0,
      m11proyectado: 0,
      m12pmc: 0,
      m12ora: 0,
      m12ce: 0,
      m12demanda: 0,
      m12oe: 0,
      m12stock: 0,
      m12oferta: 0,
      m12proyectado: 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisponibilidadMesSingle.fromJson(String source) =>
      DisponibilidadMesSingle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisponibilidadMEsSingle(e4e: $e4e, descripcion: $descripcion, um: $um, m01pmc: $m01pmc, m01ora: $m01ora, m01ce: $m01ce, m01demanda: $m01demanda, m01oe: $m01oe, m01stock: $m01stock, m01oferta: $m01oferta, m01proyectado: $m01proyectado, m02pmc: $m02pmc, m02ora: $m02ora, m02ce: $m02ce, m02demanda: $m02demanda, m02oe: $m02oe, m02stock: $m02stock, m02oferta: $m02oferta, m02proyectado: $m02proyectado, m03pmc: $m03pmc, m03ora: $m03ora, m03ce: $m03ce, m03demanda: $m03demanda, m03oe: $m03oe, m03stock: $m03stock, m03oferta: $m03oferta, m03proyectado: $m03proyectado, m04pmc: $m04pmc, m04ora: $m04ora, m04ce: $m04ce, m04demanda: $m04demanda, m04oe: $m04oe, m04stock: $m04stock, m04oferta: $m04oferta, m04proyectado: $m04proyectado, m05pmc: $m05pmc, m05ora: $m05ora, m05ce: $m05ce, m05demanda: $m05demanda, m05oe: $m05oe, m05stock: $m05stock, m05oferta: $m05oferta, m05proyectado: $m05proyectado, m06pmc: $m06pmc, m06ora: $m06ora, m06ce: $m06ce, m06demanda: $m06demanda, m06oe: $m06oe, m06stock: $m06stock, m06oferta: $m06oferta, m06proyectado: $m06proyectado, m07pmc: $m07pmc, m07ora: $m07ora, m07ce: $m07ce, m07demanda: $m07demanda, m07oe: $m07oe, m07stock: $m07stock, m07oferta: $m07oferta, m07proyectado: $m07proyectado, m08pmc: $m08pmc, m08ora: $m08ora, m08ce: $m08ce, m08demanda: $m08demanda, m08oe: $m08oe, m08stock: $m08stock, m08oferta: $m08oferta, m08proyectado: $m08proyectado, m09pmc: $m09pmc, m09ora: $m09ora, m09ce: $m09ce, m09demanda: $m09demanda, m09oe: $m09oe, m09stock: $m09stock, m09oferta: $m09oferta, m09proyectado: $m09proyectado, m10pmc: $m10pmc, m10ora: $m10ora, m10ce: $m10ce, m10demanda: $m10demanda, m10oe: $m10oe, m10stock: $m10stock, m10oferta: $m10oferta, m10proyectado: $m10proyectado, m11pmc: $m11pmc, m11ora: $m11ora, m11ce: $m11ce, m11demanda: $m11demanda, m11oe: $m11oe, m11stock: $m11stock, m11oferta: $m11oferta, m11proyectado: $m11proyectado, m12pmc: $m12pmc, m12ora: $m12ora, m12ce: $m12ce, m12demanda: $m12demanda, m12oe: $m12oe, m12stock: $m12stock, m12oferta: $m12oferta, m12proyectado: $m12proyectado)';
  }
  List<String> toList(){
    return [
      e4e,
      descripcion,
      um,
      m01pmc.toString(),
      m01ora.toString(),
      m01ce.toString(),
      m01demanda.toString(),
      m01oe.toString(),
      m01stock.toString(),
      m01oferta.toString(),
      m01proyectado.toString(),
      m02pmc.toString(),
      m02ora.toString(),
      m02ce.toString(),
      m02demanda.toString(),
      m02oe.toString(),
      m02stock.toString(),
      m02oferta.toString(),
      m02proyectado.toString(),
      m03pmc.toString(),
      m03ora.toString(),
      m03ce.toString(),
      m03demanda.toString(),
      m03oe.toString(),
      m03stock.toString(),
      m03oferta.toString(),
      m03proyectado.toString(),
      m04pmc.toString(),
      m04ora.toString(),
      m04ce.toString(),
      m04demanda.toString(),
      m04oe.toString(),
      m04stock.toString(),
      m04oferta.toString(),
      m04proyectado.toString(),
      m05pmc.toString(),
      m05ora.toString(),
      m05ce.toString(),
      m05demanda.toString(),
      m05oe.toString(),
      m05stock.toString(),
      m05oferta.toString(),
      m05proyectado.toString(),
      m06pmc.toString(),
      m06ora.toString(),
      m06ce.toString(),
      m06demanda.toString(),
      m06oe.toString(),
      m06stock.toString(),
      m06oferta.toString(),
      m06proyectado.toString(),
      m07pmc.toString(),
      m07ora.toString(),
      m07ce.toString(),
      m07demanda.toString(),
      m07oe.toString(),
      m07stock.toString(),
      m07oferta.toString(),
      m07proyectado.toString(),
      m08pmc.toString(),
      m08ora.toString(),
      m08ce.toString(),
      m08demanda.toString(),
      m08oe.toString(),
      m08stock.toString(),
      m08oferta.toString(),
      m08proyectado.toString(),
      m09pmc.toString(),
      m09ora.toString(),
      m09ce.toString(),
      m09demanda.toString(),
      m09oe.toString(),
      m09stock.toString(),
      m09oferta.toString(),
      m09proyectado.toString(),
      m10pmc.toString(),
      m10ora.toString(),
      m10ce.toString(),
      m10demanda.toString(),
      m10oe.toString(),
      m10stock.toString(),
      m10oferta.toString(),
      m10proyectado.toString(),
      m11pmc.toString(),
      m11ora.toString(),
      m11ce.toString(),
      m11demanda.toString(),
      m11oe.toString(),
      m11stock.toString(),
      m11oferta.toString(),
      m11proyectado.toString(),
      m12pmc.toString(),
      m12ora.toString(),
      m12ce.toString(),
      m12demanda.toString(),
      m12oe.toString(),
      m12stock.toString(),
      m12oferta.toString(),
      m12proyectado.toString(),
    ];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DisponibilidadMesSingle &&
        other.e4e == e4e &&
        other.descripcion == descripcion &&
        other.um == um &&
        other.m01pmc == m01pmc &&
        other.m01ora == m01ora &&
        other.m01ce == m01ce &&
        other.m01demanda == m01demanda &&
        other.m01oe == m01oe &&
        other.m01stock == m01stock &&
        other.m01oferta == m01oferta &&
        other.m01proyectado == m01proyectado &&
        other.m02pmc == m02pmc &&
        other.m02ora == m02ora &&
        other.m02ce == m02ce &&
        other.m02demanda == m02demanda &&
        other.m02oe == m02oe &&
        other.m02stock == m02stock &&
        other.m02oferta == m02oferta &&
        other.m02proyectado == m02proyectado &&
        other.m03pmc == m03pmc &&
        other.m03ora == m03ora &&
        other.m03ce == m03ce &&
        other.m03demanda == m03demanda &&
        other.m03oe == m03oe &&
        other.m03stock == m03stock &&
        other.m03oferta == m03oferta &&
        other.m03proyectado == m03proyectado &&
        other.m04pmc == m04pmc &&
        other.m04ora == m04ora &&
        other.m04ce == m04ce &&
        other.m04demanda == m04demanda &&
        other.m04oe == m04oe &&
        other.m04stock == m04stock &&
        other.m04oferta == m04oferta &&
        other.m04proyectado == m04proyectado &&
        other.m05pmc == m05pmc &&
        other.m05ora == m05ora &&
        other.m05ce == m05ce &&
        other.m05demanda == m05demanda &&
        other.m05oe == m05oe &&
        other.m05stock == m05stock &&
        other.m05oferta == m05oferta &&
        other.m05proyectado == m05proyectado &&
        other.m06pmc == m06pmc &&
        other.m06ora == m06ora &&
        other.m06ce == m06ce &&
        other.m06demanda == m06demanda &&
        other.m06oe == m06oe &&
        other.m06stock == m06stock &&
        other.m06oferta == m06oferta &&
        other.m06proyectado == m06proyectado &&
        other.m07pmc == m07pmc &&
        other.m07ora == m07ora &&
        other.m07ce == m07ce &&
        other.m07demanda == m07demanda &&
        other.m07oe == m07oe &&
        other.m07stock == m07stock &&
        other.m07oferta == m07oferta &&
        other.m07proyectado == m07proyectado &&
        other.m08pmc == m08pmc &&
        other.m08ora == m08ora &&
        other.m08ce == m08ce &&
        other.m08demanda == m08demanda &&
        other.m08oe == m08oe &&
        other.m08stock == m08stock &&
        other.m08oferta == m08oferta &&
        other.m08proyectado == m08proyectado &&
        other.m09pmc == m09pmc &&
        other.m09ora == m09ora &&
        other.m09ce == m09ce &&
        other.m09demanda == m09demanda &&
        other.m09oe == m09oe &&
        other.m09stock == m09stock &&
        other.m09oferta == m09oferta &&
        other.m09proyectado == m09proyectado &&
        other.m10pmc == m10pmc &&
        other.m10ora == m10ora &&
        other.m10ce == m10ce &&
        other.m10demanda == m10demanda &&
        other.m10oe == m10oe &&
        other.m10stock == m10stock &&
        other.m10oferta == m10oferta &&
        other.m10proyectado == m10proyectado &&
        other.m11pmc == m11pmc &&
        other.m11ora == m11ora &&
        other.m11ce == m11ce &&
        other.m11demanda == m11demanda &&
        other.m11oe == m11oe &&
        other.m11stock == m11stock &&
        other.m11oferta == m11oferta &&
        other.m11proyectado == m11proyectado &&
        other.m12pmc == m12pmc &&
        other.m12ora == m12ora &&
        other.m12ce == m12ce &&
        other.m12demanda == m12demanda &&
        other.m12oe == m12oe &&
        other.m12stock == m12stock &&
        other.m12oferta == m12oferta &&
        other.m12proyectado == m12proyectado;
  }

  @override
  int get hashCode {
    return e4e.hashCode ^
        descripcion.hashCode ^
        um.hashCode ^
        m01pmc.hashCode ^
        m01ora.hashCode ^
        m01ce.hashCode ^
        m01demanda.hashCode ^
        m01oe.hashCode ^
        m01stock.hashCode ^
        m01oferta.hashCode ^
        m01proyectado.hashCode ^
        m02pmc.hashCode ^
        m02ora.hashCode ^
        m02ce.hashCode ^
        m02demanda.hashCode ^
        m02oe.hashCode ^
        m02stock.hashCode ^
        m02oferta.hashCode ^
        m02proyectado.hashCode ^
        m03pmc.hashCode ^
        m03ora.hashCode ^
        m03ce.hashCode ^
        m03demanda.hashCode ^
        m03oe.hashCode ^
        m03stock.hashCode ^
        m03oferta.hashCode ^
        m03proyectado.hashCode ^
        m04pmc.hashCode ^
        m04ora.hashCode ^
        m04ce.hashCode ^
        m04demanda.hashCode ^
        m04oe.hashCode ^
        m04stock.hashCode ^
        m04oferta.hashCode ^
        m04proyectado.hashCode ^
        m05pmc.hashCode ^
        m05ora.hashCode ^
        m05ce.hashCode ^
        m05demanda.hashCode ^
        m05oe.hashCode ^
        m05stock.hashCode ^
        m05oferta.hashCode ^
        m05proyectado.hashCode ^
        m06pmc.hashCode ^
        m06ora.hashCode ^
        m06ce.hashCode ^
        m06demanda.hashCode ^
        m06oe.hashCode ^
        m06stock.hashCode ^
        m06oferta.hashCode ^
        m06proyectado.hashCode ^
        m07pmc.hashCode ^
        m07ora.hashCode ^
        m07ce.hashCode ^
        m07demanda.hashCode ^
        m07oe.hashCode ^
        m07stock.hashCode ^
        m07oferta.hashCode ^
        m07proyectado.hashCode ^
        m08pmc.hashCode ^
        m08ora.hashCode ^
        m08ce.hashCode ^
        m08demanda.hashCode ^
        m08oe.hashCode ^
        m08stock.hashCode ^
        m08oferta.hashCode ^
        m08proyectado.hashCode ^
        m09pmc.hashCode ^
        m09ora.hashCode ^
        m09ce.hashCode ^
        m09demanda.hashCode ^
        m09oe.hashCode ^
        m09stock.hashCode ^
        m09oferta.hashCode ^
        m09proyectado.hashCode ^
        m10pmc.hashCode ^
        m10ora.hashCode ^
        m10ce.hashCode ^
        m10demanda.hashCode ^
        m10oe.hashCode ^
        m10stock.hashCode ^
        m10oferta.hashCode ^
        m10proyectado.hashCode ^
        m11pmc.hashCode ^
        m11ora.hashCode ^
        m11ce.hashCode ^
        m11demanda.hashCode ^
        m11oe.hashCode ^
        m11stock.hashCode ^
        m11oferta.hashCode ^
        m11proyectado.hashCode ^
        m12pmc.hashCode ^
        m12ora.hashCode ^
        m12ce.hashCode ^
        m12demanda.hashCode ^
        m12oe.hashCode ^
        m12stock.hashCode ^
        m12oferta.hashCode ^
        m12proyectado.hashCode;
  }
}
