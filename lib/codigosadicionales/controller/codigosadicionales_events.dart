part of '../../bloc/main_bloc.dart';

class SaveCodigoAdicional extends MainEvent {
  final CodigoAdicional codigoAdicional;
  SaveCodigoAdicional({
    required this.codigoAdicional,
  });
}