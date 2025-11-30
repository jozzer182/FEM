import '../../ficha_ficha/model/ficha_reg/reg.dart';
import 'solpe_reg.dart';

class SolPeDoc {
  List<SolPeReg> list = [];
  List<SolPeReg> listSecure = [];
  List<FichaReg> original = [];
  List<FichaReg> modificada = [];
  List<FichaReg> eliminados = [];
  bool editar = false;
  bool esNuevo = false;
  List<String> destinatarios = [];
  String razon = "";
  SolPeDoc({
    required this.list,
  });
}
