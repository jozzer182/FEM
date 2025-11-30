import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/main_bloc.dart';
import '../../../codigosoficiales/model/codigosoficiales_model.dart';
import '../../../mm60/model/mm60_model.dart';
import '../../../resources/field_pre/field_pre_texto.dart';
import '../../controller/codigosconcomplementos_controller.dart';
import '../../model/codigosconcomplementos_model.dart';

class CodigosConComplementosEdit extends StatefulWidget {
  final CodigosConComplementosSingle? codigosConComplementosSingle;
  const CodigosConComplementosEdit({
    this.codigosConComplementosSingle,
    super.key,
  });

  @override
  State<CodigosConComplementosEdit> createState() =>
      _CodigosConComplementosEditState();
}

class _CodigosConComplementosEditState
    extends State<CodigosConComplementosEdit> {
  bool esNuevo = true;
  String title = 'Nuevo Código Adicional';
  List<String> ntList = [];
  List<String> familias = [];
  List<String> umList = [];

  final focusNodeFamilia = FocusNode();
  final focusNodeNt = FocusNode();
  final focusNodeUm = FocusNode();
  late final UniqueKey keyField;

  @override
  void initState() {
    if (widget.codigosConComplementosSingle != null) {
      esNuevo = false;
      title = 'Editar Código Adicional';
      context
          .read<MainBloc>()
          .codigosConComplementosController()
          .onEditCodigosConComplementosSingle(
            value: "",
            tipo: CodigosConComplementosSingleTipo.e4e,
            codigosConComplementosSingle: widget.codigosConComplementosSingle!,
          );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 500,
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            bool isReady =
                state.codigosConComplementos != null && state.mm60 != null;
            if (!isReady) {
              return const Center(child: CircularProgressIndicator());
            }
            CodigosConComplementos codigosConComplementos =
                state.codigosConComplementos!;
            CodigosConComplementosSingle codigosConComplementosEdit =
                codigosConComplementos.nuevo;
            List<Mm60Single> mm60 = state.mm60!.mm60List;
            List<CodigoOficial> codigosOficiales =
                state.codigosOficiales!.codigosOficiales;
            familias = codigosOficiales.map((e) => e.familia).toSet().toList()
              ..sort();
            ntList = mm60.map((e) => e.tpmt).toSet().toList()..sort();
            umList = mm60.map((e) => e.um).toSet().toList()..sort();
            CodigosConComplementosController controller =
                context.read<MainBloc>().codigosConComplementosController();

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(4),
                if (esNuevo)
                  const SizedBox.shrink()
                else
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          context
                              .read<MainBloc>()
                              .codigosConComplementosController()
                              .onDeleteCodigosConComplementosSingle();
                          Navigator.pop(context);
                        },
                        child: const Tooltip(
                          message: 'Acción Inmediata',
                          child: Text(
                            'Eliminar Código Por Aprobar',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                const Gap(16),
                Row(
                  children: [
                    FieldTexto(
                      flex: 1,
                      edit: esNuevo,
                      label: "Código",
                      isNumber: true,
                      initialValue: codigosConComplementosEdit.e4e,
                      errorText: codigosConComplementosEdit.e4eError,
                      asignarValor: (value) {
                        controller.onEditCodigosConComplementosSingle(
                          value: value,
                          tipo: CodigosConComplementosSingleTipo.e4e,
                        );
                      },
                    ),
                    const Gap(10),
                    FieldTexto(
                      flex: 4,
                      edit: true,
                      label: 'Descripción',
                      initialValue: codigosConComplementosEdit.descripcion,
                      asignarValor: (value) {
                        controller.onEditCodigosConComplementosSingle(
                          value: value,
                          tipo: CodigosConComplementosSingleTipo.descripcion,
                        );
                      },
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    FieldTexto(
                      flex: 4,
                      edit: true,
                      label: 'Familia',
                      opciones: familias,
                      initialValue: codigosConComplementosEdit.familia,
                      errorText: codigosConComplementosEdit.familiaError,
                      asignarValor: (value) {
                        controller.onEditCodigosConComplementosSingle(
                          value: value,
                          tipo: CodigosConComplementosSingleTipo.familia,
                        );
                      },
                    ),
                    const Gap(10),
                    FieldTexto(
                      flex: 1,
                      edit: true,
                      label: 'NT',
                      opciones: ntList,
                      initialValue: codigosConComplementosEdit.nt,
                      errorText: codigosConComplementosEdit.ntError,
                      asignarValor: (value) {
                        controller.onEditCodigosConComplementosSingle(
                          value: value,
                          tipo: CodigosConComplementosSingleTipo.nt,
                        );
                      },
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    FieldTexto(
                      flex: 1,
                      label: 'UM',
                      edit: true,
                      opciones: umList,
                      initialValue: codigosConComplementosEdit.um,
                      errorText: codigosConComplementosEdit.umError,
                      asignarValor: (value) {
                        controller.onEditCodigosConComplementosSingle(
                          value: value,
                          tipo: CodigosConComplementosSingleTipo.um,
                        );
                      },
                    ),
                    const Gap(10),
                    FieldTexto(
                      flex: 1,
                      edit: true,
                      label: 'Precio',
                      isCurrency: true,
                      initialValue: codigosConComplementosEdit.precio,
                      errorText: codigosConComplementosEdit.precioError,
                      asignarValor: (value) {
                        controller.onEditCodigosConComplementosSingle(
                          value: value,
                          tipo: CodigosConComplementosSingleTipo.precio,
                        );
                      },
                    ),
                    const Gap(10),
                    FieldTexto(
                      flex: 1,
                      edit: true,
                      label: 'Norma',
                      initialValue: codigosConComplementosEdit.norma,
                      asignarValor: (value) {
                        controller.onEditCodigosConComplementosSingle(
                          value: value,
                          tipo: CodigosConComplementosSingleTipo.norma,
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: context
                  .select<MainBloc, CodigosConComplementos>(
                      (value) => value.state.codigosConComplementos!)
                  .nuevo
                  .esValido
              ? () {
                  context
                      .read<MainBloc>()
                      .codigosConComplementosController()
                      .onSaveCodigosConComplementosSingle(esNuevo);
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
