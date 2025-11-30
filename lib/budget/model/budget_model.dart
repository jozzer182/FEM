// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fem_app/resources/numero_precio.dart';
import 'package:http/http.dart';
import 'package:fem_app/resources/a_entero_2.dart';

import '../../resources/constant/apis.dart';
import '../../resources/titulo.dart';

class Budget {
  List<BudgetSingle> budgetList = [];
  List<BudgetSingle> budgetListSearch = [];
  int view = 70;
  Map itemsAndFlex = {
    'proyecto': [4, 'proyecto'],
    'codproyecto': [2, 'codprojecto'],
    'naturaleza': [2, 'naturaleza'],
    'kpi': [2, 'kpi'],
    'm2023': [2, '2023'],
    'm2024': [2, '2024'],
    'm2025': [2, '2025'],
    'm2026': [2, '2026'],
    'm2027': [2, '2027'],
  };

  get keys {
    return itemsAndFlex.keys.toList();
  }

  get listaTitulo {
    return [
      for (var key in keys)
        {'texto': itemsAndFlex[key][1], 'flex': itemsAndFlex[key][0]},
    ];
  }

  List<ToCelda> titles = [
    ToCelda(valor: 'Proyecto', flex: 8),
    ToCelda(valor: 'Cod. Proyecto', flex: 2),
    ToCelda(valor: 'Naturaleza', flex: 2),
    ToCelda(valor: 'KPI', flex: 2),
    ToCelda(valor: '2023', flex: 2),
    ToCelda(valor: '2024', flex: 2),
    ToCelda(valor: '2025', flex: 2),
    ToCelda(valor: '2026', flex: 2),
    ToCelda(valor: '2027', flex: 2),
  ];

  Future<List<BudgetSingle>> obtener() async {
    Map<String, Object> dataSend = {
      'dataReq': {'libro': 'BUDGET', 'hoja': 'reg'},
      'fname': "getHojaList"
    };
    // print(jsonEncode(dataSend));
    final Response response = await post(
      Uri.parse(Api.fem),
      body: jsonEncode(dataSend),
    );
    // print(response.body);
    List dataAsListMap;
    if (response.statusCode == 302) {
      var response2 = await get(Uri.parse(
          response.headers["location"].toString().replaceAll(',', '')));
      dataAsListMap = jsonDecode(response2.body);
    } else {
      dataAsListMap = jsonDecode(response.body);
    }
    for (var item in dataAsListMap.sublist(1)) {
      budgetList.add(BudgetSingle.fromList(item));
    }
    budgetListSearch = [...budgetList];
    return budgetList;
  }

  buscar(String query) {
    budgetListSearch = budgetList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(query.toLowerCase())))
        .toList();
  }
}

class BudgetSingle {
  String ejecutor;
  String proyecto;
  String codproyecto;
  String nomproyecto;
  String responsable2;
  String kpi;
  String naturaleza;
  String m2023;
  String m2024;
  String m2025;
  String m2026;
  String m2027;
  String tcapex;
  String id;
  BudgetSingle({
    required this.ejecutor,
    required this.proyecto,
    required this.codproyecto,
    required this.nomproyecto,
    required this.responsable2,
    required this.kpi,
    required this.naturaleza,
    required this.m2023,
    required this.m2024,
    required this.m2025,
    required this.m2026,
    required this.m2027,
    required this.tcapex,
    required this.id,
  });

