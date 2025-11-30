
import '../../../../bloc/main__bl.dart';
import '../../../../bloc/main_bloc.dart';
import '../../model/solpe_doc.dart';
import '../../model/solpe_reg.dart';
import 'ctrl_ficha_pegar_excel.dart';
import 'email_controller.dart';
import 'reglas/solpe_doc_reglas.dart';
import 'solpe_doc_campo_controller.dart';
import 'solpe_doc_enviar.dart';
import 'solpe_doc_list_controller.dart';

class SolPeDocController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  late SolPeDoc solPeDoc;

  SolPeDocController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    solPeDoc = state().solPeDoc!;
  }

  get editChanger {
    solPeDoc.editar = !solPeDoc.editar;
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  get setSecure {
    solPeDoc.listSecure.clear();
    solPeDoc.listSecure = solPeDoc.list.map((e) => e.copyWith()).toList();
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  get revertSecure {
    solPeDoc.list.clear();
    solPeDoc.list = solPeDoc.listSecure.map((e) => e.copyWith()).toList();
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  get setNuevo {
    solPeDoc.esNuevo = true;
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  void setRazon(String razon) {
    for (SolPeReg reg in solPeDoc.list) {
      reg.enelcomentario = razon;
    }
    emit(state().copyWith(solPeDoc: solPeDoc));
  }

  SolPeDocListController get list => SolPeDocListController(bl);
  SolPeDocCampoController get campo => SolPeDocCampoController(bl);
  CtrlSolPePegarExcel get pegar => CtrlSolPePegarExcel(bl);
  EmailListController get email => EmailListController(bl);
  SolpeReglasController get reglas => SolpeReglasController(bl);
  SolPeDocEnviarController get enviar => SolPeDocEnviarController(bl);
}
