import 'package:fem_app/bloc/main__bl.dart';

import '../codigosadicionales/controller/codigosadicionales_controller.dart';
import '../codigosadicionales/model/codigosadicionales_model.dart';

class Metodos {
  final Bl bl;
  Metodos(this.bl);

  void saveCodigoAdicional({
    required CodigoAdicional codigoAdicional,
  }) {
    onSaveCodigoAdicional(
      bl: bl,
      codigoAdicional: codigoAdicional,
    );
  }

  void deleteCodigoAdicional({
    required CodigoAdicional codigoAdicional,
  }) {
    onDeleteCodigoAdicional(
      bl: bl,
      codigoAdicional: codigoAdicional,
    );
  }
}
