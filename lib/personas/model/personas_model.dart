import 'dart:convert';

import 'package:http/http.dart';

import '../../resources/constant/apis.dart';

class Personas {
  List<PersonasSingle> personasList = [];
  List<PersonasSingle> personasListSearch = [];
  int view = 70;
  Map itemsAndFlex = {
    'user': [2, 'Nombre'],
    'email': [2, 'Correo'],
    // 'phone': [2, 'phone'],
    'area': [2, 'Área'],
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

  obtener() async {
    Map<String, Object> dataSend = {
      'dataReq': {'libro': 'PERSONAS', 'hoja': 'reg'},
      'fname': "getHojaList"
    };
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
      // print(item);
      personasList.add(PersonasSingle.fromList(item));
    }
    // print(personasList);
    personasList
        .sort((a, b) => a.email.toLowerCase().compareTo(b.email.toLowerCase()));
    personasListSearch = [...personasList];
  }

  buscar(String busqueda) {
    personasListSearch = personasList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }
}

class PersonasSingle {
  String user;
  String email;

  PersonasSingle({
    required this.user,
    required this.email,
  });

  toList() {
    return [user, email];
  }

  PersonasSingle copyWith({
    String? user,
    String? email,
    String? phone,
    String? area,
  }) {
    return PersonasSingle(
      user: user ?? this.user,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'email': email,
    };
  }

  factory PersonasSingle.fromList(List l) {
    return PersonasSingle(
      user: l[0].toString(),
      email: l[1].toString(),
    );
  }

  factory PersonasSingle.fromMap(Map<String, dynamic> map) {
    return PersonasSingle(
      user: map['user'].toString(),
      email: map['email'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonasSingle.fromJson(String source) =>
      PersonasSingle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonasSingle(user: $user, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonasSingle &&
        other.user == user &&
        other.email == email;
  }

  @override
  int get hashCode {
    return user.hashCode ^ email.hashCode;
  }
}
