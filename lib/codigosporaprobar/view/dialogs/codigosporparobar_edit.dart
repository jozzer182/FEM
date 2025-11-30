import 'package:fem_app/codigosoficiales/model/codigosoficiales_model.dart';
import 'package:fem_app/codigosporaprobar/model/codigosporaprobar_model.dart';
import 'package:fem_app/mm60/model/mm60_model.dart';
import 'package:fem_app/resources/toCurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../bloc/main_bloc.dart';

class CodigosPoraprobarEdit extends StatefulWidget {
  final CodigoPorAprobar? codigoPorAprobar;
  const CodigosPoraprobarEdit({
    this.codigoPorAprobar,
    super.key,
  });

  @override
  State<CodigosPoraprobarEdit> createState() => _CodigosPoraprobarEditState();
}

class _CodigosPoraprobarEditState extends State<CodigosPoraprobarEdit> {
  bool esNuevo = false;
  String title = 'Editar Código Adicional';
  TextEditingController codigoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController familiaController = TextEditingController();
  TextEditingController ntController = TextEditingController();
  TextEditingController umController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  String precio = '';
  TextEditingController normaController = TextEditingController();
  List<String> ntList = [];
  List<String> familias = [];
  List<String> umList = [];

  String? codigoError;
  String? descripcionError;
  String? familiaError;
  String? ntError;
  String? umError;
  String? precioError;
  String? normaError;

  final focusNodeFamilia = FocusNode();
  final focusNodeNt = FocusNode();
  final focusNodeUm = FocusNode();
  late final key;

