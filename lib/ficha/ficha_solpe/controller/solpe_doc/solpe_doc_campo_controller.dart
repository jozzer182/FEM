import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';

import '../../../../motor_detector_cambios/motor_detector_cambios_ficha_reg.dart';
import '../../../ficha_ficha/model/ficha_reg/reg.dart';
import '../../model/solpe_doc.dart';
import '../../model/solpe_reg.dart';
import '../../model/solpe_reg_enum.dart';
import 'reglas/solpe_doc_reglas.dart';

class SolPeDocCampoController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late SolPeDoc solPeDoc;

  SolPeDocCampoController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    solPeDoc = state().solPeDoc!;
  }

  cambiar({
    required CampoSolpe tipo,
    required String value,
    required int index,
  }) {
    if (index >= 0) {
      solPeDoc.list[index].setWithEnum(tipo: tipo, value: value);
      SolPeReg reg = solPeDoc.list[index];
      print(reg.id);
      if (tipo == CampoSolpe.ctdp) {
        String mes = reg.pedidofinal.substring(0, 2);
        String quincena = reg.pedidofinal.substring(6, 7);
        FichaReg fichaRegModificada =
            solPeDoc.modificada.firstWhere((e) => e.idSolpe == reg.id);
        fichaRegModificada.setWithQuincena('$mes-$quincena', value);
        FichaReg fichaReg =
            solPeDoc.original.firstWhere((e) => e.idSolpe == reg.id);
        if (fichaReg.estado != "nuevo") {
          String cambio = detectorCambiosFicha(
            newFEM: fichaRegModificada,
            oldFEM: fichaReg,
          );
          solPeDoc.eliminados
              .firstWhere((e) => e.idSolpe == reg.id)
              .log
              .cambio = cambio;
        }
        print(solPeDoc.modificada.firstWhere((e) => e.idSolpe == reg.id));
      }
    } else {
      for (SolPeReg reg in solPeDoc.list) {
        reg.setWithEnum(tipo: tipo, value: value);
      }
    }
    if (tipo == CampoSolpe.pedidofinal) {
      reglas.init;
    } else {
      reglas.recurrentes;
    }
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  SolpeReglasController get reglas => SolpeReglasController(bl);
}
