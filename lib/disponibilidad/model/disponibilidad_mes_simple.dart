import 'dart:convert';

import 'package:flutter/widgets.dart';

class DisponibilidadMesSimple {
  String e4e;
  String descripcion;
  String um;
  int? m01;
  int? m02;
  int? m03;
  int? m04;
  int? m05;
  int? m06;
  int? m07;
  int? m08;
  int? m09;
  int? m10;
  int? m11;
  int? m12;
  DisponibilidadMesSimple({
    required this.e4e,
    required this.descripcion,
    required this.um,
    this.m01,
    this.m02,
    this.m03,
    this.m04,
    this.m05,
    this.m06,
    this.m07,
    this.m08,
    this.m09,
    this.m10,
    this.m11,
    this.m12,
  });

  DisponibilidadMesSimple copyWith({
    String? e4e,
    String? descripcion,
    String? um,
    ValueGetter<int?>? m01,
    ValueGetter<int?>? m02,
    ValueGetter<int?>? m03,
    ValueGetter<int?>? m04,
    ValueGetter<int?>? m05,
    ValueGetter<int?>? m06,
    ValueGetter<int?>? m07,
    ValueGetter<int?>? m08,
    ValueGetter<int?>? m09,
    ValueGetter<int?>? m10,
    ValueGetter<int?>? m11,
    ValueGetter<int?>? m12,
  }) {
    return DisponibilidadMesSimple(
      e4e: e4e ?? this.e4e,
      descripcion: descripcion ?? this.descripcion,
      um: um ?? this.um,
      m01: m01?.call() ?? this.m01,
      m02: m02?.call() ?? this.m02,
      m03: m03?.call() ?? this.m03,
      m04: m04?.call() ?? this.m04,
      m05: m05?.call() ?? this.m05,
      m06: m06?.call() ?? this.m06,
      m07: m07?.call() ?? this.m07,
      m08: m08?.call() ?? this.m08,
      m09: m09?.call() ?? this.m09,
      m10: m10?.call() ?? this.m10,
      m11: m11?.call() ?? this.m11,
      m12: m12?.call() ?? this.m12,
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
    };
  }

  factory DisponibilidadMesSimple.fromMap(Map<String, dynamic> map) {
    return DisponibilidadMesSimple(
      e4e: map['e4e'] ?? '',
      descripcion: map['descripcion'] ?? '',
      um: map['um'] ?? '',
      m01: map['m01']?.toInt(),
      m02: map['m02']?.toInt(),
      m03: map['m03']?.toInt(),
      m04: map['m04']?.toInt(),
      m05: map['m05']?.toInt(),
      m06: map['m06']?.toInt(),
      m07: map['m07']?.toInt(),
      m08: map['m08']?.toInt(),
      m09: map['m09']?.toInt(),
      m10: map['m10']?.toInt(),
      m11: map['m11']?.toInt(),
      m12: map['m12']?.toInt(),
    );
  }

  factory DisponibilidadMesSimple.fromInit() {
    return DisponibilidadMesSimple(
      e4e: '',
      descripcion: '',
      um: '',
      m01: 0,
      m02: 0,
      m03: 0,
      m04: 0,
      m05: 0,
      m06: 0,
      m07: 0,
      m08: 0,
      m09: 0,
      m10: 0,
      m11: 0,
      m12: 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DisponibilidadMesSimple.fromJson(String source) => DisponibilidadMesSimple.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisponibilidadMesSimple(e4e: $e4e, descripcion: $descripcion, um: $um, m01: $m01, m02: $m02, m03: $m03, m04: $m04, m05: $m05, m06: $m06, m07: $m07, m08: $m08, m09: $m09, m10: $m10, m11: $m11, m12: $m12)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DisponibilidadMesSimple &&
      other.e4e == e4e &&
      other.descripcion == descripcion &&
      other.um == um &&
      other.m01 == m01 &&
      other.m02 == m02 &&
      other.m03 == m03 &&
      other.m04 == m04 &&
      other.m05 == m05 &&
      other.m06 == m06 &&
      other.m07 == m07 &&
      other.m08 == m08 &&
      other.m09 == m09 &&
      other.m10 == m10 &&
      other.m11 == m11 &&
      other.m12 == m12;
  }

  @override
  int get hashCode {
    return e4e.hashCode ^
      descripcion.hashCode ^
      um.hashCode ^
      m01.hashCode ^
      m02.hashCode ^
      m03.hashCode ^
      m04.hashCode ^
      m05.hashCode ^
      m06.hashCode ^
      m07.hashCode ^
      m08.hashCode ^
      m09.hashCode ^
      m10.hashCode ^
      m11.hashCode ^
      m12.hashCode;
  }

  String mes(String mesString){
    if(mesString == '01') return (m01??0).toString();
    if(mesString == '02') return (m02??0).toString();
    if(mesString == '03') return (m03??0).toString();
    if(mesString == '04') return (m04??0).toString();
    if(mesString == '05') return (m05??0).toString();
    if(mesString == '06') return (m06??0).toString();
    if(mesString == '07') return (m07??0).toString();
    if(mesString == '08') return (m08??0).toString();
    if(mesString == '09') return (m09??0).toString();
    if(mesString == '10') return (m10??0).toString();
    if(mesString == '11') return (m11??0).toString();
    if(mesString == '12') return (m12??0).toString();
    return '0';
  }
}
