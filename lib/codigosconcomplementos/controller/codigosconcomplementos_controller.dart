import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../mm60/model/mm60_model.dart';
import '../model/codigosconcomplementos_model.dart';

class CodigosConComplementosController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  CodigosConComplementosController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get onLoadCodigosConComplementos async {
    var emit = bl.emit;
    MainState Function() state = bl.state;
    CodigosConComplementos codigosConComplementos = CodigosConComplementos();
    try {
      await codigosConComplementos.obtener();
      emit(state().copyWith(codigosConComplementos: codigosConComplementos));
    } catch (e) {
      bl.errorCarga("CodigosConComplementos", e);
    }
  }

  Future<void> onSaveCodigosConComplementosSingle(bool esNuevo) async {
    // void Function(MainState p1) emit = bl.emit;
    MainState Function() state = bl.state;
    // void Function(MainEvent p1) add = bl.add;
    bl.startLoading;
    CodigosConComplementos codigosConComplementos =
        state().codigosConComplementos!;
    try {
      Get.back();
      String respuesta ="";
      if (esNuevo) {
        respuesta = await codigosConComplementos.guardar(codigosConComplementos.nuevo);
      } else {
        respuesta = await codigosConComplementos.actualizar(codigosConComplementos.nuevo);
      }
      bl.mensaje(message: respuesta, messageColor: Colors.green);
      await Future.delayed(const Duration(seconds: 1));
      bl.recargar;
    } catch (e) {
      bl.errorCarga("CodigosConComplementos", e);
      bl.stopLoading;
    }
  }

  Future<void> onDeleteCodigosConComplementosSingle() async {
    // void Function(MainState p1) emit = bl.emit;
    MainState Function() state = bl.state;
    // void Function(MainEvent p1) add = bl.add;
    bl.startLoading;
    CodigosConComplementos codigosConComplementos =
        state().codigosConComplementos!;
    try {
      Get.back();
      String respuesta =
          await codigosConComplementos.borrar(codigosConComplementos.nuevo);
      bl.mensaje(message: respuesta, messageColor: Colors.green);
      await Future.delayed(const Duration(seconds: 1));
      bl.recargar;
    } catch (e) {
      bl.errorCarga("CodigosConComplementos", e);
      bl.stopLoading;
    }
  }

  void onEditCodigosConComplementosSingle({
    required String value,
    required CodigosConComplementosSingleTipo tipo,
    CodigosConComplementosSingle? codigosConComplementosSingle,
  }) {
    void Function(MainState p1) emit = bl.emit;
    MainState Function() state = bl.state;
    // void Function(MainEvent p1) add = bl.add;
    CodigosConComplementos codigosConComplementos =
        state().codigosConComplementos!;
    CodigosConComplementosSingle nuevo = codigosConComplementos.nuevo;
    nuevo = nuevo.copyWithEnum(value: value, tipo: tipo);

    //Logicas de validación
    //Validación de e4e
    List<Mm60Single> mm60 = state().mm60!.mm60List;

    if (tipo == CodigosConComplementosSingleTipo.e4e) {
      CodigosConComplementosSingle codigoRepedido =
          codigosConComplementos.codigosConComplementos.firstWhere(
        (element) => element.e4e == value,
        orElse: () => CodigosConComplementosSingle.fromInit(),
      );
      bool e4eMenorA6 = nuevo.e4e.length < 6;
      bool e4eVacio = nuevo.e4e.isEmpty;
      bool e4eRepetido = codigoRepedido.e4e != "";
      if (e4eMenorA6) nuevo.e4eError = "6 digitos";
      if (e4eRepetido) nuevo.e4eError = "Repetido";
      if (e4eVacio) nuevo.e4eError = null;
      if (!e4eMenorA6 && !e4eRepetido && !e4eVacio) {
        Mm60Single mm60Single = mm60.firstWhere(
          (e) => e.material == nuevo.e4e,
          orElse: () => Mm60Single.fromInit(),
        );
        bool esMm60 = mm60Single.material != "";
        if (esMm60) {
          nuevo = nuevo.copyWith(
            descripcion: mm60Single.descripcion,
            nt: mm60Single.tpmt,
            um: mm60Single.um,
            precio: mm60Single.precio,
            familia: "",
          );
          nuevo.descripcionError = null;
          nuevo.ntError = null;
          nuevo.umError = null;
          nuevo.precioError = null;
          nuevo.familiaError = 'requerido';
        } else {
          nuevo = nuevo.copyWith(
            descripcion: "",
            nt: "",
            um: "",
            precio: "",
            familia: "",
          );
          nuevo.descripcionError = 'requerido';
          nuevo.ntError = 'requerido';
          nuevo.umError = 'requerido';
          nuevo.precioError = 'requerido';
          nuevo.familiaError = 'requerido';
        }
      }
    }

    //Validación de descripcion
    if (tipo == CodigosConComplementosSingleTipo.descripcion) {
      bool descripcionVacia = nuevo.descripcion.isEmpty;
      if (descripcionVacia) nuevo.descripcionError = "requerido";
      if (!descripcionVacia) nuevo.descripcionError = null;
    }

    //Validación de nt
    if (tipo == CodigosConComplementosSingleTipo.nt) {
      List<String> ntList = mm60.map((e) => e.tpmt).toSet().toList()..sort();
      bool esNt = ntList.contains(nuevo.nt);
      bool ntVacia = nuevo.nt.isEmpty;
      nuevo.ntError = ntVacia ? 'Requerido' : 'NT no existente';
      if (!ntVacia && esNt) nuevo.ntError = null;
    }

    //Validación de um
    if (tipo == CodigosConComplementosSingleTipo.um) {
      List<String> umList = mm60.map((e) => e.um).toSet().toList()..sort();
      bool esUm = umList.contains(nuevo.um);
      bool umVacia = nuevo.um.isEmpty;
      nuevo.umError = umVacia ? 'Requerido' : 'UM no existente';
      if (!umVacia && esUm) nuevo.umError = null;
    }

    //Validación de precio
    if (tipo == CodigosConComplementosSingleTipo.precio) {
      bool precioVacio = nuevo.precio.isEmpty;
      bool precioEsNumero = double.tryParse(nuevo.precio) != null;
      nuevo.precioError = precioVacio ? 'Requerido' : 'No es un número';
      if (!precioVacio && precioEsNumero) nuevo.precioError = null;
    }

    //Fin de logica de validación
    //Editar codigo viejo
    bool hayCodigoInicial = codigosConComplementosSingle != null;
    if (hayCodigoInicial) {
      nuevo = codigosConComplementosSingle;
    }
    codigosConComplementos.nuevo = nuevo;
    emit(state().copyWith(codigosConComplementos: codigosConComplementos));
  }
}
