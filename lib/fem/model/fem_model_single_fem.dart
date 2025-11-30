import 'dart:convert';

import 'package:fem_app/fem/model/fem_model_log.dart';
import 'package:flutter/material.dart';

import '../../bloc/main_bloc.dart';
import '../../nuevo/model/nuevo_model.dart';
import '../../pedidos/model/pedidos_model.dart';
import '../../resources/a_entero_2.dart';
import 'fem_model_single_fem_enum.dart';

class SingleFEM {
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
  Color? circuitoColor;
  Color? wbeColor;
  Color? wbeColorFill;
  Color? e4eColor;
  Color? pdiColor;
  Color? comentarioColor;
  late SingleFEMLog log;

  SingleFEM({
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
  }){
    log = SingleFEMLog(this);
  }

  SingleFEM copyWith({
    String? item,
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
  }) {
    return SingleFEM(
      item: item ?? this.item,
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
    );
  }

  SingleFEM copyWithEnum({
    required TipoFem tipo,
    required String value,
  }) {
    switch (tipo) {
      case TipoFem.item:
        return copyWith(item: value);
      case TipoFem.year:
        return copyWith(id: value);
      case TipoFem.id:
        return copyWith(id: value);
      case TipoFem.estado:
        return copyWith(estado: value);
      case TipoFem.estdespacho:
        return copyWith(estdespacho: value);
      case TipoFem.tipo:
        return copyWith(tipo: value);
      case TipoFem.fechainicial:
        return copyWith(fechainicial: value);
      case TipoFem.fechacambio:
        return copyWith(fechacambio: value);
      case TipoFem.fechasolicitud:
        return copyWith(fechasolicitud: value);
      case TipoFem.unidad:
        return copyWith(unidad: value);
      case TipoFem.codigo:
        return copyWith(codigo: value);
      case TipoFem.proyecto:
        return copyWith(proyecto: value);
      case TipoFem.circuito:
        return copyWith(circuito: value);
      case TipoFem.pm:
        return copyWith(pm: value);
      case TipoFem.solicitante:
        return copyWith(solicitante: value);
      case TipoFem.pdi:
        return copyWith(pdi: value);
      case TipoFem.wbe:
        return copyWith(wbe: value);
      case TipoFem.proyectowbe:
        return copyWith(proyectowbe: value);
      case TipoFem.comentario1:
        return copyWith(comentario1: value);
      case TipoFem.comentario2:
        return copyWith(comentario2: value);
      case TipoFem.e4e:
        return copyWith(e4e: value);
      case TipoFem.descripcion:
        return copyWith(descripcion: value);
      case TipoFem.um:
        return copyWith(um: value);
      case TipoFem.m01q1:
        return copyWith(m01q1: value);
      case TipoFem.m01q2:
        return copyWith(m01q2: value);
      case TipoFem.m01qx:
        return copyWith(m01qx: value);
      case TipoFem.m02q1:
        return copyWith(m02q1: value);
      case TipoFem.m02q2:
        return copyWith(m02q2: value);
      case TipoFem.m02qx:
        return copyWith(m02qx: value);
      case TipoFem.m03q1:
        return copyWith(m03q1: value);
      case TipoFem.m03q2:
        return copyWith(m03q2: value);
      case TipoFem.m03qx:
        return copyWith(m03qx: value);
      case TipoFem.m04q1:
        return copyWith(m04q1: value);
      case TipoFem.m04q2:
        return copyWith(m04q2: value);
      case TipoFem.m04qx:
        return copyWith(m04qx: value);
      case TipoFem.m05q1:
        return copyWith(m05q1: value);
      case TipoFem.m05q2:
        return copyWith(m05q2: value);
      case TipoFem.m05qx:
        return copyWith(m05qx: value);
      case TipoFem.m06q1:
        return copyWith(m06q1: value);
      case TipoFem.m06q2:
        return copyWith(m06q2: value);
      case TipoFem.m06qx:
        return copyWith(m06qx: value);
      case TipoFem.m07q1:
        return copyWith(m07q1: value);
      case TipoFem.m07q2:
        return copyWith(m07q2: value);
      case TipoFem.m07qx:
        return copyWith(m07qx: value);
      case TipoFem.m08q1:
        return copyWith(m08q1: value);
      case TipoFem.m08q2:
        return copyWith(m08q2: value);
      case TipoFem.m08qx:
        return copyWith(m08qx: value);
      case TipoFem.m09q1:
        return copyWith(m09q1: value);
      case TipoFem.m09q2:
        return copyWith(m09q2: value);
      case TipoFem.m09qx:
        return copyWith(m09qx: value);
      case TipoFem.m10q1:
        return copyWith(m10q1: value);
      case TipoFem.m10q2:
        return copyWith(m10q2: value);
      case TipoFem.m10qx:
        return copyWith(m10qx: value);
      case TipoFem.m11q1:
        return copyWith(m11q1: value);
      case TipoFem.m11q2:
        return copyWith(m11q2: value);
      case TipoFem.m11qx:
        return copyWith(m11qx: value);
      case TipoFem.m12q1:
        return copyWith(m12q1: value);
      case TipoFem.m12q2:
        return copyWith(m12q2: value);
      case TipoFem.m12qx:
        return copyWith(m12qx: value);
    }
  }

  setWithEnum({
    required TipoFem tipoFem,
    required String value,
  }) {
    switch (tipoFem) {
      case TipoFem.item:
        item = value;
        break;
      case TipoFem.year:
        year = value;
        break;
      case TipoFem.id:
        id = value;
        break;
      case TipoFem.estado:
        estado = value;
        break;
      case TipoFem.estdespacho:
        estdespacho = value;
        break;
      case TipoFem.tipo:
        tipo = value;
        break;
      case TipoFem.fechainicial:
        fechainicial = value;
        break;
      case TipoFem.fechacambio:
        fechacambio = value;
        break;
      case TipoFem.fechasolicitud:
        fechasolicitud = value;
        break;
      case TipoFem.unidad:
        unidad = value;
        break;
      case TipoFem.codigo:
        codigo = value;
        break;
      case TipoFem.proyecto:
        proyecto = value;
        break;
      case TipoFem.circuito:
        circuito = value;
        break;
      case TipoFem.pm:
        pm = value;
        break;
      case TipoFem.solicitante:
        solicitante = value;
        break;
      case TipoFem.pdi:
        pdi = value;
        break;
      case TipoFem.wbe:
        wbe = value;
        break;
      case TipoFem.proyectowbe:
        proyectowbe = value;
        break;
      case TipoFem.comentario1:
        comentario1 = value;
        break;
      case TipoFem.comentario2:
        comentario2 = value;
        break;
      case TipoFem.e4e:
        e4e = value;
        break;
      case TipoFem.descripcion:
        descripcion = value;
        break;
      case TipoFem.um:
        um = value;
        break;
      case TipoFem.m01q1:
        m01q1 = value;
        break;
      case TipoFem.m01q2:
        m01q2 = value;
        break;
      case TipoFem.m01qx:
        m01qx = value;
        break;
      case TipoFem.m02q1:
        m02q1 = value;
        break;
      case TipoFem.m02q2:
        m02q2 = value;
        break;
      case TipoFem.m02qx:
        m02qx = value;
        break;
      case TipoFem.m03q1:
        m03q1 = value;
        break;
      case TipoFem.m03q2:
        m03q2 = value;
        break;
      case TipoFem.m03qx:
        m03qx = value;
        break;
      case TipoFem.m04q1:
        m04q1 = value;
        break;
      case TipoFem.m04q2:
        m04q2 = value;
        break;
      case TipoFem.m04qx:
        m04qx = value;
        break;
      case TipoFem.m05q1:
        m05q1 = value;
        break;
      case TipoFem.m05q2:
        m05q2 = value;
        break;
      case TipoFem.m05qx:
        m05qx = value;
        break;
      case TipoFem.m06q1:
        m06q1 = value;
        break;
      case TipoFem.m06q2:
        m06q2 = value;
        break;
      case TipoFem.m06qx:
        m06qx = value;
        break;
      case TipoFem.m07q1:
        m07q1 = value;
        break;
      case TipoFem.m07q2:
        m07q2 = value;
        break;
      case TipoFem.m07qx:
        m07qx = value;
        break;
      case TipoFem.m08q1:
        m08q1 = value;
        break;
      case TipoFem.m08q2:
        m08q2 = value;
        break;
      case TipoFem.m08qx:
        m08qx = value;
        break;
      case TipoFem.m09q1:
        m09q1 = value;
        break;
      case TipoFem.m09q2:
        m09q2 = value;
        break;
      case TipoFem.m09qx:
        m09qx = value;
        break;
      case TipoFem.m10q1:
        m10q1 = value;
        break;
      case TipoFem.m10q2:
        m10q2 = value;
        break;
      case TipoFem.m10qx:
        m10qx = value;
        break;
      case TipoFem.m11q1:
        m11q1 = value;
        break;
      case TipoFem.m11q2:
        m11q2 = value;
        break;
      case TipoFem.m11qx:
        m11qx = value;
        break;
      case TipoFem.m12q1:
        m12q1 = value;
        break;
      case TipoFem.m12q2:
        m12q2 = value;
        break;
      case TipoFem.m12qx:
        m12qx = value;
        break;
    }
    return this;
  }

