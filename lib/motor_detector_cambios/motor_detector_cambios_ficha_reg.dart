import 'package:fem_app/ficha/ficha_ficha/model/ficha_reg/reg.dart';
import 'package:fem_app/resources/constant/meses.dart';

String detectorCambiosFicha({
  required FichaReg newFEM,
  required FichaReg oldFEM,
}) {
  String cambioUnidades = '';
  if (oldFEM.planificado.mes.total < newFEM.planificado.mes.total) {
    cambioUnidades +=
        'Se agregaron ${newFEM.planificado.mes.total - oldFEM.planificado.mes.total} unidades';
  }
  if (oldFEM.planificado.mes.total > newFEM.planificado.mes.total) {
    cambioUnidades +=
        'Se quitaron ${oldFEM.planificado.mes.total - newFEM.planificado.mes.total} unidades';
  }
  String cambioTemporal = '';
  for (String mes in meses) {
    int oldQ1 = oldFEM.planificado.quincena.get('$mes-1');
    int newQ1 = newFEM.planificado.quincena.get('$mes-1');
    int oldQ2 = oldFEM.planificado.quincena.get('$mes-2');
    int newQ2 = newFEM.planificado.quincena.get('$mes-2');
    if (oldQ1 != newQ1) {
      cambioTemporal += 'M${mes}Q1: ${newQ1 - oldQ1} ';
    }
    if (oldQ2 != newQ2) {
      cambioTemporal += 'M${mes}Q2: ${newQ2 - oldQ2} ';
    }
  }
  String cambioPedido = '';
  if (oldFEM.estdespacho != newFEM.estdespacho) {
    for (String mes in meses) {
      int oldq1Ped = oldFEM.agendado.quincena.get('$mes-1');
      int newq1Ped = newFEM.agendado.quincena.get('$mes-1');
      int oldq2Ped = oldFEM.agendado.quincena.get('$mes-2');
      int newq2Ped = newFEM.agendado.quincena.get('$mes-2');
      if (oldq1Ped != newq1Ped) {
        cambioPedido += 'M${mes}Q1_pedido: ${newq1Ped - oldq1Ped} ';
      }
      if (oldq2Ped != newq2Ped) {
        cambioPedido += 'M${mes}Q2_pedido: ${newq2Ped - oldq2Ped} ';
      }
    }
  }

  String cambioCircuito = '';
  if (oldFEM.circuito != newFEM.circuito) {
    cambioCircuito += '${oldFEM.circuito} -> ${newFEM.circuito} ';
  }

  String cambioWbe = '';
  if (oldFEM.wbe != newFEM.wbe) {
    cambioWbe += '${oldFEM.wbe} -> ${newFEM.wbe} ';
  }

  String cambioPdi = '';
  if (oldFEM.pdi != newFEM.pdi) {
    cambioPdi += '${oldFEM.pdi} ->  ${newFEM.pdi} ';
  }

  String cambioTipo = '';
  if (oldFEM.tipo != newFEM.tipo) {
    cambioTipo += '${oldFEM.tipo} -> ${newFEM.tipo} ';
  }

  String cambio = '';
  if (cambioUnidades != '') {
    cambio += 'Unidades: $cambioUnidades; ';
  }
  if (cambioTemporal != '') {
    cambio += 'Temporal: $cambioTemporal; ';
  }
  if (cambioPedido != '') {
    cambio += 'Pedido: $cambioPedido; ';
  }
  if (cambioCircuito != '') {
    cambio += 'Circuito: $cambioCircuito; ';
  }
  if (cambioWbe != '') {
    cambio += 'WBE: $cambioWbe; ';
  }
  if (cambioPdi != '') {
    cambio += 'PDI: $cambioPdi; ';
  }
  if (cambioTipo != '') {
    cambio += 'Tipo: $cambioTipo; ';
  }

  return cambio;
}


