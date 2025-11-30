// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:bloc/bloc.dart';
import 'package:fem_app/user/model/user_model.dart' as userModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';

onCrearUsuario(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  User? userFirebase = FirebaseAuth.instance.currentUser;
  bool noHayUsuario = userFirebase == null;
  if (noHayUsuario) {
    bl.mensaje(message: 'Inicie sesión ó registrese si es la primera vez que ingresa.');
    return;
  }
  String uid = userFirebase.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  DataSnapshot perfil = await ref.child('perfiles/$uid').get();
  bool noHayInformacion = !perfil.exists;
  if (noHayInformacion) {
    bl.mensaje(message: '🤕Error llamando📞 la tabla de datos Perfiles.');
    return;
  }
  bool seRecibioUnMap = perfil.value is Map<String, dynamic>;
  if (!seRecibioUnMap) {
    bl.mensaje(message: '🤕Error recibiendo un Map<String, dynamic>.');
    return;
  }
  Map<String, dynamic> perfilMap = perfil.value as Map<String, dynamic>;
  String? perfilNombre = perfilMap['perfil'];
  bool noHayPerfil = perfilNombre == null;
  if (noHayPerfil) {
    bl.mensaje(message: '🤕Error recibiendo el perfil.');
    return;
  }
  DataSnapshot permisos = await ref.child('permisos/$perfilNombre').get();
  bool noHayPermisos = !permisos.exists;
  if (noHayPermisos) {
    bl.mensaje(message: '🤕Error llamando📞 la tabla de datos Permisos.');
    return;
  }
  bool seRecibioUnaLista = permisos.value is List<dynamic>;
  if (!seRecibioUnaLista) {
    bl.mensaje(message: '🤕Error recibiendo una List<dynamic>.');
    return;
  }
  List<dynamic> permisosRaw = permisos.value as List<dynamic>;
  List<String> permisosList = permisosRaw.map((e) => e.toString()).toList();
  userModel.User user = userModel.User(
    uid: uid,
    email: userFirebase.email ?? '',
    nombre: perfilMap['nombre'] ?? '',
    perfil: perfilMap['perfil'] ?? '',
    creado: userFirebase.metadata.creationTime.toString(),
    permisos: permisosList,
  );
  emit(state().copyWith(user: user));
}

onCambiarUsuario(
  CambiarUsuario event,
  Emitter<MainState> emit,
  MainState Function() state,
) {
  try {
    emit(
      state().copyWith(
        user: event.user,
      ),
    );
  } catch (e) {
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message: '🤕Error en CambiarUsuario ' +
          '⚠️$e => ${e.runtimeType}, ' +
          'intente recargar la página🔄, ' +
          'total errores: ${state().errorCounter + 1}',
    ));
  }
}
