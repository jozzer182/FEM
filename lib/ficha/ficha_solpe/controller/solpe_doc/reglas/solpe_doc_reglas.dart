import 'package:flutter/material.dart';

import '../../../../../bloc/main__bl.dart';
import '../../../../../bloc/main_bloc.dart';
import '../../../../../disponibilidad/model/disponibilidad_model.dart';
import '../../../../../motor_detector_cambios/motor_detector_cambios_ficha_reg.dart';
import '../../../../../resources/a_entero_2.dart';
import '../../../../ficha_ficha/model/ficha_reg/reg.dart';
import '../../../model/solpe_doc.dart';
import '../../../model/solpe_reg.dart';

class SolpeReglasController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late SolPeDoc solPeDoc;

  SolpeReglasController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    solPeDoc = bl.state().solPeDoc!;
  }

  get init {
    solPeDoc.original.clear();
    solPeDoc.modificada.clear();
    solPeDoc.eliminados.clear();
    List<FichaReg> original = solPeDoc.original;
    List<FichaReg> modificada = solPeDoc.modificada;
    List<FichaReg> eliminados = solPeDoc.eliminados;

    for (SolPeReg reg in solPeDoc.list) {
      //pasarlo para edicion del funcional
      if (reg.estado == "Solicitado") {
        reg.ctdp = reg.ctds;
      }
      if (reg.pedidofinal.isEmpty) {
        reg.pedidofinal = reg.pedido;
      }
      int disponible = aEntero(
        state()
            .disponibilidad!
            .disponibilidadList
            .firstWhere(
              (e) => e.e4e == reg.e4e,
              orElse: () => DisponibilidadSingle.fromInit(),
            )
            .total,
      );
      reg.disponible = disponible;
      //planificado:
      if (reg.pedidofinal.isNotEmpty) {
        String mes = reg.pedidofinal.substring(0, 2);
        String year = reg.pedidofinal.substring(3, 5);
        String quincena = reg.pedidofinal.substring(6, 7);
        String yearState = '20$year';
        emit(state().copyWith(year: yearState));
        // print('mes: $mes');
        // print('year: $year');
        // print('quincena: $quincena');
        FichaReg fichaReg = state().ficha!.fficha.ficha.firstWhere(
          (e) => e.e4e == reg.e4e && e.circuito == reg.circuito,
          orElse: () {
            return FichaReg.fromInit(original.length, year)..estado = "nuevo";
          },
        )
          ..fechainicial = DateTime.now().toString()
          ..unidad = reg.unidad
          ..codigo = state().ficha!.fficha.ficha.first.codigo
          ..proyecto = reg.proyecto
          ..circuito = reg.circuito
          ..pm = state().ficha!.fficha.ficha.first.pm
          ..solicitante = state().user!.email
          ..pdi = reg.pdi
          ..comentario1 = reg.eccomentario
          ..e4e = reg.e4e
          ..descripcion = reg.descripcion
          ..um = reg.um
          ..year = '20$year';
        if (fichaReg.id.isNotEmpty) {
          String oldYear = fichaReg.id.substring(2, 4);
          if (year != oldYear) {
            //eliminar id
            fichaReg.id = '';
            // reset en estdespacho
            fichaReg.estdespacho =
                '[{"01|$year-1":"0","01|$year-2":"0","02|$year-1":"0","02|$year-2":"0","03|$year-1":"0","03|$year-2":"0","04|$year-1":"0","04|$year-2":"0","05|$year-1":"0","05|$year-2":"0","06|$year-1":"0","06|$year-2":"0","07|$year-1":"0","07|$year-2":"0","08|$year-1":"0","08|$year-2":"0","09|$year-1":"0","09|$year-2":"0","10|$year-1":"0","10|$year-2":"0","11|$year-1":"0","11|$year-2":"0","12|$year-1":"0","12|$year-2":"0"}]';
          }
        }

        // print(reg.id);
        fichaReg.idSolpe = reg.id;
        FichaReg fichaRegModificada = fichaReg.copyWith()..estado = "Aprobado";
        fichaRegModificada.setWithQuincena('$mes-$quincena', '${reg.ctdp}');
        fichaRegModificada.setPedido('$mes|$year-$quincena', "1");
        if (fichaReg.estado != "nuevo") {
          fichaReg.log.cambio = detectorCambiosFicha(
            newFEM: fichaRegModificada,
            oldFEM: fichaReg,
          );
          eliminados.add(fichaReg);
        }
        original.add(fichaReg);
        // print('fichaReg: $fichaReg');
        // print('fichaRegModificada: $fichaRegModificada');
        modificada.add(fichaRegModificada);
        String planificadoRaw = fichaReg.planificado.mes.get(mes);
        String agendado = fichaReg.planificado.mes.get(mes);
        //planificado sin usar
        int planificado = aEntero(planificadoRaw) - aEntero(agendado);
        reg.planificado = planificado;
      }
    }
    print('solPeDoc');
    recurrentes;
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  void get recurrentes {
    //repetido
    Map<String, int> contador = {};
    for (SolPeReg reg in solPeDoc.list) {
      contador[reg.e4e] = (contador[reg.e4e] ?? 0) + 1;
    }

    for (SolPeReg reg in solPeDoc.list) {
      reg.e4eColor = Colors.green;
      reg.ctdsColor = Colors.green;
      reg.ctdpColor = Colors.green;
      reg.pedidofinalColor = Colors.green;
      reg.e4eError = '';
      reg.ctdsError = '';
      reg.ctdpError = '';
      reg.pedidoError = '';
      reg.pedidofinalError = '';
      List<String> pedidos = state()
              .fechasFEM
              ?.fechasFemDateBoolList
              .where((e) => e.estado)
              .map((e) => e.pedido)
              .toList() ??
          [];
      if (reg.pedidofinal.isEmpty ||
          !pedidos.any((e) => e == reg.pedidofinal)) {
        reg.pedidofinalColor = Colors.red;
        reg.pedidofinalError = "Pedido No activo";
      }
      int disponibleNomalizado = reg.disponible < 0 ? 0 : reg.disponible;
      if (reg.ctdp > 0 &&
          disponibleNomalizado < reg.ctdp &&
          reg.planificado < reg.ctdp) {
        reg.ctdpColor = Colors.red;
        reg.ctdpError =
            "Superior a disponible: ${reg.disponible} ${reg.um}, o planificadoDisponible: ${reg.planificado} ${reg.um}\n planificadoOrignal: ${reg.planificadoOriginal} - Agendado: ${reg.agendado}";
      }
    }
  }
}
