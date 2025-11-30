import 'dart:convert';

class PlataformaMb51Single {
  String documento;
  String cmv;
  String material;
  String descripcion;
  String lote;
  String lote_r;
  String ctd;
  String umb;
  String valor;
  String fecha;
  String texto_cab;
  String texto;
  String texto_vale;
  String usuario;
  String referencia;
  String wbe;
  String wbe2;
  PlataformaMb51Single({
    required this.documento,
    required this.cmv,
    required this.material,
    required this.descripcion,
    required this.lote,
    required this.lote_r,
    required this.ctd,
    required this.umb,
    required this.valor,
    required this.fecha,
    required this.texto_cab,
    required this.texto,
    required this.texto_vale,
    required this.usuario,
    required this.referencia,
    required this.wbe,
    required this.wbe2,
  });

  PlataformaMb51Single copyWith({
    String? documento,
    String? cmv,
    String? material,
    String? descripcion,
    String? lote,
    String? lote_r,
    String? ctd,
    String? umb,
    String? valor,
    String? fecha,
    String? texto_cab,
    String? texto,
    String? texto_vale,
    String? usuario,
    String? referencia,
    String? wbe,
    String? wbe2,
  }) {
    return PlataformaMb51Single(
      documento: documento ?? this.documento,
      cmv: cmv ?? this.cmv,
      material: material ?? this.material,
      descripcion: descripcion ?? this.descripcion,
      lote: lote ?? this.lote,
      lote_r: lote_r ?? this.lote_r,
      ctd: ctd ?? this.ctd,
      umb: umb ?? this.umb,
      valor: valor ?? this.valor,
      fecha: fecha ?? this.fecha,
      texto_cab: texto_cab ?? this.texto_cab,
      texto: texto ?? this.texto,
      texto_vale: texto_vale ?? this.texto_vale,
      usuario: usuario ?? this.usuario,
      referencia: referencia ?? this.referencia,
      wbe: wbe ?? this.wbe,
      wbe2: wbe2 ?? this.wbe2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'documento': documento,
      'cmv': cmv,
      'material': material,
      'descripcion': descripcion,
      'lote': lote,
      'lote_r': lote_r,
      'ctd': ctd,
      'umb': umb,
      'valor': valor,
      'fecha': fecha,
      'texto_cab': texto_cab,
      'texto': texto,
      'texto_vale': texto_vale,
      'usuario': usuario,
      'referencia': referencia,
      'wbe': wbe,
      'wbe2': wbe2,
    };
  }

  factory PlataformaMb51Single.fromMap(Map<String, dynamic> map) {
    return PlataformaMb51Single(
      documento: map['documento'].toString(),
      cmv: map['cmv'].toString(),
      material: map['material'].toString(),
      descripcion: map['descripcion'].toString(),
      lote: map['lote'].toString(),
      lote_r: map['lote_r'].toString(),
      ctd: map['ctd'].toString(),
      umb: map['umb'].toString(),
      valor: map['valor'].toString(),
      fecha: map['fecha'].toString(),
      texto_cab: map['texto_cab'].toString(),
      texto: map['texto'].toString(),
      texto_vale: map['texto_vale'].toString(),
      usuario: map['usuario'].toString(),
      referencia: map['referencia'].toString(),
      wbe: map['wbe'].toString(),
      wbe2: map['wbe2'].toString(),
    );
  }

  factory PlataformaMb51Single.fromList(List ls) {
    return PlataformaMb51Single(
      documento: ls[0].toString(),
      cmv: ls[1].toString(),
      material: ls[2].toString(),
      descripcion: ls[3].toString(),
      lote: ls[4].toString(),
      lote_r: ls[5].toString(),
      ctd: ls[6].toString(),
      umb: ls[7].toString(),
      valor: ls[8].toString(),
      fecha: ls[9].toString(),
      texto_cab: ls[10].toString(),
      texto: ls[11].toString(),
      texto_vale: ls[12].toString(),
      usuario: ls[13].toString(),
      referencia: ls[14].toString(),
      wbe: ls[15].toString(),
      wbe2: ls[16].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlataformaMb51Single.fromJson(String source) => PlataformaMb51Single.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlataformaMb51Single(documento: $documento, cmv: $cmv, material: $material, descripcion: $descripcion, lote: $lote, lote_r: $lote_r, ctd: $ctd, umb: $umb, valor: $valor, fecha: $fecha, texto_cab: $texto_cab, texto: $texto, texto_vale: $texto_vale, usuario: $usuario, referencia: $referencia, wbe: $wbe, wbe2: $wbe2)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PlataformaMb51Single &&
      other.documento == documento &&
      other.cmv == cmv &&
      other.material == material &&
      other.descripcion == descripcion &&
      other.lote == lote &&
      other.lote_r == lote_r &&
      other.ctd == ctd &&
      other.umb == umb &&
      other.valor == valor &&
      other.fecha == fecha &&
      other.texto_cab == texto_cab &&
      other.texto == texto &&
      other.texto_vale == texto_vale &&
      other.usuario == usuario &&
      other.referencia == referencia &&
      other.wbe == wbe &&
      other.wbe2 == wbe2;
  }

  @override
  int get hashCode {
    return documento.hashCode ^
      cmv.hashCode ^
      material.hashCode ^
      descripcion.hashCode ^
      lote.hashCode ^
      lote_r.hashCode ^
      ctd.hashCode ^
      umb.hashCode ^
      valor.hashCode ^
      fecha.hashCode ^
      texto_cab.hashCode ^
      texto.hashCode ^
      texto_vale.hashCode ^
      usuario.hashCode ^
      referencia.hashCode ^
      wbe.hashCode ^
      wbe2.hashCode;
  }
}