  List<String> toList() {
    return [
      ejecutor,
      proyecto,
      codproyecto,
      nomproyecto,
      responsable2,
      kpi,
      naturaleza,
      m2023,
      m2024,
      m2025,
      m2026,
      m2027,
      tcapex,
      id,
    ];
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: proyecto, flex: 8),
        ToCelda(valor: codproyecto, flex: 2),
        ToCelda(valor: naturaleza, flex: 2),
        ToCelda(valor: kpi, flex: 2),
        ToCelda(
            valor: aEntero(m2023) == 0
                ? ""
                : "${dinero.format(aEntero(m2023) / 1000000)}MCOP",
            flex: 2),
        ToCelda(
            valor: aEntero(m2024) == 0
                ? ""
                : "${dinero.format(aEntero(m2024) / 1000000)}MCOP",
            flex: 2),
        ToCelda(
            valor: aEntero(m2025) == 0
                ? ""
                : "${dinero.format(aEntero(m2025) / 1000000)}MCOP",
            flex: 2),
        ToCelda(
            valor: aEntero(m2026) == 0
                ? ""
                : "${dinero.format(aEntero(m2026) / 1000000)}MCOP",
            flex: 2),
        ToCelda(
            valor: aEntero(m2027) == 0
                ? ""
                : "${dinero.format(aEntero(m2027) / 1000000)}MCOP",
            flex: 2),
      ];

  int campo(int ano) {
    if (ano == 2023) return aEntero(m2023);
    if (ano == 2024) return aEntero(m2024);
    if (ano == 2025) return aEntero(m2025);
    if (ano == 2026) return aEntero(m2026);
    if (ano == 2027) return aEntero(m2027);
    return 0;
  }

  BudgetSingle copyWith({
    String? ejecutor,
    String? proyecto,
    String? codproyecto,
    String? nomproyecto,
    String? responsable2,
    String? kpi,
    String? naturaleza,
    String? m2023,
    String? m2024,
    String? m2025,
    String? m2026,
    String? m2027,
    String? tcapex,
    String? id,
  }) {
    return BudgetSingle(
      ejecutor: ejecutor ?? this.ejecutor,
      proyecto: proyecto ?? this.proyecto,
      codproyecto: codproyecto ?? this.codproyecto,
      nomproyecto: nomproyecto ?? this.nomproyecto,
      responsable2: responsable2 ?? this.responsable2,
      kpi: kpi ?? this.kpi,
      naturaleza: naturaleza ?? this.naturaleza,
      m2023: m2023 ?? this.m2023,
      m2024: m2024 ?? this.m2024,
      m2025: m2025 ?? this.m2025,
      m2026: m2026 ?? this.m2026,
      m2027: m2027 ?? this.m2027,
      tcapex: tcapex ?? this.tcapex,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ejecutor': ejecutor,
      'proyecto': proyecto,
      'codproyecto': codproyecto,
      'nomproyecto': nomproyecto,
      'responsable2': responsable2,
      'kpi': kpi,
      'naturaleza': naturaleza,
      'm2023': m2023,
      'm2024': m2024,
      'm2025': m2025,
      'm2026': m2026,
      'm2027': m2027,
      'tcapex': tcapex,
      'id': id,
    };
  }

  factory BudgetSingle.fromMap(Map<String, dynamic> map) {
    return BudgetSingle(
      ejecutor: map['ejecutor'].toString(),
      proyecto: map['proyecto'].toString(),
      codproyecto: map['codproyecto'].toString(),
      nomproyecto: map['nomproyecto'].toString(),
      responsable2: map['responsable2'].toString(),
      kpi: map['kpi'].toString(),
      naturaleza: map['naturaleza'].toString(),
      m2023: map['m2023'].toString(),
      m2024: map['m2024'].toString(),
      m2025: map['m2025'].toString(),
      m2026: map['m2026'].toString(),
      m2027: map['m2027'].toString(),
      tcapex: map['tcapex'].toString(),
      id: map['id'].toString(),
    );
  }

  factory BudgetSingle.fromList(List<dynamic> list) {
    return BudgetSingle(
      ejecutor: list[0].toString(),
      proyecto: list[1].toString(),
      codproyecto: list[2].toString(),
      nomproyecto: list[3].toString(),
      responsable2: list[4].toString(),
      kpi: list[5].toString(),
      naturaleza: list[6].toString(),
      m2023: list[7].toString(),
      m2024: list[8].toString(),
      m2025: list[9].toString(),
      m2026: list[10].toString(),
      m2027: list[11].toString(),
      tcapex: list[12].toString(),
      id: list[13].toString(),
    );
  }

  factory BudgetSingle.fromZero() {
    return BudgetSingle(
      ejecutor: '',
      proyecto: '',
      codproyecto: '',
      nomproyecto: '',
      responsable2: '',
      kpi: '',
      naturaleza: '',
      m2023: '',
      m2024: '',
      m2025: '',
      m2026: '',
      m2027: '',
      tcapex: '',
      id: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BudgetSingle.fromJson(String source) =>
      BudgetSingle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BudgetSingle(ejecutor: $ejecutor, proyecto: $proyecto, codproyecto: $codproyecto, nomproyecto: $nomproyecto, responsable2: $responsable2, kpi: $kpi, naturaleza: $naturaleza, m2023: $m2023, m2024: $m2024, m2025: $m2025, m2026: $m2026, m2027: $m2027, tcapex: $tcapex)';
  }

  @override
  bool operator ==(covariant BudgetSingle other) {
    if (identical(this, other)) return true;

    return other.ejecutor == ejecutor &&
        other.proyecto == proyecto &&
        other.codproyecto == codproyecto &&
        other.nomproyecto == nomproyecto &&
        other.responsable2 == responsable2 &&
        other.kpi == kpi &&
        other.naturaleza == naturaleza &&
        other.m2023 == m2023 &&
        other.m2024 == m2024 &&
        other.m2025 == m2025 &&
        other.m2026 == m2026 &&
        other.m2027 == m2027 &&
        other.tcapex == tcapex;
  }

  @override
  int get hashCode {
    return ejecutor.hashCode ^
        proyecto.hashCode ^
        codproyecto.hashCode ^
        nomproyecto.hashCode ^
        responsable2.hashCode ^
        kpi.hashCode ^
        naturaleza.hashCode ^
        m2023.hashCode ^
        m2024.hashCode ^
        m2025.hashCode ^
        m2026.hashCode ^
        m2027.hashCode ^
        tcapex.hashCode;
  }
}
