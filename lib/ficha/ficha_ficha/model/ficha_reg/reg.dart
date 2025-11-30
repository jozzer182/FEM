import 'dart:convert';

import 'package:fem_app/ficha/ficha_ficha/model/ficha_reg/reg_log.dart';
import 'package:flutter/material.dart';

import '../../../../fem/model/fem_model_single_fem.dart';
import 'agendado/reg_agendado.dart';
import 'planificado/reg_planificado.dart';
import 'reg_disponible.dart';
import 'reg_enum.dart';
import 'reg_errores.dart';
import 'reg_oficial.dart';
import 'reg_riesgo.dart';
import 'reg_version.dart';

class FichaReg {
  String item;
  String year;
  String id;
  String estado;
  String estdespacho;
  String tipo;
  String fechainicial;
  String fechacambio;
  String fechasolicitud;
  String unidad;
  String codigo;
  String proyecto;
  String circuito;
  String pm;
  String solicitante;
  String pdi;
  String wbe;
  String proyectowbe;
  String comentario1;
  String comentario2;
  String e4e;
  String descripcion;
  String um;
  String m01q1;
  String m01q2;
  String m01qx;
  String m02q1;
  String m02q2;
  String m02qx;
  String m03q1;
  String m03q2;
  String m03qx;
  String m04q1;
  String m04q2;
  String m04qx;
  String m05q1;
  String m05q2;
  String m05qx;
  String m06q1;
  String m06q2;
  String m06qx;
  String m07q1;
  String m07q2;
  String m07qx;
  String m08q1;
  String m08q2;
  String m08qx;
  String m09q1;
  String m09q2;
  String m09qx;
  String m10q1;
  String m10q2;
  String m10qx;
  String m11q1;
  String m11q2;
  String m11qx;
  String m12q1;
  String m12q2;
  String m12qx;
  bool esControlado = false;
  String idSolpe = "";

  late FichaRegAgendado agendado;

  FichaRegDisponible disponible = FichaRegDisponible();

  late FichaRegErrores error;

  FichaRegOficial oficial = FichaRegOficial();

  late FichaRegPlanificado planificado;

  FichaRegRiesgo riesgo = FichaRegRiesgo();

  FichaRegVersion version = FichaRegVersion();

  late FichaRegLog log;

  FichaReg({
    this.item = '',
    this.year = '',
    required this.id,
    required this.estado,
    required this.estdespacho,
    required this.tipo,
    required this.fechainicial,
    required this.fechacambio,
    required this.fechasolicitud,
    required this.unidad,
    required this.codigo,
    required this.proyecto,
    required this.circuito,
    required this.pm,
    required this.solicitante,
    required this.pdi,
    required this.wbe,
    required this.proyectowbe,
    required this.comentario1,
    required this.comentario2,
    required this.e4e,
    required this.descripcion,
    required this.um,
    required this.m01q1,
    required this.m01q2,
    required this.m01qx,
    required this.m02q1,
    required this.m02q2,
    required this.m02qx,
    required this.m03q1,
    required this.m03q2,
    required this.m03qx,
    required this.m04q1,
    required this.m04q2,
    required this.m04qx,
    required this.m05q1,
    required this.m05q2,
    required this.m05qx,
    required this.m06q1,
    required this.m06q2,
    required this.m06qx,
    required this.m07q1,
    required this.m07q2,
    required this.m07qx,
    required this.m08q1,
    required this.m08q2,
    required this.m08qx,
    required this.m09q1,
    required this.m09q2,
    required this.m09qx,
    required this.m10q1,
    required this.m10q2,
    required this.m10qx,
    required this.m11q1,
    required this.m11q2,
    required this.m11qx,
    required this.m12q1,
    required this.m12q2,
    required this.m12qx,
  }) {
    agendado = FichaRegAgendado(this);
    planificado = FichaRegPlanificado(this);
    error = FichaRegErrores(this);
    log = FichaRegLog(this);
  }

