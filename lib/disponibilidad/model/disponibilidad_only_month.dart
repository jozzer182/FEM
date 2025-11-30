import 'dart:convert';

class Mes {
  int mes;
  int ano;
  int pmc = 0;
  int ora = 0;
  int ce = 0;
  int demanda = 0;
  int oe = 0;
  int stock = 0;
  int oferta = 0;
  int proyectado = 0;
  Mes({
    required this.mes,
    required this.ano,
    this.pmc = 0,
    this.ora = 0,
    this.ce = 0,
    this.demanda = 0,
    this.oe = 0,
    this.stock = 0,
    this.oferta = 0,
    this.proyectado = 0,
  });

  Mes copyWith({
    int? mes,
    int? ano,
    int? pmc,
    int? ora,
    int? ce,
    int? demanda,
    int? oe,
    int? stock,
    int? oferta,
    int? proyectado,
  }) {
    return Mes(
      mes: mes ?? this.mes,
      ano: ano ?? this.ano,
      pmc: pmc ?? this.pmc,
      ora: ora ?? this.ora,
      ce: ce ?? this.ce,
      demanda: demanda ?? this.demanda,
      oe: oe ?? this.oe,
      stock: stock ?? this.stock,
      oferta: oferta ?? this.oferta,
      proyectado: proyectado ?? this.proyectado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mes': mes,
      'ano': ano,
      'pmc': pmc,
      'ora': ora,
      'ce': ce,
      'demanda': demanda,
      'oe': oe,
      'stock': stock,
      'oferta': oferta,
      'proyectado': proyectado,
    };
  }

  factory Mes.fromMap(Map<String, dynamic> map) {
    return Mes(
      mes: map['mes']?.toInt() ?? 0,
      ano: map['ano']?.toInt() ?? 0,
      pmc: map['pmc']?.toInt() ?? 0,
      ora: map['ora']?.toInt() ?? 0,
      ce: map['ce']?.toInt() ?? 0,
      demanda: map['demanda']?.toInt() ?? 0,
      oe: map['oe']?.toInt() ?? 0,
      stock: map['stock']?.toInt() ?? 0,
      oferta: map['oferta']?.toInt() ?? 0,
      proyectado: map['proyectado']?.toInt() ?? 0,
    );
  }

  factory Mes.zero() {
    return Mes(
      mes: 0,
      ano: 0,
      pmc: 0,
      ora: 0,
      ce: 0,
      demanda: 0,
      oe: 0,
      stock: 0,
      oferta: 0,
      proyectado: 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Mes.fromJson(String source) => Mes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Mes(mes: $mes, ano: $ano, pmc: $pmc, ora: $ora, ce: $ce, demanda: $demanda, oe: $oe, stock: $stock, oferta: $oferta, proyectado: $proyectado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Mes &&
        other.mes == mes &&
        other.ano == ano &&
        other.pmc == pmc &&
        other.ora == ora &&
        other.ce == ce &&
        other.demanda == demanda &&
        other.oe == oe &&
        other.stock == stock &&
        other.oferta == oferta &&
        other.proyectado == proyectado;
  }

  @override
  int get hashCode {
    return mes.hashCode ^
        ano.hashCode ^
        pmc.hashCode ^
        ora.hashCode ^
        ce.hashCode ^
        demanda.hashCode ^
        oe.hashCode ^
        stock.hashCode ^
        oferta.hashCode ^
        proyectado.hashCode;
  }
}
