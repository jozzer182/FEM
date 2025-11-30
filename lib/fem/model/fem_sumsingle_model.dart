import 'dart:convert';

import '../../nuevo/model/nuevo_model.dart';
import '../../resources/a_entero_2.dart';

class FemSumSingle {
  String e4e;
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
  int m01q1ped;
  int m01q2ped;
  int m02q1ped;
  int m02q2ped;
  int m03q1ped;
  int m03q2ped;
  int m04q1ped;
  int m04q2ped;
  int m05q1ped;
  int m05q2ped;
  int m06q1ped;
  int m06q2ped;
  int m07q1ped;
  int m07q2ped;
  int m08q1ped;
  int m08q2ped;
  int m09q1ped;
  int m09q2ped;
  int m10q1ped;
  int m10q2ped;
  int m11q1ped;
  int m11q2ped;
  int m12q1ped;
  int m12q2ped;
  FemSumSingle({
    required this.e4e,
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
    required this.m01q1ped,
    required this.m01q2ped,
    required this.m02q1ped,
    required this.m02q2ped,
    required this.m03q1ped,
    required this.m03q2ped,
    required this.m04q1ped,
    required this.m04q2ped,
    required this.m05q1ped,
    required this.m05q2ped,
    required this.m06q1ped,
    required this.m06q2ped,
    required this.m07q1ped,
    required this.m07q2ped,
    required this.m08q1ped,
    required this.m08q2ped,
    required this.m09q1ped,
    required this.m09q2ped,
    required this.m10q1ped,
    required this.m10q2ped,
    required this.m11q1ped,
    required this.m11q2ped,
    required this.m12q1ped,
    required this.m12q2ped,
  });