  List<String> toList() {
    return [
      id,
      estado,
      estdespacho,
      tipo,
      fechainicial,
      fechacambio,
      fechasolicitud,
      unidad,
      codigo,
      proyecto,
      circuito,
      pm,
      solicitante,
      pdi,
      wbe,
      proyectowbe,
      comentario1,
      comentario2,
      e4e,
      descripcion,
      um,
      m01q1,
      m01q2,
      m01qx,
      m02q1,
      m02q2,
      m02qx,
      m03q1,
      m03q2,
      m03qx,
      m04q1,
      m04q2,
      m04qx,
      m05q1,
      m05q2,
      m05qx,
      m06q1,
      m06q2,
      m06qx,
      m07q1,
      m07q2,
      m07qx,
      m08q1,
      m08q2,
      m08qx,
      m09q1,
      m09q2,
      m09qx,
      m10q1,
      m10q2,
      m10qx,
      m11q1,
      m11q2,
      m11qx,
      m12q1,
      m12q2,
      m12qx,
    ];
  }

  FichaReg copyWith({
    String? item,
    String? year,
    String? id,
    String? estado,
    String? estdespacho,
    String? tipo,
    String? fechainicial,
    String? fechacambio,
    String? fechasolicitud,
    String? unidad,
    String? codigo,
    String? proyecto,
    String? circuito,
    String? pm,
    String? solicitante,
    String? pdi,
    String? wbe,
    String? proyectowbe,
    String? comentario1,
    String? comentario2,
    String? e4e,
    String? descripcion,
    String? um,
    String? m01q1,
    String? m01q2,
    String? m01qx,
    String? m02q1,
    String? m02q2,
    String? m02qx,
    String? m03q1,
    String? m03q2,
    String? m03qx,
    String? m04q1,
    String? m04q2,
    String? m04qx,
    String? m05q1,
    String? m05q2,
    String? m05qx,
    String? m06q1,
    String? m06q2,
    String? m06qx,
    String? m07q1,
    String? m07q2,
    String? m07qx,
    String? m08q1,
    String? m08q2,
    String? m08qx,
    String? m09q1,
    String? m09q2,
    String? m09qx,
    String? m10q1,
    String? m10q2,
    String? m10qx,
    String? m11q1,
    String? m11q2,
    String? m11qx,
    String? m12q1,
    String? m12q2,
    String? m12qx,
    ValueGetter<Color?>? circuitoColor,
    ValueGetter<Color?>? wbeColor,
    ValueGetter<Color?>? wbeColorFill,
    ValueGetter<Color?>? e4eColor,
    ValueGetter<Color?>? pdiColor,
    ValueGetter<Color?>? comentarioColor,
  }) {
    return FichaReg(
      item: item ?? this.item,
      year: year ?? this.year,
      id: id ?? this.id,
      estado: estado ?? this.estado,
      estdespacho: estdespacho ?? this.estdespacho,
      tipo: tipo ?? this.tipo,
      fechainicial: fechainicial ?? this.fechainicial,
      fechacambio: fechacambio ?? this.fechacambio,
      fechasolicitud: fechasolicitud ?? this.fechasolicitud,
      unidad: unidad ?? this.unidad,
      codigo: codigo ?? this.codigo,
      proyecto: proyecto ?? this.proyecto,
      circuito: circuito ?? this.circuito,
      pm: pm ?? this.pm,
      solicitante: solicitante ?? this.solicitante,
      pdi: pdi ?? this.pdi,
      wbe: wbe ?? this.wbe,
      proyectowbe: proyectowbe ?? this.proyectowbe,
      comentario1: comentario1 ?? this.comentario1,
      comentario2: comentario2 ?? this.comentario2,
      e4e: e4e ?? this.e4e,
      descripcion: descripcion ?? this.descripcion,
      um: um ?? this.um,
      m01q1: m01q1 ?? this.m01q1,
      m01q2: m01q2 ?? this.m01q2,
      m01qx: m01qx ?? this.m01qx,
      m02q1: m02q1 ?? this.m02q1,
      m02q2: m02q2 ?? this.m02q2,
      m02qx: m02qx ?? this.m02qx,
      m03q1: m03q1 ?? this.m03q1,
      m03q2: m03q2 ?? this.m03q2,
      m03qx: m03qx ?? this.m03qx,
      m04q1: m04q1 ?? this.m04q1,
      m04q2: m04q2 ?? this.m04q2,
      m04qx: m04qx ?? this.m04qx,
      m05q1: m05q1 ?? this.m05q1,
      m05q2: m05q2 ?? this.m05q2,
      m05qx: m05qx ?? this.m05qx,
      m06q1: m06q1 ?? this.m06q1,
      m06q2: m06q2 ?? this.m06q2,
      m06qx: m06qx ?? this.m06qx,
      m07q1: m07q1 ?? this.m07q1,
      m07q2: m07q2 ?? this.m07q2,
      m07qx: m07qx ?? this.m07qx,
      m08q1: m08q1 ?? this.m08q1,
      m08q2: m08q2 ?? this.m08q2,
      m08qx: m08qx ?? this.m08qx,
      m09q1: m09q1 ?? this.m09q1,
      m09q2: m09q2 ?? this.m09q2,
      m09qx: m09qx ?? this.m09qx,
      m10q1: m10q1 ?? this.m10q1,
      m10q2: m10q2 ?? this.m10q2,
      m10qx: m10qx ?? this.m10qx,
      m11q1: m11q1 ?? this.m11q1,
      m11q2: m11q2 ?? this.m11q2,
      m11qx: m11qx ?? this.m11qx,
      m12q1: m12q1 ?? this.m12q1,
      m12q2: m12q2 ?? this.m12q2,
      m12qx: m12qx ?? this.m12qx,
    )..idSolpe = idSolpe;
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'year': year,
      'id': id,
      'estado': estado,
      'estdespacho': estdespacho,
      'tipo': tipo,
      'fechainicial': fechainicial,
      'fechacambio': fechacambio,
      'fechasolicitud': fechasolicitud,
      'unidad': unidad,
      'codigo': codigo,
      'proyecto': proyecto,
      'circuito': circuito,
      'pm': pm,
      'solicitante': solicitante,
      'pdi': pdi,
      'wbe': wbe,
      'proyectowbe': proyectowbe,
      'comentario1': comentario1,
      'comentario2': comentario2,
      'e4e': e4e,
      'descripcion': descripcion,
      'um': um,
      'm01q1': m01q1,
      'm01q2': m01q2,
      'm01qx': m01qx,
      'm02q1': m02q1,
      'm02q2': m02q2,
      'm02qx': m02qx,
      'm03q1': m03q1,
      'm03q2': m03q2,
      'm03qx': m03qx,
      'm04q1': m04q1,
      'm04q2': m04q2,
      'm04qx': m04qx,
      'm05q1': m05q1,
      'm05q2': m05q2,
      'm05qx': m05qx,
      'm06q1': m06q1,
      'm06q2': m06q2,
      'm06qx': m06qx,
      'm07q1': m07q1,
      'm07q2': m07q2,
      'm07qx': m07qx,
      'm08q1': m08q1,
      'm08q2': m08q2,
      'm08qx': m08qx,
      'm09q1': m09q1,
      'm09q2': m09q2,
      'm09qx': m09qx,
      'm10q1': m10q1,
      'm10q2': m10q2,
      'm10qx': m10qx,
      'm11q1': m11q1,
      'm11q2': m11q2,
      'm11qx': m11qx,
      'm12q1': m12q1,
      'm12q2': m12q2,
      'm12qx': m12qx,
    };
  }

  factory FichaReg.fromInit(int n, String miniyear) {
    var fichaReg = FichaReg(
      item: n.toString().padLeft(2, '0'),
      year: '',
      id: '',
      estado: 'nuevo',
      estdespacho:
          '[{"01|$miniyear-1":"0","01|$miniyear-2":"0","02|$miniyear-1":"0","02|$miniyear-2":"0","03|$miniyear-1":"0","03|$miniyear-2":"0","04|$miniyear-1":"0","04|$miniyear-2":"0","05|$miniyear-1":"0","05|$miniyear-2":"0","06|$miniyear-1":"0","06|$miniyear-2":"0","07|$miniyear-1":"0","07|$miniyear-2":"0","08|$miniyear-1":"0","08|$miniyear-2":"0","09|$miniyear-1":"0","09|$miniyear-2":"0","10|$miniyear-1":"0","10|$miniyear-2":"0","11|$miniyear-1":"0","11|$miniyear-2":"0","12|$miniyear-1":"0","12|$miniyear-2":"0"}]',
      tipo: '',
      fechainicial: '',
      fechacambio: '',
      fechasolicitud: '',
      unidad: '',
      codigo: '',
      proyecto: '',
      circuito: '',
      pm: '',
      solicitante: '',
      pdi: '',
      wbe: '',
      proyectowbe: '',
      comentario1: '',
      comentario2: '',
      e4e: '',
      descripcion: '',
      um: '',
      m01q1: '',
      m01q2: '',
      m01qx: '',
      m02q1: '',
      m02q2: '',
      m02qx: '',
      m03q1: '',
      m03q2: '',
      m03qx: '',
      m04q1: '',
      m04q2: '',
      m04qx: '',
      m05q1: '',
      m05q2: '',
      m05qx: '',
      m06q1: '',
      m06q2: '',
      m06qx: '',
      m07q1: '',
      m07q2: '',
      m07qx: '',
      m08q1: '',
      m08q2: '',
      m08qx: '',
      m09q1: '',
      m09q2: '',
      m09qx: '',
      m10q1: '',
      m10q2: '',
      m10qx: '',
      m11q1: '',
      m11q2: '',
      m11qx: '',
      m12q1: '',
      m12q2: '',
      m12qx: '',
    );
    fichaReg.error.e4eColor = Colors.red;
    fichaReg.error.e4e = 'Se requiere un código E4E válido';
    return fichaReg;
  }

  setWithEnum({
    required TipoRegFicha tipo,
    required String value,
  }) {
    if (tipo == TipoRegFicha.item) item = value;
    if (tipo == TipoRegFicha.year) year = value;
    if (tipo == TipoRegFicha.id) id = value;
    if (tipo == TipoRegFicha.estado) estado = value;
    if (tipo == TipoRegFicha.estdespacho) estdespacho = value;
    if (tipo == TipoRegFicha.tipo) this.tipo = value;
    if (tipo == TipoRegFicha.fechainicial) fechainicial = value;
    if (tipo == TipoRegFicha.fechacambio) fechacambio = value;
    if (tipo == TipoRegFicha.fechasolicitud) fechasolicitud = value;
    if (tipo == TipoRegFicha.unidad) unidad = value;
    if (tipo == TipoRegFicha.codigo) codigo = value;
    if (tipo == TipoRegFicha.proyecto) proyecto = value;
    if (tipo == TipoRegFicha.circuito) circuito = value;
    if (tipo == TipoRegFicha.pm) pm = value;
    if (tipo == TipoRegFicha.solicitante) solicitante = value;
    if (tipo == TipoRegFicha.pdi) pdi = value;
    if (tipo == TipoRegFicha.wbe) wbe = value;
    if (tipo == TipoRegFicha.proyectowbe) proyectowbe = value;
    if (tipo == TipoRegFicha.comentario1) comentario1 = value;
    if (tipo == TipoRegFicha.comentario2) comentario2 = value;
    if (tipo == TipoRegFicha.e4e) e4e = value;
    if (tipo == TipoRegFicha.descripcion) descripcion = value;
    if (tipo == TipoRegFicha.um) um = value;
    if (tipo == TipoRegFicha.m01q1) m01q1 = value;
    if (tipo == TipoRegFicha.m01q2) m01q2 = value;
    if (tipo == TipoRegFicha.m01qx) m01qx = value;
    if (tipo == TipoRegFicha.m02q1) m02q1 = value;
    if (tipo == TipoRegFicha.m02q2) m02q2 = value;
    if (tipo == TipoRegFicha.m02qx) m02qx = value;
    if (tipo == TipoRegFicha.m03q1) m03q1 = value;
    if (tipo == TipoRegFicha.m03q2) m03q2 = value;
    if (tipo == TipoRegFicha.m03qx) m03qx = value;
    if (tipo == TipoRegFicha.m04q1) m04q1 = value;
    if (tipo == TipoRegFicha.m04q2) m04q2 = value;
    if (tipo == TipoRegFicha.m04qx) m04qx = value;
    if (tipo == TipoRegFicha.m05q1) m05q1 = value;
    if (tipo == TipoRegFicha.m05q2) m05q2 = value;
    if (tipo == TipoRegFicha.m05qx) m05qx = value;
    if (tipo == TipoRegFicha.m06q1) m06q1 = value;
    if (tipo == TipoRegFicha.m06q2) m06q2 = value;
    if (tipo == TipoRegFicha.m06qx) m06qx = value;
    if (tipo == TipoRegFicha.m07q1) m07q1 = value;
    if (tipo == TipoRegFicha.m07q2) m07q2 = value;
    if (tipo == TipoRegFicha.m07qx) m07qx = value;
    if (tipo == TipoRegFicha.m08q1) m08q1 = value;
    if (tipo == TipoRegFicha.m08q2) m08q2 = value;
    if (tipo == TipoRegFicha.m08qx) m08qx = value;
    if (tipo == TipoRegFicha.m09q1) m09q1 = value;
    if (tipo == TipoRegFicha.m09q2) m09q2 = value;
    if (tipo == TipoRegFicha.m09qx) m09qx = value;
    if (tipo == TipoRegFicha.m10q1) m10q1 = value;
    if (tipo == TipoRegFicha.m10q2) m10q2 = value;
    if (tipo == TipoRegFicha.m10qx) m10qx = value;
    if (tipo == TipoRegFicha.m11q1) m11q1 = value;
    if (tipo == TipoRegFicha.m11q2) m11q2 = value;
    if (tipo == TipoRegFicha.m11qx) m11qx = value;
    if (tipo == TipoRegFicha.m12q1) m12q1 = value;
    if (tipo == TipoRegFicha.m12q2) m12q2 = value;
    if (tipo == TipoRegFicha.m12qx) m12qx = value;
    return this;
  }

  setWithQuincena(String quincena, String value) {
    if (quincena == '01-1') m01q1 = value;
    if (quincena == '01-2') m01q2 = value;
    if (quincena == '02-1') m02q1 = value;
    if (quincena == '02-2') m02q2 = value;
    if (quincena == '03-1') m03q1 = value;
    if (quincena == '03-2') m03q2 = value;
    if (quincena == '04-1') m04q1 = value;
    if (quincena == '04-2') m04q2 = value;
    if (quincena == '05-1') m05q1 = value;
    if (quincena == '05-2') m05q2 = value;
    if (quincena == '06-1') m06q1 = value;
    if (quincena == '06-2') m06q2 = value;
    if (quincena == '07-1') m07q1 = value;
    if (quincena == '07-2') m07q2 = value;
    if (quincena == '08-1') m08q1 = value;
    if (quincena == '08-2') m08q2 = value;
    if (quincena == '09-1') m09q1 = value;
    if (quincena == '09-2') m09q2 = value;
    if (quincena == '10-1') m10q1 = value;
    if (quincena == '10-2') m10q2 = value;
    if (quincena == '11-1') m11q1 = value;
    if (quincena == '11-2') m11q2 = value;
    if (quincena == '12-1') m12q1 = value;
    if (quincena == '12-2') m12q2 = value;
  }

  //POR COMPATIBILIDAD AL MOMENTO DE TRAER LOS DATOS DE LA BD
  factory FichaReg.fromSingleFEM(SingleFEM singleFEM) {
    return FichaReg(
      item: singleFEM.item,
      year: singleFEM.year,
      id: singleFEM.id,
      estado: singleFEM.estado,
      estdespacho: singleFEM.estdespacho,
      tipo: singleFEM.tipo,
      fechainicial: singleFEM.fechainicial,
      fechacambio: singleFEM.fechacambio,
      fechasolicitud: singleFEM.fechasolicitud,
      unidad: singleFEM.unidad,
      codigo: singleFEM.codigo,
      proyecto: singleFEM.proyecto,
      circuito: singleFEM.circuito,
      pm: singleFEM.pm,
      solicitante: singleFEM.solicitante,
      pdi: singleFEM.pdi,
      wbe: singleFEM.wbe,
      proyectowbe: singleFEM.proyectowbe,
      comentario1: singleFEM.comentario1,
      comentario2: singleFEM.comentario2,
      e4e: singleFEM.e4e,
      descripcion: singleFEM.descripcion,
      um: singleFEM.um,
      m01q1: singleFEM.m01q1,
      m01q2: singleFEM.m01q2,
      m01qx: singleFEM.m01qx,
      m02q1: singleFEM.m02q1,
      m02q2: singleFEM.m02q2,
      m02qx: singleFEM.m02qx,
      m03q1: singleFEM.m03q1,
      m03q2: singleFEM.m03q2,
      m03qx: singleFEM.m03qx,
      m04q1: singleFEM.m04q1,
      m04q2: singleFEM.m04q2,
      m04qx: singleFEM.m04qx,
      m05q1: singleFEM.m05q1,
      m05q2: singleFEM.m05q2,
      m05qx: singleFEM.m05qx,
      m06q1: singleFEM.m06q1,
      m06q2: singleFEM.m06q2,
      m06qx: singleFEM.m06qx,
      m07q1: singleFEM.m07q1,
      m07q2: singleFEM.m07q2,
      m07qx: singleFEM.m07qx,
      m08q1: singleFEM.m08q1,
      m08q2: singleFEM.m08q2,
      m08qx: singleFEM.m08qx,
      m09q1: singleFEM.m09q1,
      m09q2: singleFEM.m09q2,
      m09qx: singleFEM.m09qx,
      m10q1: singleFEM.m10q1,
      m10q2: singleFEM.m10q2,
      m10qx: singleFEM.m10qx,
      m11q1: singleFEM.m11q1,
      m11q2: singleFEM.m11q2,
      m11qx: singleFEM.m11qx,
      m12q1: singleFEM.m12q1,
      m12q2: singleFEM.m12q2,
      m12qx: singleFEM.m12qx,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FichaReg &&
        other.id == id &&
        other.estado == estado &&
        other.estdespacho == estdespacho &&
        other.tipo == tipo &&
        other.fechainicial == fechainicial &&
        other.fechacambio == fechacambio &&
        other.fechasolicitud == fechasolicitud &&
        other.unidad == unidad &&
        other.codigo == codigo &&
        other.proyecto == proyecto &&
        other.circuito == circuito &&
        other.pm == pm &&
        other.solicitante == solicitante &&
        other.pdi == pdi &&
        other.wbe == wbe &&
        other.proyectowbe == proyectowbe &&
        other.comentario1 == comentario1 &&
        other.comentario2 == comentario2 &&
        other.e4e == e4e &&
        other.descripcion == descripcion &&
        other.um == um &&
        other.m01q1 == m01q1 &&
        other.m01q2 == m01q2 &&
        other.m01qx == m01qx &&
        other.m02q1 == m02q1 &&
        other.m02q2 == m02q2 &&
        other.m02qx == m02qx &&
        other.m03q1 == m03q1 &&
        other.m03q2 == m03q2 &&
        other.m03qx == m03qx &&
        other.m04q1 == m04q1 &&
        other.m04q2 == m04q2 &&
        other.m04qx == m04qx &&
        other.m05q1 == m05q1 &&
        other.m05q2 == m05q2 &&
        other.m05qx == m05qx &&
        other.m06q1 == m06q1 &&
        other.m06q2 == m06q2 &&
        other.m06qx == m06qx &&
        other.m07q1 == m07q1 &&
        other.m07q2 == m07q2 &&
        other.m07qx == m07qx &&
        other.m08q1 == m08q1 &&
        other.m08q2 == m08q2 &&
        other.m08qx == m08qx &&
        other.m09q1 == m09q1 &&
        other.m09q2 == m09q2 &&
        other.m09qx == m09qx &&
        other.m10q1 == m10q1 &&
        other.m10q2 == m10q2 &&
        other.m10qx == m10qx &&
        other.m11q1 == m11q1 &&
        other.m11q2 == m11q2 &&
        other.m11qx == m11qx &&
        other.m12q1 == m12q1 &&
        other.m12q2 == m12q2 &&
        other.m12qx == m12qx;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        estado.hashCode ^
        estdespacho.hashCode ^
        tipo.hashCode ^
        fechainicial.hashCode ^
        fechacambio.hashCode ^
        fechasolicitud.hashCode ^
        unidad.hashCode ^
        codigo.hashCode ^
        proyecto.hashCode ^
        circuito.hashCode ^
        pm.hashCode ^
        solicitante.hashCode ^
        pdi.hashCode ^
        wbe.hashCode ^
        proyectowbe.hashCode ^
        comentario1.hashCode ^
        comentario2.hashCode ^
        e4e.hashCode ^
        descripcion.hashCode ^
        um.hashCode ^
        m01q1.hashCode ^
        m01q2.hashCode ^
        m01qx.hashCode ^
        m02q1.hashCode ^
        m02q2.hashCode ^
        m02qx.hashCode ^
        m03q1.hashCode ^
        m03q2.hashCode ^
        m03qx.hashCode ^
        m04q1.hashCode ^
        m04q2.hashCode ^
        m04qx.hashCode ^
        m05q1.hashCode ^
        m05q2.hashCode ^
        m05qx.hashCode ^
        m06q1.hashCode ^
        m06q2.hashCode ^
        m06qx.hashCode ^
        m07q1.hashCode ^
        m07q2.hashCode ^
        m07qx.hashCode ^
        m08q1.hashCode ^
        m08q2.hashCode ^
        m08qx.hashCode ^
        m09q1.hashCode ^
        m09q2.hashCode ^
        m09qx.hashCode ^
        m10q1.hashCode ^
        m10q2.hashCode ^
        m10qx.hashCode ^
        m11q1.hashCode ^
        m11q2.hashCode ^
        m11qx.hashCode ^
        m12q1.hashCode ^
        m12q2.hashCode ^
        m12qx.hashCode;
  }

  @override
  String toString() {
    return 'FichaReg(razon:${log.razon}, cambio:${log.cambio}  item: $item, year: $year, id: $id, estado: $estado, estdespacho: $estdespacho, tipo: $tipo, fechainicial: $fechainicial, fechacambio: $fechacambio, fechasolicitud: $fechasolicitud, unidad: $unidad, codigo: $codigo, proyecto: $proyecto, circuito: $circuito, pm: $pm, solicitante: $solicitante, pdi: $pdi, wbe: $wbe, proyectowbe: $proyectowbe, comentario1: $comentario1, comentario2: $comentario2, e4e: $e4e, descripcion: $descripcion, um: $um, m01q1: $m01q1, m01q2: $m01q2, m01qx: $m01qx, m02q1: $m02q1, m02q2: $m02q2, m02qx: $m02qx, m03q1: $m03q1, m03q2: $m03q2, m03qx: $m03qx, m04q1: $m04q1, m04q2: $m04q2, m04qx: $m04qx, m05q1: $m05q1, m05q2: $m05q2, m05qx: $m05qx, m06q1: $m06q1, m06q2: $m06q2, m06qx: $m06qx, m07q1: $m07q1, m07q2: $m07q2, m07qx: $m07qx, m08q1: $m08q1, m08q2: $m08q2, m08qx: $m08qx, m09q1: $m09q1, m09q2: $m09q2, m09qx: $m09qx, m10q1: $m10q1, m10q2: $m10q2, m10qx: $m10qx, m11q1: $m11q1, m11q2: $m11q2, m11qx: $m11qx, m12q1: $m12q1, m12q2: $m12q2, m12qx: $m12qx, esControlado: $esControlado, agendado: $agendado, error: $error, planificado: $planificado)';
  }

  void setPedido(
    String pedido,
    String valor,
  ) {
    var objetopedidos = jsonDecode(estdespacho);
    objetopedidos[0][pedido] = valor;
    estdespacho = jsonEncode(objetopedidos);
  }
}