  setCantidad({
    required String campo,
    required String value,
  }) {
    if (campo == 'm01q1') m01q1 = value;
    if (campo == 'm01q2') m01q2 = value;
    if (campo == 'm01qx') m01qx = value;
    if (campo == 'm02q1') m02q1 = value;
    if (campo == 'm02q2') m02q2 = value;
    if (campo == 'm02qx') m02qx = value;
    if (campo == 'm03q1') m03q1 = value;
    if (campo == 'm03q2') m03q2 = value;
    if (campo == 'm03qx') m03qx = value;
    if (campo == 'm04q1') m04q1 = value;
    if (campo == 'm04q2') m04q2 = value;
    if (campo == 'm04qx') m04qx = value;
    if (campo == 'm05q1') m05q1 = value;
    if (campo == 'm05q2') m05q2 = value;
    if (campo == 'm05qx') m05qx = value;
    if (campo == 'm06q1') m06q1 = value;
    if (campo == 'm06q2') m06q2 = value;
    if (campo == 'm06qx') m06qx = value;
    if (campo == 'm07q1') m07q1 = value;
    if (campo == 'm07q2') m07q2 = value;
    if (campo == 'm07qx') m07qx = value;
    if (campo == 'm08q1') m08q1 = value;
    if (campo == 'm08q2') m08q2 = value;
    if (campo == 'm08qx') m08qx = value;
    if (campo == 'm09q1') m09q1 = value;
    if (campo == 'm09q2') m09q2 = value;
    if (campo == 'm09qx') m09qx = value;
    if (campo == 'm10q1') m10q1 = value;
    if (campo == 'm10q2') m10q2 = value;
    if (campo == 'm10qx') m10qx = value;
    if (campo == 'm11q1') m11q1 = value;
    if (campo == 'm11q2') m11q2 = value;
    if (campo == 'm11qx') m11qx = value;
    if (campo == 'm12q1') m12q1 = value;
    if (campo == 'm12q2') m12q2 = value;
    if (campo == 'm12qx') m12qx = value;
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

  SingleFEM setPedido(
    String pedido,
    String valor,
  ) {
    var objetopedidos = jsonDecode(estdespacho);
    objetopedidos[0][pedido] = valor;
    estdespacho = jsonEncode(objetopedidos);
    return this;
  }

  setValueEvent(ModFemList event) {
    switch (event.field) {
      case 'PDI':
        pdi = event.value;
        break;
      case 'WBE':
        wbe = event.value;
        break;
      case 'proyecto':
        proyectowbe = event.value;
        break;
      case 'comentario':
        comentario2 = event.value;
        break;
      case 'tipo':
        tipo = event.value;
        break;
      case 'cto':
        circuito = event.value;
        break;
      case 'ctd':
        switch (event.mes) {
          case '01':
            if (event.q == '1') {
              m01q1 = event.value;
            } else if (event.q == '2') {
              m01q2 = event.value;
            } else if (event.q == 'x') {
              m01qx = event.value;
            }
            break;
          case '02':
            if (event.q == '1') {
              m02q1 = event.value;
            } else if (event.q == '2') {
              m02q2 = event.value;
            } else if (event.q == 'x') {
              m02qx = event.value;
            }
            break;
          case '03':
            if (event.q == '1') {
              m03q1 = event.value;
            } else if (event.q == '2') {
              m03q2 = event.value;
            } else if (event.q == 'x') {
              m03qx = event.value;
            }
            break;
          case '04':
            if (event.q == '1') {
              m04q1 = event.value;
            } else if (event.q == '2') {
              m04q2 = event.value;
            } else if (event.q == 'x') {
              m04qx = event.value;
            }
            break;
          case '05':
            if (event.q == '1') {
              m05q1 = event.value;
            } else if (event.q == '2') {
              m05q2 = event.value;
            } else if (event.q == 'x') {
              m05qx = event.value;
            }
            break;
          case '06':
            if (event.q == '1') {
              m06q1 = event.value;
            } else if (event.q == '2') {
              m06q2 = event.value;
            } else if (event.q == 'x') {
              m06qx = event.value;
            }
            break;
          case '07':
            if (event.q == '1') {
              m07q1 = event.value;
            } else if (event.q == '2') {
              m07q2 = event.value;
            } else if (event.q == 'x') {
              m07qx = event.value;
            }
            break;
          case '08':
            if (event.q == '1') {
              m08q1 = event.value;
            } else if (event.q == '2') {
              m08q2 = event.value;
            } else if (event.q == 'x') {
              m08qx = event.value;
            }
            break;
          case '09':
            if (event.q == '1') {
              m09q1 = event.value;
            } else if (event.q == '2') {
              m09q2 = event.value;
            } else if (event.q == 'x') {
              m09qx = event.value;
            }
            break;
          case '10':
            if (event.q == '1') {
              m10q1 = event.value;
            } else if (event.q == '2') {
              m10q2 = event.value;
            } else if (event.q == 'x') {
              m10qx = event.value;
            }
            break;
          case '11':
            if (event.q == '1') {
              m11q1 = event.value;
            } else if (event.q == '2') {
              m11q2 = event.value;
            } else if (event.q == 'x') {
              m11qx = event.value;
            }
            break;
          case '12':
            if (event.q == '1') {
              m12q1 = event.value;
            } else if (event.q == '2') {
              m12q2 = event.value;
            } else if (event.q == 'x') {
              m12qx = event.value;
            }
            break;
          default:
            print('error mes ${event.mes} no existe');
        }
        break;
      default:
        print('error campo ${event.field} no existe');
    }
  }

  int get m01q1Int => aEntero(m01q1);
  int get m01q2Int => aEntero(m01q2);
  int get m01qxInt => aEntero(m01qx);
  int get m02q1Int => aEntero(m02q1);
  int get m02q2Int => aEntero(m02q2);
  int get m02qxInt => aEntero(m02qx);
  int get m03q1Int => aEntero(m03q1);
  int get m03q2Int => aEntero(m03q2);
  int get m03qxInt => aEntero(m03qx);
  int get m04q1Int => aEntero(m04q1);
  int get m04q2Int => aEntero(m04q2);
  int get m04qxInt => aEntero(m04qx);
  int get m05q1Int => aEntero(m05q1);
  int get m05q2Int => aEntero(m05q2);
  int get m05qxInt => aEntero(m05qx);
  int get m06q1Int => aEntero(m06q1);
  int get m06q2Int => aEntero(m06q2);
  int get m06qxInt => aEntero(m06qx);
  int get m07q1Int => aEntero(m07q1);
  int get m07q2Int => aEntero(m07q2);
  int get m07qxInt => aEntero(m07qx);
  int get m08q1Int => aEntero(m08q1);
  int get m08q2Int => aEntero(m08q2);
  int get m08qxInt => aEntero(m08qx);
  int get m09q1Int => aEntero(m09q1);
  int get m09q2Int => aEntero(m09q2);
  int get m09qxInt => aEntero(m09qx);
  int get m10q1Int => aEntero(m10q1);
  int get m10q2Int => aEntero(m10q2);
  int get m10qxInt => aEntero(m10qx);
  int get m11q1Int => aEntero(m11q1);
  int get m11q2Int => aEntero(m11q2);
  int get m11qxInt => aEntero(m11qx);
  int get m12q1Int => aEntero(m12q1);
  int get m12q2Int => aEntero(m12q2);
  int get m12qxInt => aEntero(m12qx);

  int get mes01 => aEntero(m01q1) + aEntero(m01q2);
  int get mes02 => aEntero(m02q1) + aEntero(m02q2);
  int get mes03 => aEntero(m03q1) + aEntero(m03q2);
  int get mes04 => aEntero(m04q1) + aEntero(m04q2);
  int get mes05 => aEntero(m05q1) + aEntero(m05q2);
  int get mes06 => aEntero(m06q1) + aEntero(m06q2);
  int get mes07 => aEntero(m07q1) + aEntero(m07q2);
  int get mes08 => aEntero(m08q1) + aEntero(m08q2);
  int get mes09 => aEntero(m09q1) + aEntero(m09q2);
  int get mes10 => aEntero(m10q1) + aEntero(m10q2);
  int get mes11 => aEntero(m11q1) + aEntero(m11q2);
  int get mes12 => aEntero(m12q1) + aEntero(m12q2);

  int get m01 => aEntero(m01q1) + aEntero(m01q2) + aEntero(m01qx);
  int get m02 => aEntero(m02q1) + aEntero(m02q2) + aEntero(m02qx);
  int get m03 => aEntero(m03q1) + aEntero(m03q2) + aEntero(m03qx);
  int get m04 => aEntero(m04q1) + aEntero(m04q2) + aEntero(m04qx);
  int get m05 => aEntero(m05q1) + aEntero(m05q2) + aEntero(m05qx);
  int get m06 => aEntero(m06q1) + aEntero(m06q2) + aEntero(m06qx);
  int get m07 => aEntero(m07q1) + aEntero(m07q2) + aEntero(m07qx);
  int get m08 => aEntero(m08q1) + aEntero(m08q2) + aEntero(m08qx);
  int get m09 => aEntero(m09q1) + aEntero(m09q2) + aEntero(m09qx);
  int get m10 => aEntero(m10q1) + aEntero(m10q2) + aEntero(m10qx);
  int get m11 => aEntero(m11q1) + aEntero(m11q2) + aEntero(m11qx);
  int get m12 => aEntero(m12q1) + aEntero(m12q2) + aEntero(m12qx);
  int get total =>
      m01 + m02 + m03 + m04 + m05 + m06 + m07 + m08 + m09 + m10 + m11 + m12;

  int campo(int n) {
    if (n == 1) return m01;
    if (n == 2) return m02;
    if (n == 3) return m03;
    if (n == 4) return m04;
    if (n == 5) return m05;
    if (n == 6) return m06;
    if (n == 7) return m07;
    if (n == 8) return m08;
    if (n == 9) return m09;
    if (n == 10) return m10;
    if (n == 11) return m11;
    if (n == 12) return m12;
    if (n == 101) return m01q1ped + aEntero(m01q2) + aEntero(m01qx);
    if (n == 201) return m02q1ped + aEntero(m02q2) + aEntero(m02qx);
    if (n == 301) return m03q1ped + aEntero(m03q2) + aEntero(m03qx);
    if (n == 401) return m04q1ped + aEntero(m04q2) + aEntero(m04qx);
    if (n == 501) return m05q1ped + aEntero(m05q2) + aEntero(m05qx);
    if (n == 601) return m06q1ped + aEntero(m06q2) + aEntero(m06qx);
    if (n == 701) return m07q1ped + aEntero(m07q2) + aEntero(m07qx);
    if (n == 801) return m08q1ped + aEntero(m08q2) + aEntero(m08qx);
    if (n == 901) return m09q1ped + aEntero(m09q2) + aEntero(m09qx);
    if (n == 1001) return m10q1ped + aEntero(m10q2) + aEntero(m10qx);
    if (n == 1101) return m11q1ped + aEntero(m11q2) + aEntero(m11qx);
    if (n == 1201) return m12q1ped + aEntero(m12q2) + aEntero(m12qx);
    if (n == 102) return m01q2ped + aEntero(m01qx);
    if (n == 202) return m02q2ped + aEntero(m02qx);
    if (n == 302) return m03q2ped + aEntero(m03qx);
    if (n == 402) return m04q2ped + aEntero(m04qx);
    if (n == 502) return m05q2ped + aEntero(m05qx);
    if (n == 602) return m06q2ped + aEntero(m06qx);
    if (n == 702) return m07q2ped + aEntero(m07qx);
    if (n == 802) return m08q2ped + aEntero(m08qx);
    if (n == 902) return m09q2ped + aEntero(m09qx);
    if (n == 1002) return m10q2ped + aEntero(m10qx);
    if (n == 1102) return m11q2ped + aEntero(m11qx);
    if (n == 1202) return m12q2ped + aEntero(m12qx);
    if (n == 103) return aEntero(m01qx);
    if (n == 203) return aEntero(m02qx);
    if (n == 303) return aEntero(m03qx);
    if (n == 403) return aEntero(m04qx);
    if (n == 503) return aEntero(m05qx);
    if (n == 603) return aEntero(m06qx);
    if (n == 703) return aEntero(m07qx);
    if (n == 803) return aEntero(m08qx);
    if (n == 903) return aEntero(m09qx);
    if (n == 1003) return aEntero(m10qx);
    if (n == 1103) return aEntero(m11qx);
    if (n == 1203) return aEntero(m12qx);
    if (n == 104) return m01q1ped + m01q2ped + aEntero(m01qx);
    if (n == 204) return m02q1ped + m02q2ped + aEntero(m02qx);
    if (n == 304) return m03q1ped + m03q2ped + aEntero(m03qx);
    if (n == 404) return m04q1ped + m04q2ped + aEntero(m04qx);
    if (n == 504) return m05q1ped + m05q2ped + aEntero(m05qx);
    if (n == 604) return m06q1ped + m06q2ped + aEntero(m06qx);
    if (n == 704) return m07q1ped + m07q2ped + aEntero(m07qx);
    if (n == 804) return m08q1ped + m08q2ped + aEntero(m08qx);
    if (n == 904) return m09q1ped + m09q2ped + aEntero(m09qx);
    if (n == 1004) return m10q1ped + m10q2ped + aEntero(m10qx);
    if (n == 1104) return m11q1ped + m11q2ped + aEntero(m11qx);
    if (n == 1204) return m12q1ped + m12q2ped + aEntero(m12qx);
    return m12;
  }

  int campoyEstado(
    int n, {
    bool entregadoQ1 = false,
    bool abiertoQ1 = true,
    bool entregadoQ2 = false,
    bool abiertoQ2 = true,
  }) {
    int mes = 0;
    if (abiertoQ1) return campo(n);
    if (abiertoQ2 && !abiertoQ1) {
      return campo(n * 100 + 1); // pedido q1 + planificacion q2 + ex
    }
    if (!abiertoQ2 && !abiertoQ1) {
      if (!entregadoQ1 && !entregadoQ2)
        return campo(n * 100 + 4); //pedido q1 + pedido q2 + ex
      if (entregadoQ1 && !entregadoQ2)
        return campo(n * 100 + 2); // pedido q2 + ex
      if (entregadoQ1 && entregadoQ2) return mes; //0
    }
    return mes;
  }

  int campoyEstado2(
    int n, {
    bool entregadoQ1 = false,
    bool abiertoQ1 = true,
    bool entregadoQ2 = false,
    bool abiertoQ2 = true,
  }) {
    int mes = 0;
    if (abiertoQ1) return campo(n);
    if (abiertoQ2 && !abiertoQ1) {
      return campo(n * 100 + 1); // pedido q1 + planificacion q2 + ex
    }
    if (!abiertoQ2 && !abiertoQ1) {
      return campo(n * 100 + 4);
    }
    return mes;
  }

  List<int> filtradoFechasFem({
    required Map<int, EnableDateInt> enableDatesInt,
  }) {
    List<int> meses = [];
    for (int i = 1; i <= 12; i++) {
      int q = campoyEstado2(
        i,
        entregadoQ1: enableDatesInt[i]!.entredoQ1,
        abiertoQ1: enableDatesInt[i]!.pedidoActivoq1,
        entregadoQ2: enableDatesInt[i]!.entredoQ2,
        abiertoQ2: enableDatesInt[i]!.pedidoActivoq2,
      );
      meses.add(q);
    }
    meses.add(meses.fold(0, (p, a) => p + a));
    return meses;
  }

  int campoThisYear(int n) {
    if (n == 1) return m01;
    if (n == 2) return m02;
    if (n == 3) return m03;
    if (n == 4) return m04;
    if (n == 5) return m05;
    if (n == 6) return m06;
    if (n == 7) return m07;
    if (n == 8) return m08;
    if (n == 9) return m09;
    if (n == 10) return m10;
    if (n == 11) return m11;
    if (n == 12) return m12;
    return m12;
  }

  bool isNotEmptyBetween(int n1, int n2) {
    for (int i = n1; i <= n2; i++) {
      if (campo(i) != 0) return true;
    }
    return false;
  }

  bool isNotEmptyBetweenThisYear(int n1, int n2, int day) {
    int q1 = pedidoMapInt()['m${n1.toString().padLeft(2, '0')}q1']!;
    int q2 = pedidoMapInt()['m${n1.toString().padLeft(2, '0')}q2']!;
    int qx = pedidoMapInt()['m${n1.toString().padLeft(2, '0')}qx']!;
    for (int i = n1; i <= n2; i++) {
      if (i == n1 && day < 15) {
        if (q1 + q2 + qx > 0) return true;
      } else if (i == n1 && day >= 15) {
        if (q2 + qx > 0) return true;
      } else {
        if (campo(i) != 0) return true;
      }
    }
    return false;
  }

  int between(int n1, int n2) {
    int result = 0;
    for (int i = n1; i <= n2; i++) {
      result += campo(i);
    }
    return result;
  }

  int betweenThisYear(int n1, int n2, int day) {
    int q2 = aEntero(toMap()['m${n1.toString().padLeft(2, '0')}q2']);
    int qx = aEntero(toMap()['m${n1.toString().padLeft(2, '0')}qx']);
    int result = 0;
    for (int i = n1; i <= n2; i++) {
      if (i == n1 && day < 15) {
        result += q2 + qx;
      } else if (i == n1 && day >= 15) {
        result += qx;
      } else {
        result += campo(i);
      }
    }
    return result;
  }

  Map get pedidoMap => jsonDecode(estdespacho)[0];

  List get pedido {
    if (!estdespacho.startsWith('[{')) {
      return List.filled(24, '0');
    }
    try {
      // ignore: unused_local_variable
      Map pedidoMap = jsonDecode(estdespacho)[0];
    } catch (e) {
      print('error en pedidoMap Fem Model');
      print(estdespacho);
      print(e);
    }

    return jsonDecode(estdespacho)[0].values.toList();
  }

  Map itemAndFlex = {
    'circuito': [1, 'Circuito'],
    'e4e': [1, 'E4e'],
    'descripcion': [1, 'Descripción'],
    'um': [1, 'u'],
    'm01': [1, '01'],
    'm02': [1, '02'],
    'm03': [1, '03'],
    'm04': [1, '04'],
    'm05': [1, '05'],
    'm06': [1, '06'],
    'm07': [1, '07'],
    'm08': [1, '08'],
    'm09': [1, '09'],
    'm10': [1, '10'],
    'm11': [1, '11'],
    'm12': [1, '12'],
  };

  Map get mapToTitlesForecast => {
        // 'id': [1, 'Año'],
        'proyecto': [8, proyecto],
        'circuito': [4, circuito],
        'e4e': [2, e4e],
        'descripcion': [6, descripcion],
        'um': [1, um],
        'm01': [1, m01],
        'm02': [1, m02],
        'm03': [1, m03],
        'm04': [1, m04],
        'm05': [1, m05],
        'm06': [1, m06],
        'm07': [1, m07],
        'm08': [1, m08],
        'm09': [1, m09],
        'm10': [1, m10],
        'm11': [1, m11],
        'm12': [1, m12],
        'total': [1, total],
      };

  Map<String, dynamic> get mapDownloadForecast => {
        // 'id': [1, 'Año'],
        'proyecto': proyecto,
        'e4e': e4e,
        'descripcion': descripcion,
        'um': um,
        'm01': m01,
        'm02': m02,
        'm03': m03,
        'm04': m04,
        'm05': m05,
        'm06': m06,
        'm07': m07,
        'm08': m08,
        'm09': m09,
        'm10': m10,
        'm11': m11,
        'm12': m12,
        'total': total,
      };

  int get m01q1ped => aEntero(m01q1) * aEntero(pedido[0]);
  int get m01q2ped => aEntero(m01q2) * aEntero(pedido[1]);
  int get m02q1ped => aEntero(m02q1) * aEntero(pedido[2]);
  int get m02q2ped => aEntero(m02q2) * aEntero(pedido[3]);
  int get m03q1ped => aEntero(m03q1) * aEntero(pedido[4]);
  int get m03q2ped => aEntero(m03q2) * aEntero(pedido[5]);
  int get m04q1ped => aEntero(m04q1) * aEntero(pedido[6]);
  int get m04q2ped => aEntero(m04q2) * aEntero(pedido[7]);
  int get m05q1ped => aEntero(m05q1) * aEntero(pedido[8]);
  int get m05q2ped => aEntero(m05q2) * aEntero(pedido[9]);
  int get m06q1ped => aEntero(m06q1) * aEntero(pedido[10]);
  int get m06q2ped => aEntero(m06q2) * aEntero(pedido[11]);
  int get m07q1ped => aEntero(m07q1) * aEntero(pedido[12]);
  int get m07q2ped => aEntero(m07q2) * aEntero(pedido[13]);
  int get m08q1ped => aEntero(m08q1) * aEntero(pedido[14]);
  int get m08q2ped => aEntero(m08q2) * aEntero(pedido[15]);
  int get m09q1ped => aEntero(m09q1) * aEntero(pedido[16]);
  int get m09q2ped => aEntero(m09q2) * aEntero(pedido[17]);
  int get m10q1ped => aEntero(m10q1) * aEntero(pedido[18]);
  int get m10q2ped => aEntero(m10q2) * aEntero(pedido[19]);
  int get m11q1ped => aEntero(m11q1) * aEntero(pedido[20]);
  int get m11q2ped => aEntero(m11q2) * aEntero(pedido[21]);
  int get m12q1ped => aEntero(m12q1) * aEntero(pedido[22]);
  int get m12q2ped => aEntero(m12q2) * aEntero(pedido[23]);

  int get m01ped => m01q1ped + m01q2ped + aEntero(m01qx);
  int get m02ped => m02q1ped + m02q2ped + aEntero(m02qx);
  int get m03ped => m03q1ped + m03q2ped + aEntero(m03qx);
  int get m04ped => m04q1ped + m04q2ped + aEntero(m04qx);
  int get m05ped => m05q1ped + m05q2ped + aEntero(m05qx);
  int get m06ped => m06q1ped + m06q2ped + aEntero(m06qx);
  int get m07ped => m07q1ped + m07q2ped + aEntero(m07qx);
  int get m08ped => m08q1ped + m08q2ped + aEntero(m08qx);
  int get m09ped => m09q1ped + m09q2ped + aEntero(m09qx);
  int get m10ped => m10q1ped + m10q2ped + aEntero(m10qx);
  int get m11ped => m11q1ped + m11q2ped + aEntero(m11qx);
  int get m12ped => m12q1ped + m12q2ped + aEntero(m12qx);
  int get totalped =>
      m01ped +
      m02ped +
      m03ped +
      m04ped +
      m05ped +
      m06ped +
      m07ped +
      m08ped +
      m09ped +
      m10ped +
      m11ped +
      m12ped;

  Map<String, int> pedidoMapInt() {
    return {
      'm01q1': m01q1ped,
      'm01q2': m01q2ped,
      'm01qx': aEntero(m01qx),
      'm02q1': m02q1ped,
      'm02q2': m02q2ped,
      'm02qx': aEntero(m02qx),
      'm03q1': m03q1ped,
      'm03q2': m03q2ped,
      'm03qx': aEntero(m03qx),
      'm04q1': m04q1ped,
      'm04q2': m04q2ped,
      'm04qx': aEntero(m04qx),
      'm05q1': m05q1ped,
      'm05q2': m05q2ped,
      'm05qx': aEntero(m05qx),
      'm06q1': m06q1ped,
      'm06q2': m06q2ped,
      'm06qx': aEntero(m06qx),
      'm07q1': m07q1ped,
      'm07q2': m07q2ped,
      'm07qx': aEntero(m07qx),
      'm08q1': m08q1ped,
      'm08q2': m08q2ped,
      'm08qx': aEntero(m08qx),
      'm09q1': m09q1ped,
      'm09q2': m09q2ped,
      'm09qx': aEntero(m09qx),
      'm10q1': m10q1ped,
      'm10q2': m10q2ped,
      'm10qx': aEntero(m10qx),
      'm11q1': m11q1ped,
      'm11q2': m11q2ped,
      'm11qx': aEntero(m11qx),
      'm12q1': m12q1ped,
      'm12q2': m12q2ped,
      'm12qx': aEntero(m12qx),
      'total': totalped,
    };
  }

  Map<String, dynamic> get pedidoMapDownload => {
        'item': item,
        'cto': circuito,
        'wbe': wbe,
        'e4e': e4e,
        'descripcion': descripcion,
        'um': um,
        'm01q1': aEntero(m01q1) * aEntero(pedido[0]),
        'm01q2': aEntero(m01q2) * aEntero(pedido[1]),
        'm01qx': aEntero(m01qx),
        'm02q1': aEntero(m02q1) * aEntero(pedido[2]),
        'm02q2': aEntero(m02q2) * aEntero(pedido[3]),
        'm02qx': aEntero(m02qx),
        'm03q1': aEntero(m03q1) * aEntero(pedido[4]),
        'm03q2': aEntero(m03q2) * aEntero(pedido[5]),
        'm03qx': aEntero(m03qx),
        'm04q1': aEntero(m04q1) * aEntero(pedido[6]),
        'm04q2': aEntero(m04q2) * aEntero(pedido[7]),
        'm04qx': aEntero(m04qx),
        'm05q1': aEntero(m05q1) * aEntero(pedido[8]),
        'm05q2': aEntero(m05q2) * aEntero(pedido[9]),
        'm05qx': aEntero(m05qx),
        'm06q1': aEntero(m06q1) * aEntero(pedido[10]),
        'm06q2': aEntero(m06q2) * aEntero(pedido[11]),
        'm06qx': aEntero(m06qx),
        'm07q1': aEntero(m07q1) * aEntero(pedido[12]),
        'm07q2': aEntero(m07q2) * aEntero(pedido[13]),
        'm07qx': aEntero(m07qx),
        'm08q1': aEntero(m08q1) * aEntero(pedido[14]),
        'm08q2': aEntero(m08q2) * aEntero(pedido[15]),
        'm08qx': aEntero(m08qx),
        'm09q1': aEntero(m09q1) * aEntero(pedido[16]),
        'm09q2': aEntero(m09q2) * aEntero(pedido[17]),
        'm09qx': aEntero(m09qx),
        'm10q1': aEntero(m10q1) * aEntero(pedido[18]),
        'm10q2': aEntero(m10q2) * aEntero(pedido[19]),
        'm10qx': aEntero(m10qx),
        'm11q1': aEntero(m11q1) * aEntero(pedido[20]),
        'm11q2': aEntero(m11q2) * aEntero(pedido[21]),
        'm11qx': aEntero(m11qx),
        'm12q1': aEntero(m12q1) * aEntero(pedido[22]),
        'm12q2': aEntero(m12q2) * aEntero(pedido[23]),
        'm12qx': aEntero(m12qx),
        'total': totalped,
      };

  List<PedidosSingle> get pedidosList {
    List<PedidosSingle> result = [];
    for (var i = 0; i < 12; i++) {
      String mes = (i + 1).toString().padLeft(2, '0');
      if (pedidoMapDownload['m${mes}q1'] != 0) {
        result.add(
          PedidosSingle(
            pedido: '$mes|${id.substring(2, 4)}-1',
            id: id,
            e4e: e4e,
            descripcion: descripcion,
            ctdi: pedidoMapDownload['m${mes}q1'].toString(),
            ctdf: pedidoMapDownload['m${mes}q1'].toString(),
            um: um,
            comentario: '$comentario1 - $comentario2',
            solicitante: solicitante,
            tipoenvio: tipo,
            pdi: pdi,
            pdiname: 'pdiname',
            proyecto: proyecto,
            ref: circuito,
            wbe: wbe,
            wbeproyecto: '',
            wbeparte: '',
            wbeestado: '',
            fecha: fechasolicitud,
            estado: estado,
            lastperson: solicitante,
          ),
        );
      }
      if (pedidoMapDownload['m${mes}q2'] != 0) {
        result.add(
          PedidosSingle(
            pedido: '$mes|${id.substring(2, 4)}-2',
            id: id,
            e4e: e4e,
            descripcion: descripcion,
            ctdi: pedidoMapDownload['m${mes}q2'].toString(),
            ctdf: pedidoMapDownload['m${mes}q2'].toString(),
            um: um,
            comentario: '$comentario1 - $comentario2',
            solicitante: solicitante,
            tipoenvio: tipo,
            pdi: pdi,
            pdiname: 'pdiname',
            proyecto: proyecto,
            ref: circuito,
            wbe: wbe,
            wbeproyecto: '',
            wbeparte: '',
            wbeestado: '',
            fecha: fechasolicitud,
            estado: estado,
            lastperson: solicitante,
          ),
        );
      }
      if (pedidoMapDownload['m${mes}qx'] != 0) {
        result.add(
          PedidosSingle(
            pedido: '$mes|${id.substring(2, 4)}-x',
            id: id,
            e4e: e4e,
            descripcion: descripcion,
            ctdi: pedidoMapDownload['m${mes}qx'].toString(),
            ctdf: pedidoMapDownload['m${mes}qx'].toString(),
            um: um,
            comentario: '$comentario1 - $comentario2',
            solicitante: solicitante,
            tipoenvio: tipo,
            pdi: pdi,
            pdiname: 'pdiname',
            proyecto: proyecto,
            ref: circuito,
            wbe: wbe,
            wbeproyecto: '',
            wbeparte: '',
            wbeestado: '',
            fecha: fechasolicitud,
            estado: estado,
            lastperson: solicitante,
          ),
        );
      }
    }
    return result;
  }

  Map<String, String> toMapMonth() {
    return {
      'item': item,
      'cto': circuito,
      'wbe': wbe,
      'e4e': e4e,
      'descripcion': descripcion,
      'um': um,
      'm01': '$m01',
      'm02': '$m02',
      'm03': '$m03',
      'm04': '$m04',
      'm05': '$m05',
      'm06': '$m06',
      'm07': '$m07',
      'm08': '$m08',
      'm09': '$m09',
      'm10': '$m10',
      'm11': '$m11',
      'm12': '$m12',
      'total': '$total',
    };
  }

  Map<String, String> toMapMonthPrecio(int precio) {
    return {
      'item': item,
      'cto': circuito,
      'wbe': wbe,
      'e4e': e4e,
      'descripcion': descripcion,
      'um': um,
      'valorunitario': '$precio',
      'm01': '$m01',
      'm02': '$m02',
      'm03': '$m03',
      'm04': '$m04',
      'm05': '$m05',
      'm06': '$m06',
      'm07': '$m07',
      'm08': '$m08',
      'm09': '$m09',
      'm10': '$m10',
      'm11': '$m11',
      'm12': '$m12',
      'total': '$total',
    };
  }

  Map<String, String> toMapMonthValue(int precio) {
    if (wbe.isNotEmpty) {
      return {
        'item': item,
        'cto': circuito,
        'wbe': wbe,
        'e4e': e4e,
        'descripcion': descripcion,
        'um': um,
        'valorunitario': '$precio',
        'm01': '0',
        'm02': '0',
        'm03': '0',
        'm04': '0',
        'm05': '0',
        'm06': '0',
        'm07': '0',
        'm08': '0',
        'm09': '0',
        'm10': '0',
        'm11': '0',
        'm12': '0',
        'total': '0',
      };
    }
    return {
      'item': item,
      'cto': circuito,
      'wbe': wbe,
      'e4e': e4e,
      'descripcion': descripcion,
      'um': um,
      'valorunitario': '$precio',
      'm01': '${m01 * precio}',
      'm02': '${m02 * precio}',
      'm03': '${m03 * precio}',
      'm04': '${m04 * precio}',
      'm05': '${m05 * precio}',
      'm06': '${m06 * precio}',
      'm07': '${m07 * precio}',
      'm08': '${m08 * precio}',
      'm09': '${m09 * precio}',
      'm10': '${m10 * precio}',
      'm11': '${m11 * precio}',
      'm12': '${m12 * precio}',
      'total': '${total * precio}',
    };
  }

  Map mapToTitles = {
    'id': [1, 'Año'],
    'proyecto': [8, 'Proyecto'],
    'e4e': [1, 'E4e'],
    'descripcion': [6, 'Descripcion'],
    'um': [1, 'Um'],
    'm01': [1, 'm01'],
    'm02': [1, 'm02'],
    'm03': [1, 'm03'],
    'm04': [1, 'm04'],
    'm05': [1, 'm05'],
    'm06': [1, 'm06'],
    'm07': [1, 'm07'],
    'm08': [1, 'm08'],
    'm09': [1, 'm09'],
    'm10': [1, 'm10'],
    'm11': [1, 'm11'],
    'm12': [1, 'm12'],
    'total': [1, 'Total'],
  };

  Map<String, String> toMapMonthProject() {
    return {
      'id': id.substring(0, 4),
      'proyecto': proyecto,
      'e4e': e4e,
      'descripcion': descripcion,
      'um': um,
      'm01': '$m01',
      'm02': '$m02',
      'm03': '$m03',
      'm04': '$m04',
      'm05': '$m05',
      'm06': '$m06',
      'm07': '$m07',
      'm08': '$m08',
      'm09': '$m09',
      'm10': '$m10',
      'm11': '$m11',
      'm12': '$m12',
      'total': '$total',
    };
  }

  Map titles = {
    '_': [9, 'u', Colors.black],
    'V1': [4, '01', Colors.black],
    'V2': [4, '01', Colors.blue[900]],
    'V3': [4, '02', Colors.black],
    // 'V4': [3, '03', Colors.blue[900]],
  };

  Map get asRow {
    return {
      'Cto': [circuito, 1, Colors.black],
      'E4e': [e4e, 1, Colors.black],
      'Descripción': [descripcion, 6, Colors.black],
      'U': [um, 1, Colors.black],
      '01': [
        (int.parse(m01q1.isEmpty ? '0' : m01q1) +
                int.parse(m01q2.isEmpty ? '0' : m01q2) +
                int.parse(m01qx.isEmpty ? '0' : m01qx))
            .toString(),
        1,
        Colors.black
      ],
      '02': [
        (int.parse(m02q1.isEmpty ? '0' : m02q1) +
                int.parse(m02q2.isEmpty ? '0' : m02q2) +
                int.parse(m02qx.isEmpty ? '0' : m02qx))
            .toString(),
        1,
        Colors.black
      ],
      '03': [
        (int.parse(m03q1.isEmpty ? '0' : m03q1) +
                int.parse(m03q2.isEmpty ? '0' : m03q2) +
                int.parse(m03qx.isEmpty ? '0' : m03qx))
            .toString(),
        1,
        Colors.black
      ],
      '04': [
        (int.parse(m04q1.isEmpty ? '0' : m04q1) +
                int.parse(m04q2.isEmpty ? '0' : m04q2) +
                int.parse(m04qx.isEmpty ? '0' : m04qx))
            .toString(),
        1,
        Colors.black
      ],
      '05': [
        (int.parse(m05q1.isEmpty ? '0' : m05q1) +
                int.parse(m05q2.isEmpty ? '0' : m05q2) +
                int.parse(m05qx.isEmpty ? '0' : m05qx))
            .toString(),
        1,
        Colors.blue[900]
      ],
      '06': [
        (int.parse(m06q1.isEmpty ? '0' : m06q1) +
                int.parse(m06q2.isEmpty ? '0' : m06q2) +
                int.parse(m06qx.isEmpty ? '0' : m06qx))
            .toString(),
        1,
        Colors.blue[900]
      ],
      '07': [
        (int.parse(m07q1.isEmpty ? '0' : m07q1) +
                int.parse(m07q2.isEmpty ? '0' : m07q2) +
                int.parse(m07qx.isEmpty ? '0' : m07qx))
            .toString(),
        1,
        Colors.blue[900]
      ],
      '08': [
        (int.parse(m08q1.isEmpty ? '0' : m08q1) +
                int.parse(m08q2.isEmpty ? '0' : m08q2) +
                int.parse(m08qx.isEmpty ? '0' : m08qx))
            .toString(),
        1,
        Colors.blue[900]
      ],
      '09': [
        (int.parse(m09q1.isEmpty ? '0' : m09q1) +
                int.parse(m09q2.isEmpty ? '0' : m09q2) +
                int.parse(m09qx.isEmpty ? '0' : m09qx))
            .toString(),
        1,
        Colors.black
      ],
      '10': [
        (int.parse(m10q1.isEmpty ? '0' : m10q1) +
                int.parse(m10q2.isEmpty ? '0' : m10q2) +
                int.parse(m10qx.isEmpty ? '0' : m10qx))
            .toString(),
        1,
        Colors.black
      ],
      '11': [
        (int.parse(m11q1.isEmpty ? '0' : m11q1) +
                int.parse(m11q2.isEmpty ? '0' : m11q2) +
                int.parse(m11qx.isEmpty ? '0' : m11qx))
            .toString(),
        1,
        Colors.black
      ],
      '12': [
        (int.parse(m12q1.isEmpty ? '0' : m12q1) +
                int.parse(m12q2.isEmpty ? '0' : m12q2) +
                int.parse(m12qx.isEmpty ? '0' : m12qx))
            .toString(),
        1,
        Colors.black
      ],
    };
  }

  Map asRowDespacho({
    required String mes,
    required String q,
  }) {
    // print(mes);
    String ctd;
    if (mes == '01') {
      ctd = q == '1'
          ? m01q1
          : q == '2'
              ? m01q2
              : m01qx;
    } else if (mes == '02') {
      ctd = q == '1'
          ? m02q1
          : q == '2'
              ? m02q2
              : m02qx;
    } else if (mes == '03') {
      ctd = q == '1'
          ? m03q1
          : q == '2'
              ? m03q2
              : m03qx;
    } else if (mes == '04') {
      ctd = q == '1'
          ? m04q1
          : q == '2'
              ? m04q2
              : m04qx;
    } else if (mes == '05') {
      ctd = q == '1'
          ? m05q1
          : q == '2'
              ? m05q2
              : m05qx;
    } else if (mes == '06') {
      ctd = q == '1'
          ? m06q1
          : q == '2'
              ? m06q2
              : m06qx;
    } else if (mes == '07') {
      ctd = q == '1'
          ? m07q1
          : q == '2'
              ? m07q2
              : m07qx;
    } else if (mes == '08') {
      ctd = q == '1'
          ? m08q1
          : q == '2'
              ? m08q2
              : m08qx;
    } else if (mes == '09') {
      ctd = q == '1'
          ? m09q1
          : q == '2'
              ? m09q2
              : m09qx;
    } else if (mes == '10') {
      ctd = q == '1'
          ? m10q1
          : q == '2'
              ? m10q2
              : m10qx;
    } else if (mes == '11') {
      // print('mes 11');
      // print(q);
      ctd = q == '1'
          ? m11q1
          : q == '2'
              ? m11q2
              : m11qx;
    } else {
      ctd = q == '1'
          ? m12q1
          : q == '2'
              ? m12q2
              : m12qx;
    }
    // (int.parse(m01q1.isEmpty ? '0' : m01q1)).toString()
    return {
      'Cto': [circuito, 1],
      'E4e': [e4e, 1],
      'Descripción': [descripcion, 6],
      'U': [um, 1],
      'Q': [ctd, 1],
      // 'Q2': [(int.parse(m01q1.isEmpty ? '0' : m01q1) ).toString(),1],
      // 'EXTRA': [(int.parse(m01qx.isEmpty ? '0' : m01qx)).toString(),1],
      'PDI': [pdi, 1],
      'WBE': [wbe, 1],
      'Causar?': [proyectowbe, 1],
      'Comentario': [comentario2, 4],
      'Tipo': [tipo, 1],
      'A': [estdespacho, 1],
    };
  }

  Map asRowDespacho2({required String pedidoSeleccionado}) {
    String mes = pedidoSeleccionado.substring(0, 2);
    String q = pedidoSeleccionado.substring(6);
    // print(mes);
    String ctd;
    if (mes == '01') {
      ctd = q == '1'
          ? m01q1
          : q == '2'
              ? m01q2
              : m01qx;
    } else if (mes == '02') {
      ctd = q == '1'
          ? m02q1
          : q == '2'
              ? m02q2
              : m02qx;
    } else if (mes == '03') {
      ctd = q == '1'
          ? m03q1
          : q == '2'
              ? m03q2
              : m03qx;
    } else if (mes == '04') {
      ctd = q == '1'
          ? m04q1
          : q == '2'
              ? m04q2
              : m04qx;
    } else if (mes == '05') {
      ctd = q == '1'
          ? m05q1
          : q == '2'
              ? m05q2
              : m05qx;
    } else if (mes == '06') {
      ctd = q == '1'
          ? m06q1
          : q == '2'
              ? m06q2
              : m06qx;
    } else if (mes == '07') {
      ctd = q == '1'
          ? m07q1
          : q == '2'
              ? m07q2
              : m07qx;
    } else if (mes == '08') {
      ctd = q == '1'
          ? m08q1
          : q == '2'
              ? m08q2
              : m08qx;
    } else if (mes == '09') {
      ctd = q == '1'
          ? m09q1
          : q == '2'
              ? m09q2
              : m09qx;
    } else if (mes == '10') {
      ctd = q == '1'
          ? m10q1
          : q == '2'
              ? m10q2
              : m10qx;
    } else if (mes == '11') {
      // print('mes 11');
      // print(q);
      ctd = q == '1'
          ? m11q1
          : q == '2'
              ? m11q2
              : m11qx;
    } else {
      ctd = q == '1'
          ? m12q1
          : q == '2'
              ? m12q2
              : m12qx;
    }
    // (int.parse(m01q1.isEmpty ? '0' : m01q1)).toString()
    return {
      'Cto': [circuito, 1],
      'E4e': [e4e, 1],
      'Descripción': [descripcion, 6],
      'U': [um, 1],
      'Q': [ctd, 1],
      // 'Q2': [(int.parse(m01q1.isEmpty ? '0' : m01q1) ).toString(),1],
      // 'EXTRA': [(int.parse(m01qx.isEmpty ? '0' : m01qx)).toString(),1],
      'PDI': [pdi, 1],
      'WBE': [wbe, 1],
      'Causar?': [proyectowbe, 1],
      'Comentario': [comentario2, 4],
      'Tipo': [tipo, 1],
      'A': [estdespacho, 1],
    };
  }

  getVersion(String version) {
    int value = 0;
    switch (version) {
      case 'V1':
        value = int.parse(m01q1.isEmpty ? '0' : m01q1) +
            int.parse(m01q2.isEmpty ? '0' : m01q2) +
            int.parse(m01qx.isEmpty ? '0' : m01qx) +
            int.parse(m02q1.isEmpty ? '0' : m02q1) +
            int.parse(m02q2.isEmpty ? '0' : m02q2) +
            int.parse(m02qx.isEmpty ? '0' : m02qx) +
            int.parse(m03q1.isEmpty ? '0' : m03q1) +
            int.parse(m03q2.isEmpty ? '0' : m03q2) +
            int.parse(m03qx.isEmpty ? '0' : m03qx);
        break;
      case 'V2':
        value = int.parse(m04q1.isEmpty ? '0' : m04q1) +
            int.parse(m04q2.isEmpty ? '0' : m04q2) +
            int.parse(m04qx.isEmpty ? '0' : m04qx) +
            int.parse(m05q1.isEmpty ? '0' : m05q1) +
            int.parse(m05q2.isEmpty ? '0' : m05q2) +
            int.parse(m05qx.isEmpty ? '0' : m05qx) +
            int.parse(m06q1.isEmpty ? '0' : m06q1) +
            int.parse(m06q2.isEmpty ? '0' : m06q2) +
            int.parse(m06qx.isEmpty ? '0' : m06qx);
        break;
      case 'V3':
        value = int.parse(m07q1.isEmpty ? '0' : m07q1) +
            int.parse(m07q2.isEmpty ? '0' : m07q2) +
            int.parse(m07qx.isEmpty ? '0' : m07qx) +
            int.parse(m08q1.isEmpty ? '0' : m08q1) +
            int.parse(m08q2.isEmpty ? '0' : m08q2) +
            int.parse(m08qx.isEmpty ? '0' : m08qx) +
            int.parse(m09q1.isEmpty ? '0' : m09q1) +
            int.parse(m09q2.isEmpty ? '0' : m09q2) +
            int.parse(m09qx.isEmpty ? '0' : m09qx);
        break;
      case 'V4':
        value = int.parse(m10q1.isEmpty ? '0' : m10q1) +
            int.parse(m10q2.isEmpty ? '0' : m10q2) +
            int.parse(m10qx.isEmpty ? '0' : m10qx) +
            int.parse(m11q1.isEmpty ? '0' : m11q1) +
            int.parse(m11q2.isEmpty ? '0' : m11q2) +
            int.parse(m11qx.isEmpty ? '0' : m11qx) +
            int.parse(m12q1.isEmpty ? '0' : m12q1) +
            int.parse(m12q2.isEmpty ? '0' : m12q2) +
            int.parse(m12qx.isEmpty ? '0' : m12qx);
        break;
      default:
    }
    return {
      'e4e': e4e,
      'ctd': value,
    };
  }

  Map<String, dynamic> toMap() {
    return {
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
      'ProyectoWBE': proyectowbe,
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

  Map<String, dynamic> toMapInt() {
    return {
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
      'm01q1': aEnteroCero(m01q1),
      'm01q2': aEnteroCero(m01q2),
      'm01qx': aEnteroCero(m01qx),
      'm02q1': aEnteroCero(m02q1),
      'm02q2': aEnteroCero(m02q2),
      'm02qx': aEnteroCero(m02qx),
      'm03q1': aEnteroCero(m03q1),
      'm03q2': aEnteroCero(m03q2),
      'm03qx': aEnteroCero(m03qx),
      'm04q1': aEnteroCero(m04q1),
      'm04q2': aEnteroCero(m04q2),
      'm04qx': aEnteroCero(m04qx),
      'm05q1': aEnteroCero(m05q1),
      'm05q2': aEnteroCero(m05q2),
      'm05qx': aEnteroCero(m05qx),
      'm06q1': aEnteroCero(m06q1),
      'm06q2': aEnteroCero(m06q2),
      'm06qx': aEnteroCero(m06qx),
      'm07q1': aEnteroCero(m07q1),
      'm07q2': aEnteroCero(m07q2),
      'm07qx': aEnteroCero(m07qx),
      'm08q1': aEnteroCero(m08q1),
      'm08q2': aEnteroCero(m08q2),
      'm08qx': aEnteroCero(m08qx),
      'm09q1': aEnteroCero(m09q1),
      'm09q2': aEnteroCero(m09q2),
      'm09qx': aEnteroCero(m09qx),
      'm10q1': aEnteroCero(m10q1),
      'm10q2': aEnteroCero(m10q2),
      'm10qx': aEnteroCero(m10qx),
      'm11q1': aEnteroCero(m11q1),
      'm11q2': aEnteroCero(m11q2),
      'm11qx': aEnteroCero(m11qx),
      'm12q1': aEnteroCero(m12q1),
      'm12q2': aEnteroCero(m12q2),
      'm12qx': aEnteroCero(m12qx),
    };
  }

  int aEnteroCero(String n) {
    if (n.isEmpty) {
      return 0;
    } else {
      return int.parse(n) < 0 ? 0 : int.parse(n);
    }
  }

  factory SingleFEM.fromList(List<dynamic> ls) {
    return SingleFEM(
      id: ls[0].toString(),
      estado: ls[1].toString(),
      estdespacho: ls[2].toString(),
      tipo: ls[3].toString(),
      fechainicial: ls[4].toString().length > 10
          ? ls[4].toString().substring(0, 10)
          : ls[4].toString(),
      fechacambio: ls[5].toString().length > 10
          ? ls[5].toString().substring(0, 10)
          : ls[5].toString(),
      fechasolicitud: ls[6].toString().length > 10
          ? ls[6].toString().substring(0, 10)
          : ls[6].toString(),
      unidad: ls[7].toString(),
      codigo: ls[8].toString(),
      proyecto: ls[9].toString(),
      circuito: ls[10].toString(),
      pm: ls[11].toString(),
      solicitante: ls[12].toString(),
      pdi: ls[13].toString(),
      wbe: ls[14].toString(),
      proyectowbe: ls[15].toString(),
      comentario1: ls[16]
          .toString()
          .replaceAll('"', '')
          .replaceAll(';', '')
          .replaceAll(',', '')
          .replaceAll("\n", " "),
      comentario2: ls[17]
          .toString()
          .replaceAll('"', '')
          .replaceAll(';', '')
          .replaceAll(',', '')
          .replaceAll("\n", " "),
      e4e: ls[18].toString(),
      descripcion: ls[19]
          .toString()
          .replaceAll('"', '')
          .replaceAll(';', '')
          .replaceAll(',', ''),
      um: ls[20].toString(),
      m01q1: ls[21].toString(),
      m01q2: ls[22].toString(),
      m01qx: ls[23].toString(),
      m02q1: ls[24].toString(),
      m02q2: ls[25].toString(),
      m02qx: ls[26].toString(),
      m03q1: ls[27].toString(),
      m03q2: ls[28].toString(),
      m03qx: ls[29].toString(),
      m04q1: ls[30].toString(),
      m04q2: ls[31].toString(),
      m04qx: ls[32].toString(),
      m05q1: ls[33].toString(),
      m05q2: ls[34].toString(),
      m05qx: ls[35].toString(),
      m06q1: ls[36].toString(),
      m06q2: ls[37].toString(),
      m06qx: ls[38].toString(),
      m07q1: ls[39].toString(),
      m07q2: ls[40].toString(),
      m07qx: ls[41].toString(),
      m08q1: ls[42].toString(),
      m08q2: ls[43].toString(),
      m08qx: ls[44].toString(),
      m09q1: ls[45].toString(),
      m09q2: ls[46].toString(),
      m09qx: ls[47].toString(),
      m10q1: ls[48].toString(),
      m10q2: ls[49].toString(),
      m10qx: ls[50].toString(),
      m11q1: ls[51].toString(),
      m11q2: ls[52].toString(),
      m11qx: ls[53].toString(),
      m12q1: ls[54].toString(),
      m12q2: ls[55].toString(),
      m12qx: ls[56].toString(),
    );
  }

  factory SingleFEM.fromListToMonth(List<dynamic> ls) {
    List<int> meses = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    Map totalMes = {};
    totalMes['total'] = 0;
    for (int i = 0; i < meses.length; i++) {
      int j = i * 3;
      int mes = meses[i];
      totalMes[mes.toString()] = int.parse(
              ls[21 + j].toString().isEmpty ? '0' : ls[21 + j].toString()) +
          int.parse(
              ls[22 + j].toString().isEmpty ? '0' : ls[22 + j].toString()) +
          int.parse(
              ls[23 + j].toString().isEmpty ? '0' : ls[23 + j].toString());
      totalMes['total'] = totalMes['total'] + totalMes[mes.toString()];
    }
    return SingleFEM(
      id: ls[0].toString(),
      estado: ls[1].toString(),
      estdespacho: ls[2].toString(),
      tipo: ls[3].toString(),
      fechainicial: ls[4].toString().length > 10
          ? ls[4].toString().substring(0, 10)
          : ls[4].toString(),
      fechacambio: ls[5].toString().length > 10
          ? ls[5].toString().substring(0, 10)
          : ls[5].toString(),
      fechasolicitud: ls[6].toString().length > 10
          ? ls[6].toString().substring(0, 10)
          : ls[6].toString(),
      unidad: ls[7].toString(),
      codigo: ls[8].toString(),
      proyecto: ls[9].toString(),
      circuito: ls[10].toString(),
      pm: ls[11].toString(),
      solicitante: ls[12].toString(),
      pdi: ls[13].toString(),
      wbe: ls[14].toString(),
      proyectowbe: ls[15].toString(),
      comentario1: ls[16]
          .toString()
          .replaceAll('"', '')
          .replaceAll(';', '')
          .replaceAll(',', '')
          .replaceAll("\n", " "),
      comentario2: ls[17]
          .toString()
          .replaceAll('"', '')
          .replaceAll(';', '')
          .replaceAll(',', '')
          .replaceAll("\n", " "),
      e4e: ls[18].toString(),
      descripcion: ls[19]
          .toString()
          .replaceAll('"', '')
          .replaceAll(';', '')
          .replaceAll(',', ''),
      um: ls[20].toString(),
      m01q1: totalMes['1'].toString(),
      m01q2: ls[22].toString(),
      m01qx: ls[23].toString(),
      m02q1: totalMes['2'].toString(),
      m02q2: ls[25].toString(),
      m02qx: ls[26].toString(),
      m03q1: totalMes['3'].toString(),
      m03q2: ls[28].toString(),
      m03qx: ls[29].toString(),
      m04q1: totalMes['4'].toString(),
      m04q2: ls[31].toString(),
      m04qx: ls[32].toString(),
      m05q1: totalMes['5'].toString(),
      m05q2: ls[34].toString(),
      m05qx: ls[35].toString(),
      m06q1: totalMes['6'].toString(),
      m06q2: ls[37].toString(),
      m06qx: ls[38].toString(),
      m07q1: totalMes['7'].toString(),
      m07q2: ls[40].toString(),
      m07qx: ls[41].toString(),
      m08q1: totalMes['8'].toString(),
      m08q2: ls[43].toString(),
      m08qx: ls[44].toString(),
      m09q1: totalMes['9'].toString(),
      m09q2: ls[46].toString(),
      m09qx: ls[47].toString(),
      m10q1: totalMes['10'].toString(),
      m10q2: ls[49].toString(),
      m10qx: ls[50].toString(),
      m11q1: totalMes['11'].toString(),
      m11q2: ls[52].toString(),
      m11qx: ls[53].toString(),
      m12q1: totalMes['12'].toString(),
      m12q2: ls[55].toString(),
      m12qx: totalMes['total'].toString(),
    );
  }

  factory SingleFEM.fromMap(Map<String, dynamic> map) {
    return SingleFEM(
      id: map['id'].toString(),
      estado: map['estado'].toString(),
      estdespacho: map['estdespacho'].toString(),
      tipo: map['tipo'].toString(),
      fechainicial: map['fechainicial'].toString(),
      fechacambio: map['fechacambio'].toString(),
      fechasolicitud: map['fechasolicitud'].toString(),
      unidad: map['unidad'].toString(),
      codigo: map['codigo'].toString(),
      proyecto: map['proyecto'].toString(),
      circuito: map['circuito'].toString(),
      pm: map['pm'].toString(),
      solicitante: map['solicitante'].toString(),
      pdi: map['pdi'].toString(),
      wbe: map['wbe'].toString(),
      proyectowbe: map['proyectowbe'].toString(),
      comentario1: map['comentario1'].toString(),
      comentario2: map['comentario2'].toString(),
      e4e: map['e4e'].toString(),
      descripcion: map['descripcion'].toString(),
      um: map['um'].toString(),
      m01q1: map['m01q1'].toString(),
      m01q2: map['m01q2'].toString(),
      m01qx: map['m01qx'].toString(),
      m02q1: map['m02q1'].toString(),
      m02q2: map['m02q2'].toString(),
      m02qx: map['m02qx'].toString(),
      m03q1: map['m03q1'].toString(),
      m03q2: map['m03q2'].toString(),
      m03qx: map['m03qx'].toString(),
      m04q1: map['m04q1'].toString(),
      m04q2: map['m04q2'].toString(),
      m04qx: map['m04qx'].toString(),
      m05q1: map['m05q1'].toString(),
      m05q2: map['m05q2'].toString(),
      m05qx: map['m05qx'].toString(),
      m06q1: map['m06q1'].toString(),
      m06q2: map['m06q2'].toString(),
      m06qx: map['m06qx'].toString(),
      m07q1: map['m07q1'].toString(),
      m07q2: map['m07q2'].toString(),
      m07qx: map['m07qx'].toString(),
      m08q1: map['m08q1'].toString(),
      m08q2: map['m08q2'].toString(),
      m08qx: map['m08qx'].toString(),
      m09q1: map['m09q1'].toString(),
      m09q2: map['m09q2'].toString(),
      m09qx: map['m09qx'].toString(),
      m10q1: map['m10q1'].toString(),
      m10q2: map['m10q2'].toString(),
      m10qx: map['m10qx'].toString(),
      m11q1: map['m11q1'].toString(),
      m11q2: map['m11q2'].toString(),
      m11qx: map['m11qx'].toString(),
      m12q1: map['m12q1'].toString(),
      m12q2: map['m12q2'].toString(),
      m12qx: map['m12qx'].toString(),
    );
  }

  factory SingleFEM.fromFemByProy(Map<String, dynamic> map) {
    return SingleFEM(
      id: '',
      estado: '',
      estdespacho: '',
      tipo: '',
      fechainicial: '',
      fechacambio: '',
      fechasolicitud: '',
      unidad: '',
      codigo: '',
      proyecto: map['proyecto'].toString(),
      circuito: '',
      pm: '',
      solicitante: '',
      pdi: '',
      wbe: '',
      proyectowbe: '',
      comentario1: '',
      comentario2: '',
      e4e: map['e4e'].toString(),
      descripcion: map['descripcion'].toString(),
      um: map['um'].toString(),
      m01q1: '',
      m01q2: map['01'].toString(),
      m01qx: '',
      m02q1: '',
      m02q2: map['02'].toString(),
      m02qx: '',
      m03q1: '',
      m03q2: map['03'].toString(),
      m03qx: '',
      m04q1: '',
      m04q2: map['04'].toString(),
      m04qx: '',
      m05q1: '',
      m05q2: map['05'].toString(),
      m05qx: '',
      m06q1: '',
      m06q2: map['06'].toString(),
      m06qx: '',
      m07q1: '',
      m07q2: map['07'].toString(),
      m07qx: '',
      m08q1: '',
      m08q2: map['08'].toString(),
      m08qx: '',
      m09q1: '',
      m09q2: map['09'].toString(),
      m09qx: '',
      m10q1: '',
      m10q2: map['10'].toString(),
      m10qx: '',
      m11q1: '',
      m11q2: map['11'].toString(),
      m11qx: '',
      m12q1: '',
      m12q2: map['12'].toString(),
      m12qx: '',
    );
  }

  factory SingleFEM.notFound() {
    return SingleFEM(
      id: '0',
      estado: '0',
      estdespacho: '0',
      tipo: '0',
      fechainicial: '0',
      fechacambio: '0',
      fechasolicitud: '0',
      unidad: '0',
      codigo: '0',
      proyecto: 'NotFound',
      circuito: '0',
      pm: '0',
      solicitante: '0',
      pdi: '0',
      wbe: '0',
      proyectowbe: '0',
      comentario1: '0',
      comentario2: '0',
      e4e: '0',
      descripcion: '0',
      um: '0',
      m01q1: '0',
      m01q2: '0',
      m01qx: '0',
      m02q1: '0',
      m02q2: '0',
      m02qx: '0',
      m03q1: '0',
      m03q2: '0',
      m03qx: '0',
      m04q1: '0',
      m04q2: '0',
      m04qx: '0',
      m05q1: '0',
      m05q2: '0',
      m05qx: '0',
      m06q1: '0',
      m06q2: '0',
      m06qx: '0',
      m07q1: '0',
      m07q2: '0',
      m07qx: '0',
      m08q1: '0',
      m08q2: '0',
      m08qx: '0',
      m09q1: '0',
      m09q2: '0',
      m09qx: '0',
      m10q1: '0',
      m10q2: '0',
      m10qx: '0',
      m11q1: '0',
      m11q2: '0',
      m11qx: '0',
      m12q1: '0',
      m12q2: '0',
      m12qx: '0',
    );
  }

  factory SingleFEM.fromInit(int index) {
    return SingleFEM(
      id: index.toString(),
      estado: '',
      estdespacho: '',
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
    )
      ..item = index.toString().padLeft(2, '0')
      ..e4eColor = Colors.red
      // ..pdiColor = Colors.red
      ;
  }

  String toJson() => json.encode(toMap());

  factory SingleFEM.fromJson(String source) =>
      SingleFEM.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SingleFEM(id: $id, estado: $estado, estdespacho: $estdespacho, tipo: $tipo, fechainicial: $fechainicial, fechacambio: $fechacambio, fechasolicitud: $fechasolicitud, unidad: $unidad, codigo: $codigo, proyecto: $proyecto, circuito: $circuito, pm: $pm, solicitante: $solicitante, pdi: $pdi, wbe: $wbe, proyectowbe: $proyectowbe, comentario1: $comentario1, comentario2: $comentario2, e4e: $e4e, descripcion: $descripcion, um: $um, m01q1: $m01q1, m01q2: $m01q2, m01qx: $m01qx, m02q1: $m02q1, m02q2: $m02q2, m02qx: $m02qx, m03q1: $m03q1, m03q2: $m03q2, m03qx: $m03qx, m04q1: $m04q1, m04q2: $m04q2, m04qx: $m04qx, m05q1: $m05q1, m05q2: $m05q2, m05qx: $m05qx, m06q1: $m06q1, m06q2: $m06q2, m06qx: $m06qx, m07q1: $m07q1, m07q2: $m07q2, m07qx: $m07qx, m08q1: $m08q1, m08q2: $m08q2, m08qx: $m08qx, m09q1: $m09q1, m09q2: $m09q2, m09qx: $m09qx, m10q1: $m10q1, m10q2: $m10q2, m10qx: $m10qx, m11q1: $m11q1, m11q2: $m11q2, m11qx: $m11qx, m12q1: $m12q1, m12q2: $m12q2, m12qx: $m12qx)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SingleFEM &&
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
}
