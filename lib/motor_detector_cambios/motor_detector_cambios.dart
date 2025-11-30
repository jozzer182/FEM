import '../fem/model/fem_model_single_fem.dart';

String detectorCambios({
  required SingleFEM newFEM,
  required SingleFEM oldFEM,
}) {
  String cambioUnidades = '';
  if (oldFEM.total < newFEM.total) {
    cambioUnidades += 'Se agregaron ${newFEM.total - oldFEM.total} unidades';
  }
  if (oldFEM.total > newFEM.total) {
    cambioUnidades += 'Se quitaron ${oldFEM.total - newFEM.total} unidades';
  }
  String cambioTemporal = '';
  if (oldFEM.m01q1 != newFEM.m01q1) {
    cambioTemporal += 'M01Q1: ${newFEM.m01q1Int - oldFEM.m01q1Int}';
  }
  if (oldFEM.m01q2 != newFEM.m01q2) {
    cambioTemporal += 'M01Q2: ${newFEM.m01q2Int - oldFEM.m01q2Int}';
  }
  if (oldFEM.m02q1 != newFEM.m02q1) {
    cambioTemporal += 'M01Qx: ${newFEM.m01qxInt - oldFEM.m01qxInt}';
  }
  if (oldFEM.m02q2 != newFEM.m02q2) {
    cambioTemporal += 'M02Q1: ${newFEM.m02q1Int - oldFEM.m02q1Int}';
  }
  if (oldFEM.m02q2 != newFEM.m02q2) {
    cambioTemporal += 'M02Q2: ${newFEM.m02q2Int - oldFEM.m02q2Int}';
  }
  if (oldFEM.m03q1 != newFEM.m03q1) {
    cambioTemporal += 'M03Q1: ${newFEM.m03q1Int - oldFEM.m03q1Int}';
  }
  if (oldFEM.m03q2 != newFEM.m03q2) {
    cambioTemporal += 'M03Q2: ${newFEM.m03q2Int - oldFEM.m03q2Int}';
  }
  if (oldFEM.m04q1 != newFEM.m04q1) {
    cambioTemporal += 'M04Q1: ${newFEM.m04q1Int - oldFEM.m04q1Int}';
  }
  if (oldFEM.m04q2 != newFEM.m04q2) {
    cambioTemporal += 'M04Q2: ${newFEM.m04q2Int - oldFEM.m04q2Int}';
  }
  if (oldFEM.m05q1 != newFEM.m05q1) {
    cambioTemporal += 'M05Q1: ${newFEM.m05q1Int - oldFEM.m05q1Int}';
  }
  if (oldFEM.m05q2 != newFEM.m05q2) {
    cambioTemporal += 'M05Q2: ${newFEM.m05q2Int - oldFEM.m05q2Int}';
  }
  if (oldFEM.m06q1 != newFEM.m06q1) {
    cambioTemporal += 'M06Q1: ${newFEM.m06q1Int - oldFEM.m06q1Int}';
  }
  if (oldFEM.m06q2 != newFEM.m06q2) {
    cambioTemporal += 'M06Q2: ${newFEM.m06q2Int - oldFEM.m06q2Int}';
  }
  if (oldFEM.m07q1 != newFEM.m07q1) {
    cambioTemporal += 'M07Q1: ${newFEM.m07q1Int - oldFEM.m07q1Int}';
  }
  if (oldFEM.m07q2 != newFEM.m07q2) {
    cambioTemporal += 'M07Q2: ${newFEM.m07q2Int - oldFEM.m07q2Int}';
  }
  if (oldFEM.m08q1 != newFEM.m08q1) {
    cambioTemporal += 'M08Q1: ${newFEM.m08q1Int - oldFEM.m08q1Int}';
  }
  if (oldFEM.m08q2 != newFEM.m08q2) {
    cambioTemporal += 'M08Q2: ${newFEM.m08q2Int - oldFEM.m08q2Int}';
  }
  if (oldFEM.m09q1 != newFEM.m09q1) {
    cambioTemporal += 'M09Q1: ${newFEM.m09q1Int - oldFEM.m09q1Int}';
  }
  if (oldFEM.m09q2 != newFEM.m09q2) {
    cambioTemporal += 'M09Q2: ${newFEM.m09q2Int - oldFEM.m09q2Int}';
  }
  if (oldFEM.m10q1 != newFEM.m10q1) {
    cambioTemporal += 'M10Q1: ${newFEM.m10q1Int - oldFEM.m10q1Int}';
  }
  if (oldFEM.m10q2 != newFEM.m10q2) {
    cambioTemporal += 'M10Q2: ${newFEM.m10q2Int - oldFEM.m10q2Int}';
  }
  if (oldFEM.m11q1 != newFEM.m11q1) {
    cambioTemporal += 'M11Q1: ${newFEM.m11q1Int - oldFEM.m11q1Int}';
  }
  if (oldFEM.m11q2 != newFEM.m11q2) {
    cambioTemporal += 'M11Q2: ${newFEM.m11q2Int - oldFEM.m11q2Int}';
  }
  if (oldFEM.m12q1 != newFEM.m12q1) {
    cambioTemporal += 'M12Q1: ${newFEM.m12q1Int - oldFEM.m12q1Int}';
  }
  if (oldFEM.m12q2 != newFEM.m12q2) {
    cambioTemporal += 'M12Q2: ${newFEM.m12q2Int - oldFEM.m12q2Int}';
  }
  String cambioPedido = '';
  if (oldFEM.estdespacho != newFEM.estdespacho) {
    if (oldFEM.m01q1ped != newFEM.m01q1ped) {
      cambioPedido += 'M01Q1_pedido: ${newFEM.m01q1ped - oldFEM.m01q1ped}';
    }
    if (oldFEM.m01q2ped != newFEM.m01q2ped) {
      cambioPedido += 'M01Q2_pedido: ${newFEM.m01q2ped - oldFEM.m01q2ped}';
    }
    if (oldFEM.m02q1ped != newFEM.m02q1ped) {
      cambioPedido += 'M02Q1_pedido: ${newFEM.m02q1ped - oldFEM.m02q1ped}';
    }
    if (oldFEM.m02q2ped != newFEM.m02q2ped) {
      cambioPedido += 'M02Q2_pedido: ${newFEM.m02q2ped - oldFEM.m02q2ped}';
    }
    if (oldFEM.m03q1ped != newFEM.m03q1ped) {
      cambioPedido += 'M03Q1_pedido: ${newFEM.m03q1ped - oldFEM.m03q1ped}';
    }
    if (oldFEM.m03q2ped != newFEM.m03q2ped) {
      cambioPedido += 'M03Q2_pedido: ${newFEM.m03q2ped - oldFEM.m03q2ped}';
    }
    if (oldFEM.m04q1ped != newFEM.m04q1ped) {
      cambioPedido += 'M04Q1_pedido: ${newFEM.m04q1ped - oldFEM.m04q1ped}';
    }
    if (oldFEM.m04q2ped != newFEM.m04q2ped) {
      cambioPedido += 'M04Q2_pedido: ${newFEM.m04q2ped - oldFEM.m04q2ped}';
    }
    if (oldFEM.m05q1ped != newFEM.m05q1ped) {
      cambioPedido += 'M05Q1_pedido: ${newFEM.m05q1ped - oldFEM.m05q1ped}';
    }
    if (oldFEM.m05q2ped != newFEM.m05q2ped) {
      cambioPedido += 'M05Q2_pedido: ${newFEM.m05q2ped - oldFEM.m05q2ped}';
    }
    if (oldFEM.m06q1ped != newFEM.m06q1ped) {
      cambioPedido += 'M06Q1_pedido: ${newFEM.m06q1ped - oldFEM.m06q1ped}';
    }
    if (oldFEM.m06q2ped != newFEM.m06q2ped) {
      cambioPedido += 'M06Q2_pedido: ${newFEM.m06q2ped - oldFEM.m06q2ped}';
    }
    if (oldFEM.m07q1ped != newFEM.m07q1ped) {
      cambioPedido += 'M07Q1_pedido: ${newFEM.m07q1ped - oldFEM.m07q1ped}';
    }
    if (oldFEM.m07q2ped != newFEM.m07q2ped) {
      cambioPedido += 'M07Q2_pedido: ${newFEM.m07q2ped - oldFEM.m07q2ped}';
    }
    if (oldFEM.m08q1ped != newFEM.m08q1ped) {
      cambioPedido += 'M08Q1_pedido: ${newFEM.m08q1ped - oldFEM.m08q1ped}';
    }
    if (oldFEM.m08q2ped != newFEM.m08q2ped) {
      cambioPedido += 'M08Q2_pedido: ${newFEM.m08q2ped - oldFEM.m08q2ped}';
    }
    if (oldFEM.m09q1ped != newFEM.m09q1ped) {
      cambioPedido += 'M09Q1_pedido: ${newFEM.m09q1ped - oldFEM.m09q1ped}';
    }
    if (oldFEM.m09q2ped != newFEM.m09q2ped) {
      cambioPedido += 'M09Q2_pedido: ${newFEM.m09q2ped - oldFEM.m09q2ped}';
    }
    if (oldFEM.m10q1ped != newFEM.m10q1ped) {
      cambioPedido += 'M10Q1_pedido: ${newFEM.m10q1ped - oldFEM.m10q1ped}';
    }
    if (oldFEM.m10q2ped != newFEM.m10q2ped) {
      cambioPedido += 'M10Q2_pedido: ${newFEM.m10q2ped - oldFEM.m10q2ped}';
    }
    if (oldFEM.m11q1ped != newFEM.m11q1ped) {
      cambioPedido += 'M11Q1_pedido: ${newFEM.m11q1ped - oldFEM.m11q1ped}';
    }
    if (oldFEM.m11q2ped != newFEM.m11q2ped) {
      cambioPedido += 'M11Q2_pedido: ${newFEM.m11q2ped - oldFEM.m11q2ped}';
    }
    if (oldFEM.m12q1ped != newFEM.m12q1ped) {
      cambioPedido += 'M12Q1_pedido: ${newFEM.m12q1ped - oldFEM.m12q1ped}';
    }
    if (oldFEM.m12q2ped != newFEM.m12q2ped) {
      cambioPedido += 'M12Q2_pedido: ${newFEM.m12q2ped - oldFEM.m12q2ped}';
    }
  }

  String cambioCircuito = '';
  if (oldFEM.circuito != newFEM.circuito) {
    cambioCircuito += '${oldFEM.circuito} -> ${newFEM.circuito}';
  }

  String cambioWbe = '';
  if (oldFEM.wbe != newFEM.wbe) {
    cambioWbe += '${oldFEM.wbe} -> ${newFEM.wbe}';
  }

  String cambioPdi = '';
  if (oldFEM.pdi != newFEM.pdi) {
    cambioPdi += '${oldFEM.pdi} ->  ${newFEM.pdi}';
  }

  String cambioTipo = '';
  if (oldFEM.tipo != newFEM.tipo) {
    cambioTipo += '${oldFEM.tipo} -> ${newFEM.tipo}';
  }
  String cambioCausar = '';
  if (oldFEM.proyectowbe != newFEM.proyectowbe) {
    cambioCausar += '${oldFEM.proyectowbe} -> ${newFEM.proyectowbe}';
  }

  String cambio = '';
  if (cambioUnidades != '') {
    cambio += 'Unidades: $cambioUnidades';
  }
  if (cambioTemporal != '') {
    cambio += 'Temporal: $cambioTemporal';
  }
  if (cambioPedido != '') {
    cambio += 'Pedido: $cambioPedido';
  }
  if (cambioCircuito != '') {
    cambio += 'Circuito: $cambioCircuito';
  }
  if (cambioWbe != '') {
    cambio += 'WBE: $cambioWbe';
  }
  if (cambioPdi != '') {
    cambio += 'PDI: $cambioPdi';
  }
  if (cambioTipo != '') {
    cambio += 'Tipo: $cambioTipo';
  }
  if (cambioCausar != '') {
    cambio += 'Causar: $cambioCausar';
  }

  return cambio;
}