  int get m01 => aEntero(m01q1) + aEntero(m01q2);
  int get m02 => aEntero(m02q1) + aEntero(m02q2);
  int get m03 => aEntero(m03q1) + aEntero(m03q2);
  int get m04 => aEntero(m04q1) + aEntero(m04q2);
  int get m05 => aEntero(m05q1) + aEntero(m05q2);
  int get m06 => aEntero(m06q1) + aEntero(m06q2);
  int get m07 => aEntero(m07q1) + aEntero(m07q2);
  int get m08 => aEntero(m08q1) + aEntero(m08q2);
  int get m09 => aEntero(m09q1) + aEntero(m09q2);
  int get m10 => aEntero(m10q1) + aEntero(m10q2);
  int get m11 => aEntero(m11q1) + aEntero(m11q2);
  int get m12 => aEntero(m12q1) + aEntero(m12q2);

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
    if (abiertoQ1) return campo(n); // planificado q1 + planificacion q2
    if (abiertoQ2 && !abiertoQ1) {
      return campo(n * 100 + 1); // pedido q1 + planificacion q2 + ex
    }
    if (!abiertoQ2 && !abiertoQ1) {
      return campo(n * 100 + 4); //pedido q1 + pedido q2 + ex
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

  bool isNotEmptyBetween(int n1, int n2) {
    for (int i = n1; i <= n2; i++) {
      if (campo(i) != 0) return true;
    }
    return false;
  }

  // FemSumSingle copyWith({
  //   String? e4e,
  //   String? m01q1,
  //   String? m01q2,
  //   String? m02q1,
  //   String? m02q2,
  //   String? m03q1,
  //   String? m03q2,
  //   String? m04q1,
  //   String? m04q2,
  //   String? m05q1,
  //   String? m05q2,
  //   String? m06q1,
  //   String? m06q2,
  //   String? m07q1,
  //   String? m07q2,
  //   String? m08q1,
  //   String? m08q2,
  //   String? m09q1,
  //   String? m09q2,
  //   String? m10q1,
  //   String? m10q2,
  //   String? m11q1,
  //   String? m11q2,
  //   String? m12q1,
  //   String? m12q2,
  // }) {
  //   return FemSumSingle(
  //     e4e: e4e ?? this.e4e,
  //     m01q1: m01q1 ?? this.m01q1,
  //     m01q2: m01q2 ?? this.m01q2,
  //     m02q1: m02q1 ?? this.m02q1,
  //     m02q2: m02q2 ?? this.m02q2,
  //     m03q1: m03q1 ?? this.m03q1,
  //     m03q2: m03q2 ?? this.m03q2,
  //     m04q1: m04q1 ?? this.m04q1,
  //     m04q2: m04q2 ?? this.m04q2,
  //     m05q1: m05q1 ?? this.m05q1,
  //     m05q2: m05q2 ?? this.m05q2,
  //     m06q1: m06q1 ?? this.m06q1,
  //     m06q2: m06q2 ?? this.m06q2,
  //     m07q1: m07q1 ?? this.m07q1,
  //     m07q2: m07q2 ?? this.m07q2,
  //     m08q1: m08q1 ?? this.m08q1,
  //     m08q2: m08q2 ?? this.m08q2,
  //     m09q1: m09q1 ?? this.m09q1,
  //     m09q2: m09q2 ?? this.m09q2,
  //     m10q1: m10q1 ?? this.m10q1,
  //     m10q2: m10q2 ?? this.m10q2,
  //     m11q1: m11q1 ?? this.m11q1,
  //     m11q2: m11q2 ?? this.m11q2,
  //     m12q1: m12q1 ?? this.m12q1,
  //     m12q2: m12q2 ?? this.m12q2,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'e4e': e4e,
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

  // factory FemSumSingle.fromMap(Map<String, dynamic> map) {
  //   return FemSumSingle(
  //     e4e: map['e4e'] ?? '',
  //     m01q1: map['m01q1'] ?? '',
  //     m01q2: map['m01q2'] ?? '',
  //     m02q1: map['m02q1'] ?? '',
  //     m02q2: map['m02q2'] ?? '',
  //     m03q1: map['m03q1'] ?? '',
  //     m03q2: map['m03q2'] ?? '',
  //     m04q1: map['m04q1'] ?? '',
  //     m04q2: map['m04q2'] ?? '',
  //     m05q1: map['m05q1'] ?? '',
  //     m05q2: map['m05q2'] ?? '',
  //     m06q1: map['m06q1'] ?? '',
  //     m06q2: map['m06q2'] ?? '',
  //     m07q1: map['m07q1'] ?? '',
  //     m07q2: map['m07q2'] ?? '',
  //     m08q1: map['m08q1'] ?? '',
  //     m08q2: map['m08q2'] ?? '',
  //     m09q1: map['m09q1'] ?? '',
  //     m09q2: map['m09q2'] ?? '',
  //     m10q1: map['m10q1'] ?? '',
  //     m10q2: map['m10q2'] ?? '',
  //     m11q1: map['m11q1'] ?? '',
  //     m11q2: map['m11q2'] ?? '',
  //     m12q1: map['m12q1'] ?? '',
  //     m12q2: map['m12q2'] ?? '',
  //   );
  // }

  factory FemSumSingle.fromInit() {
    return FemSumSingle(
      e4e: '0',
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
      m01q1ped: 0,
      m01q2ped: 0,
      m02q1ped: 0,
      m02q2ped: 0,
      m03q1ped: 0,
      m03q2ped: 0,
      m04q1ped: 0,
      m04q2ped: 0,
      m05q1ped: 0,
      m05q2ped: 0,
      m06q1ped: 0,
      m06q2ped: 0,
      m07q1ped: 0,
      m07q2ped: 0,
      m08q1ped: 0,
      m08q2ped: 0,
      m09q1ped: 0,
      m09q2ped: 0,
      m10q1ped: 0,
      m10q2ped: 0,
      m11q1ped: 0,
      m11q2ped: 0,
      m12q1ped: 0,
      m12q2ped: 0,
    );
  }

  String toJson() => json.encode(toMap());

  // factory FemSumSingle.fromJson(String source) =>
  //     FemSumSingle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FemSumSingle(e4e: $e4e, m01q1: $m01q1, m01q2: $m01q2, m02q1: $m02q1, m02q2: $m02q2, m03q1: $m03q1, m03q2: $m03q2, m04q1: $m04q1, m04q2: $m04q2, m05q1: $m05q1, m05q2: $m05q2, m06q1: $m06q1, m06q2: $m06q2, m07q1: $m07q1, m07q2: $m07q2, m08q1: $m08q1, m08q2: $m08q2, m09q1: $m09q1, m09q2: $m09q2, m10q1: $m10q1, m10q2: $m10q2, m11q1: $m11q1, m11q2: $m11q2, m12q1: $m12q1, m12q2: $m12q2)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FemSumSingle &&
        other.e4e == e4e &&
        other.m01q1 == m01q1 &&
        other.m01q2 == m01q2 &&
        other.m02q1 == m02q1 &&
        other.m02q2 == m02q2 &&
        other.m03q1 == m03q1 &&
        other.m03q2 == m03q2 &&
        other.m04q1 == m04q1 &&
        other.m04q2 == m04q2 &&
        other.m05q1 == m05q1 &&
        other.m05q2 == m05q2 &&
        other.m06q1 == m06q1 &&
        other.m06q2 == m06q2 &&
        other.m07q1 == m07q1 &&
        other.m07q2 == m07q2 &&
        other.m08q1 == m08q1 &&
        other.m08q2 == m08q2 &&
        other.m09q1 == m09q1 &&
        other.m09q2 == m09q2 &&
        other.m10q1 == m10q1 &&
        other.m10q2 == m10q2 &&
        other.m11q1 == m11q1 &&
        other.m11q2 == m11q2 &&
        other.m12q1 == m12q1 &&
        other.m12q2 == m12q2;
  }

  @override
  int get hashCode {
    return e4e.hashCode ^
        m01q1.hashCode ^
        m01q2.hashCode ^
        m02q1.hashCode ^
        m02q2.hashCode ^
        m03q1.hashCode ^
        m03q2.hashCode ^
        m04q1.hashCode ^
        m04q2.hashCode ^
        m05q1.hashCode ^
        m05q2.hashCode ^
        m06q1.hashCode ^
        m06q2.hashCode ^
        m07q1.hashCode ^
        m07q2.hashCode ^
        m08q1.hashCode ^
        m08q2.hashCode ^
        m09q1.hashCode ^
        m09q2.hashCode ^
        m10q1.hashCode ^
        m10q2.hashCode ^
        m11q1.hashCode ^
        m11q2.hashCode ^
        m12q1.hashCode ^
        m12q2.hashCode;
  }
}