  @override
  void initState() {
    if (widget.codigoPorAprobar == null) {
      esNuevo = true;
      title = 'Agregar Código Adicional';
    } else {
      codigoController.text = widget.codigoPorAprobar!.e4e;
      descripcionController.text = widget.codigoPorAprobar!.descripcion;
      familiaController.text = widget.codigoPorAprobar!.familia;
      ntController.text = widget.codigoPorAprobar!.nt;
      umController.text = widget.codigoPorAprobar!.um;
      precio = widget.codigoPorAprobar!.precio;
      normaController.text = widget.codigoPorAprobar!.norma;
    }

    codigoController.addListener(() {
      setState(() {
        validadorCodigo(
            BlocProvider.of<MainBloc>(context)
                .state
                .codigosPorAprobar!
                .codigosPorAprobar,
            BlocProvider.of<MainBloc>(context).state.mm60!.mm60List);
      });
    });

    familiaController.addListener(() {
      setState(() {
        // FocusScope.of(context).requestFocus(focusNodeFamilia);
        validadorFamilia(codigoController.text.length == 6, familias);
      });
    });

    descripcionController.addListener(() {
      setState(() {
        validadorDescripcion(codigoController.text.length == 6);
      });
    });

    ntController.addListener(() {
      setState(() {
        // FocusScope.of(context).requestFocus(focusNodeNt);
        validadorNt(codigoController.text.length == 6, ntList);
      });
    });

    umController.addListener(() {
      setState(() {
        // FocusScope.of(context).requestFocus(focusNodeUm);
        validadorUm(codigoController.text.length == 6, umList);
      });
    });

    precioController.addListener(() {
      setState(() {
        validadorPrecio(codigoController.text.length == 6);
      });
    });

    key = UniqueKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isError = codigoError != null ||
        descripcionError != null ||
        familiaError != null ||
        ntError != null ||
        umError != null ||
        precioError != null ||
        normaError != null;
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 500,
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            bool isReady = state.codigosOficiales != null && state.mm60 != null;
            if (!isReady) {
              return const Center(child: CircularProgressIndicator());
            }
            List<CodigoOficial> codigosOficiales =
                state.codigosOficiales!.codigosOficiales;
            List<Mm60Single> mm60 = state.mm60!.mm60List;
            familias = codigosOficiales.map((e) => e.familia).toSet().toList()
              ..sort();
            ntList = mm60.map((e) => e.tpmt).toSet().toList()..sort();
            umList = mm60.map((e) => e.um).toSet().toList()..sort();
            // print('precio: ${toCurrency(precio)}');
            precioController.value = precioController.value.copyWith(
              text: toCurrency(precio),
              selection:
                  TextSelection.collapsed(offset: toCurrency(precio).length),
            );

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
                          backgroundColor:
                              Colors.red, // Define el color de fondo
                        ),
                        onPressed: () {
                          context
                              .read<MainBloc>()
                              .codigosPorAprobarController()
                              .onDeleteCodigoPorAprobar(
                                codigoPorAprobar: widget.codigoPorAprobar!,
                              );
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
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: codigoController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Código',
                          errorText: codigoError,
                          enabled: esNuevo,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: descripcionController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Descripción',
                          errorText: descripcionError,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: RawAutocomplete<String>(
                        textEditingController: familiaController,
                        focusNode: focusNodeFamilia,
                        key: key,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return familias.where((String option) {
                            return option
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Material(
                            elevation: 4,
                            child: ListView(
                              children: options
                                  .map(
                                    (e) => ListTile(
                                      title: Text(e),
                                      onTap: () {
                                        onSelected(e);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Familia',
                              errorText: familiaError,
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 1,
                      child: RawAutocomplete<String>(
                        textEditingController: ntController,
                        focusNode: focusNodeNt,
                        key: key,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return ntList.where((String option) {
                            return option
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Material(
                            elevation: 4,
                            child: ListView(
                              children: options
                                  .map(
                                    (e) => ListTile(
                                      title: Text(e),
                                      onTap: () {
                                        onSelected(e);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'NT',
                              errorText: ntError,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: RawAutocomplete<String>(
                        textEditingController: umController,
                        focusNode: focusNodeUm,
                        key: key,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return umList.where((String option) {
                            return option
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Material(
                            elevation: 4,
                            child: ListView(
                              children: options
                                  .map(
                                    (e) => ListTile(
                                      title: Text(e),
                                      onTap: () {
                                        onSelected(e);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'um',
                              errorText: umError,
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: precioController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Precio (COP)',
                          errorText: precioError,
                        ),
                        textAlign: TextAlign.end,
                        onChanged: (value) {
                          // precioController.text = toCurrency$(value);
                          setState(() {
                            precio = value;
                          });
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: normaController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Norma',
                          errorText: normaError,
                        ),
                      ),
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
          onPressed: isError
              ? null
              : () {
                  context
                      .read<MainBloc>()
                      .codigosPorAprobarController()
                      .onSaveCodigoPorAprobar(
                        codigoPorAprobar: CodigoPorAprobar(
                          e4e: codigoController.text,
                          descripcion: descripcionController.text,
                          familia: familiaController.text,
                          nt: ntController.text,
                          um: umController.text,
                          precio: precioController.text,
                          norma: normaController.text,
                        ),
                      );
                  Navigator.pop(context);
                },
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  void validadorPrecio(bool esCodigoE4e) {
    if (esCodigoE4e) {
      bool esVacio = precio.isEmpty;
      precioError = esVacio ? 'Requerido' : null;
    }
  }

  void validadorUm(bool esCodigoE4e, List<String> umList) {
    if (esCodigoE4e) {
      bool esUm = umList.contains(umController.text);
      bool esVacio = familiaController.text.isEmpty;
      if (esUm && !esVacio) {
        umError = null;
      } else {
        umError = esVacio ? 'Requerido' : 'UM no existente';
      }
    }
  }

  void validadorNt(bool esCodigoE4e, List<String> ntList) {
    if (esCodigoE4e) {
      bool esNt = ntList.contains(ntController.text);
      bool esVacio = familiaController.text.isEmpty;
      if (esNt && !esVacio) {
        ntError = null;
      } else {
        ntError = esVacio ? 'Requerido' : 'NT no existente';
      }
    }
  }

  void validadorFamilia(bool esCodigoE4e, List<String> familias) {
    if (esCodigoE4e) {
      bool esFamilia = familias.contains(familiaController.text);
      bool esVacio = familiaController.text.isEmpty;
      if (esFamilia && !esVacio) {
        familiaError = null;
      } else {
        familiaError = esVacio ? 'Requerido' : 'Familia no existente';
      }
    }
  }

  void validadorDescripcion(bool esCodigoE4e) {
    if (esCodigoE4e) {
      bool esVacio = descripcionController.text.isEmpty;
      descripcionError = esVacio ? 'Requerido' : null;
    }
  }

  void validadorCodigo(
    List<CodigoPorAprobar> codigosPorAprobar,
    List<Mm60Single> mm60,
  ) {
    bool es6digitos = codigoController.text.length == 6;
    if (!es6digitos && esNuevo) {
      descripcionController.clear();
      ntController.clear();
      umController.clear();
      precioController.clear();
      precio = '';
      familiaController.clear();
    }
    if (es6digitos && esNuevo) {
      CodigoPorAprobar codigoPorAprobar = codigosPorAprobar.firstWhere(
        (e) => e.e4e == codigoController.text,
        orElse: () => CodigoPorAprobar.fromInit(),
      );
      bool esRepetido = codigoPorAprobar.e4e != '';
      if (esRepetido) {
        codigoError = 'Repetido';
        descripcionController.clear();
        ntController.clear();
        umController.clear();
        precioController.clear();
        descripcionError = null;
        ntError = null;
        umError = null;
        precioError = null;
        normaError = null;
        familiaController.clear();
        familiaError = null;
      } else {
        codigoError = null;
        Mm60Single mm60Single = mm60.firstWhere(
            (e) => e.material == codigoController.text,
            orElse: () => Mm60Single.fromInit());
        bool esMm60 = mm60Single.material != '';
        if (esMm60) {
          descripcionController.text = mm60Single.descripcion;
          familiaController.clear();
          ntController.text = mm60Single.tpmt;
          umController.text = mm60Single.um;
          precio = mm60Single.precio;
          descripcionError = null;
          ntError = null;
          umError = null;
          precioError = null;
          normaError = null;
        } else {
          descripcionController.clear();
          ntController.clear();
          umController.clear();
          precioController.clear();
          descripcionError = 'requerido';
          ntError = 'requerido';
          umError = 'requerido';
          precioError = 'requerido';
          // normaError = 'requerido'; //se debe permitir que sea vacio?
        }
        familiaController.clear();
        familiaError = 'requerido';
      }
    }
  }
}
