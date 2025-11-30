import 'dart:convert';

import '../../nuevo/model/nuevo_model.dart';

class VersionSumSingle {
  String e4e;
  String unidad;
  int m01;
  int m02;
  int m03;
  int m04;
  int m05;
  int m06;
  int m07;
  int m08;
  int m09;
  int m10;
  int m11;
  int m12;
  int total;
  VersionSumSingle({
    required this.e4e,
    required this.unidad,
    required this.m01,
    required this.m02,
    required this.m03,
    required this.m04,
    required this.m05,
    required this.m06,
    required this.m07,
    required this.m08,
    required this.m09,
    required this.m10,
    required this.m11,
    required this.m12,
    required this.total,
  });

  List<int> get spots {
    return [
      m01,
      m02,
      m03,
      m04,
      m05,
      m06,
      m07,
      m08,
      m09,
      m10,
      m11,
      m12,
      m01 + m02 + m03 + m04 + m05 + m06 + m07 + m08 + m09 + m10 + m11 + m12,
    ];
  }

  List<int> filtradoFechasFem({
    required Map<int, EnableDateInt> enableDatesInt,
  }) {
    List<int> meses = [];
    for (int i = 1; i <= 12; i++) {
      int q = 0;
      if (!enableDatesInt[i]!.entredoQ2) {
        q = campo(i);
      }
      meses.add(q);
    }
    meses.add(meses.fold(0, (p, a) => p + a));
    return meses;
  }

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
    return m12;
  }

  VersionSumSingle copyWith({
    String? e4e,
    String? unidad,
    int? m01,
    int? m02,
    int? m03,
    int? m04,
    int? m05,
    int? m06,
    int? m07,
    int? m08,
    int? m09,
    int? m10,
    int? m11,
    int? m12,
    int? total,
  }) {
    return VersionSumSingle(
      e4e: e4e ?? this.e4e,
      unidad: unidad ?? this.unidad,
      m01: m01 ?? this.m01,
      m02: m02 ?? this.m02,
      m03: m03 ?? this.m03,
      m04: m04 ?? this.m04,
      m05: m05 ?? this.m05,
      m06: m06 ?? this.m06,
      m07: m07 ?? this.m07,
      m08: m08 ?? this.m08,
      m09: m09 ?? this.m09,
      m10: m10 ?? this.m10,
      m11: m11 ?? this.m11,
      m12: m12 ?? this.m12,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'e4e': e4e,
      'unidad': unidad,
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
  }

  factory VersionSumSingle.fromMap(Map<String, dynamic> map) {
    return VersionSumSingle(
      e4e: map['e4e'] ?? '',
      unidad: map['unidad'] ?? '',
      m01: map['m01']?.toInt() ?? 0,
      m02: map['m02']?.toInt() ?? 0,
      m03: map['m03']?.toInt() ?? 0,
      m04: map['m04']?.toInt() ?? 0,
      m05: map['m05']?.toInt() ?? 0,
      m06: map['m06']?.toInt() ?? 0,
      m07: map['m07']?.toInt() ?? 0,
      m08: map['m08']?.toInt() ?? 0,
      m09: map['m09']?.toInt() ?? 0,
      m10: map['m10']?.toInt() ?? 0,
      m11: map['m11']?.toInt() ?? 0,
      m12: map['m12']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
    );
  }

  factory VersionSumSingle.zero() {
    return VersionSumSingle(
      e4e: '',
      unidad: '',
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
      total: 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VersionSumSingle.fromJson(String source) =>
      VersionSumSingle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VersionSumSingle(e4e: $e4e, unidad: $unidad, m01: $m01, m02: $m02, m03: $m03, m04: $m04, m05: $m05, m06: $m06, m07: $m07, m08: $m08, m09: $m09, m10: $m10, m11: $m11, m12: $m12, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VersionSumSingle &&
        other.e4e == e4e &&
        other.unidad == unidad &&
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
        other.m12 == m12 &&
        other.total == total;
  }

  @override
  int get hashCode {
    return e4e.hashCode ^
        unidad.hashCode ^
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
        m12.hashCode ^
        total.hashCode;
  }
}
