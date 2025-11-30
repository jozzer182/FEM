import 'package:fem_app/fem/model/fem_model_single_fem.dart';

class SingleFEMLog {
  final SingleFEM singleFEM;
  SingleFEMLog(this.singleFEM);

  String cambio = '';
  String razon = '';
  String persona = '';
  String fecha = '';
  String respuesta = '';
  String razonrespuesta = '';
  String personarespuesta = '';
  String fecharespuesta = '';

  Map<String, dynamic> toMap() {
    return {
      'item': singleFEM.item,
      'year': singleFEM.year,
      'id': singleFEM.estado == 'nuevo' ? '' : singleFEM.id,
      'estado': singleFEM.estado,
      'estdespacho': singleFEM.estdespacho,
      'tipo': singleFEM.tipo,
      'fechainicial': singleFEM.fechainicial,
      'fechacambio': singleFEM.fechacambio,
      'fechasolicitud': singleFEM.fechasolicitud,
      'unidad': singleFEM.unidad,
      'codigo': singleFEM.codigo,
      'proyecto': singleFEM.proyecto,
      'circuito': singleFEM.circuito,
      'pm': singleFEM.pm,
      'solicitante': singleFEM.solicitante,
      'pdi': singleFEM.pdi,
      'wbe': singleFEM.wbe,
      'proyectowbe': singleFEM.proyectowbe,
      'comentario1': singleFEM.comentario1,
      'comentario2': singleFEM.comentario2,
      'e4e': singleFEM.e4e,
      'descripcion': singleFEM.descripcion,
      'um': singleFEM.um,
      'm01q1': singleFEM.m01q1,
      'm01q2': singleFEM.m01q2,
      'm01qx': singleFEM.m01qx,
      'm02q1': singleFEM.m02q1,
      'm02q2': singleFEM.m02q2,
      'm02qx': singleFEM.m02qx,
      'm03q1': singleFEM.m03q1,
      'm03q2': singleFEM.m03q2,
      'm03qx': singleFEM.m03qx,
      'm04q1': singleFEM.m04q1,
      'm04q2': singleFEM.m04q2,
      'm04qx': singleFEM.m04qx,
      'm05q1': singleFEM.m05q1,
      'm05q2': singleFEM.m05q2,
      'm05qx': singleFEM.m05qx,
      'm06q1': singleFEM.m06q1,
      'm06q2': singleFEM.m06q2,
      'm06qx': singleFEM.m06qx,
      'm07q1': singleFEM.m07q1,
      'm07q2': singleFEM.m07q2,
      'm07qx': singleFEM.m07qx,
      'm08q1': singleFEM.m08q1,
      'm08q2': singleFEM.m08q2,
      'm08qx': singleFEM.m08qx,
      'm09q1': singleFEM.m09q1,
      'm09q2': singleFEM.m09q2,
      'm09qx': singleFEM.m09qx,
      'm10q1': singleFEM.m10q1,
      'm10q2': singleFEM.m10q2,
      'm10qx': singleFEM.m10qx,
      'm11q1': singleFEM.m11q1,
      'm11q2': singleFEM.m11q2,
      'm11qx': singleFEM.m11qx,
      'm12q1': singleFEM.m12q1,
      'm12q2': singleFEM.m12q2,
      'm12qx': singleFEM.m12qx,
      'cambio': cambio,
      'razon': razon,
      'persona': persona,
      'fecha': fecha,
      'respuesta': respuesta,
      'razonrespuesta': razonrespuesta,
      'personarespuesta': personarespuesta,
      'fecharespuesta': fecharespuesta,
    };
  }
}
