import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/extratemp/model/extra_model.dart';
import 'package:fem_app/extratemp/view/extra_x_tipo.dart';
import 'package:fem_app/nuevo/view/nuevo_x_pdi.dart';
import 'package:fem_app/nuevo/view/nuevo_x_wbe.dart';

class ListExtra extends StatefulWidget {
  const ListExtra({super.key});

  @override
  State<ListExtra> createState() => _ListExtraState();
}

class _ListExtraState extends State<ListExtra> {
  final uSFormat = NumberFormat.currency(
    locale: "en_US",
    symbol: "\$",
    decimalDigits: 0,
    // customPattern: "\$#,##0 M",
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        var data = state.extra!;
        List<SingleExtra> lista = state.extra?.extraList ?? [];
        double wiBetwMainFields = 2.0;
        // List<EnableDate> meses = state.nuevo?.enableDates ?? [];
        if (state.extra!.encabezado.proyecto.isEmpty ||
            state.extra!.encabezado.pm.isEmpty) {
          return const Text('Por favor seleccione un año, proyecto y PM');
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: lista.length,
            itemBuilder: (context, index) {
              SingleExtra item = lista[index];

              return Padding(
                key: ValueKey(index),
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Text(
                                lista[index].index.toString(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // SizedBox(width: wiBetwMainFields),
                              // Expanded(
                              //   flex: 1,
                              //   child: TextFormField(
                              //     style: TextStyle(fontSize: 13),
                              //     onChanged: (value) {
                              //       context.read<MainBloc>().add(
                              //             ModNuevo(
                              //               tabla: 'extraList',
                              //               campo: 'circuito',
                              //               valor: value.toString(),
                              //               index: index,
                              //             ),
                              //           );
                              //     },
                              //     decoration: InputDecoration(
                              //       contentPadding:
                              //           EdgeInsets.symmetric(horizontal: 10),
                              //       border: OutlineInputBorder(),
                              //       labelText: 'Circuito',
                              //       labelStyle: TextStyle(fontSize: 13),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(width: wiBetwMainFields),
                              Expanded(
                                flex: 1,
                                child: Autocomplete<String>(
                                  displayStringForOption: (option) {
                                    return option;
                                  },
                                  optionsBuilder: (textEditingValue) {
                                    var op2022 = context
                                        .read<MainBloc>()
                                        .state
                                        .fem!
                                        .f2022
                                        .where((e) => e.circuito
                                            .toLowerCase()
                                            .contains(textEditingValue.text
                                                .toLowerCase()))
                                        .map((e) => e.circuito.trim())
                                        .toSet()
                                        .toList();
                                    var op2023 = context
                                        .read<MainBloc>()
                                        .state
                                        .fem!
                                        .f2023
                                        .where((e) => e.circuito
                                            .toLowerCase()
                                            .contains(textEditingValue.text
                                                .toLowerCase()))
                                        .map((e) => e.circuito.trim())
                                        .toSet()
                                        .toList();
                                    var op2024 = context
                                        .read<MainBloc>()
                                        .state
                                        .fem!
                                        .f2024
                                        .where((e) => e.circuito
                                            .toLowerCase()
                                            .contains(textEditingValue.text
                                                .toLowerCase()))
                                        .map((e) => e.circuito.trim())
                                        .toSet()
                                        .toList();
                                    var op2025 = context
                                        .read<MainBloc>()
                                        .state
                                        .fem!
                                        .f2025
                                        .where((e) => e.circuito
                                            .toLowerCase()
                                            .contains(textEditingValue.text
                                                .toLowerCase()))
                                        .map((e) => e.circuito.trim())
                                        .toSet()
                                        .toList();
                                    var optionsX = [
                                      ...op2022,
                                      ...op2023,
                                      ...op2024,
                                      ...op2025
                                    ].toSet().toList();
                                    optionsX.sort();
                                    return optionsX;
                                  },
                                  optionsViewBuilder:
                                      (context, onSelected, options) {
                                    return Material(
                                      child: ListView.builder(
                                        itemCount: options.length,
                                        itemBuilder: (context, i) {
                                          String option = options.toList()[i];
                                          return ListTile(
                                            title: Text(option,
                                                style: TextStyle(fontSize: 14)),
                                            onTap: () {
                                              onSelected(options.toList()[i]);
                                              context.read<MainBloc>().add(
                                                    ModNuevo(
                                                      tabla: 'extraList',
                                                      campo: 'circuito',
                                                      valor: option.toString(),
                                                      index: index,
                                                    ),
                                                  );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  fieldViewBuilder: (context,
                                      textEditingController,
                                      focusNode,
                                      onFieldSubmitted) {
                                    return TextField(
                                      controller:
                                          textEditingController, // Required by autocomplete
                                      focusNode:
                                          focusNode, // Required by autocomplete
                                      onChanged: (value) {
                                        context.read<MainBloc>().add(
                                              ModNuevo(
                                                tabla: 'extraList',
                                                campo: 'circuito',
                                                valor: value.toString(),
                                                index: index,
                                              ),
                                            );
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        border: OutlineInputBorder(),
                                        labelText: 'Circuito',
                                        labelStyle: TextStyle(fontSize: 13),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: wiBetwMainFields),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  initialValue: item.e4e,
                                  onChanged: (value) {
                                    context.read<MainBloc>().add(
                                          ModNuevo(
                                            tabla: 'extraList',
                                            campo: 'e4e',
                                            valor: value.toString(),
                                            index: index,
                                          ),
                                        );
                                  },
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder(),
                                    labelText: 'E4e',
                                    labelStyle: TextStyle(fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: item.e4eError,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: item.e4eError,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: wiBetwMainFields),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  item.descripcion,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              SizedBox(width: wiBetwMainFields),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  item.um,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              SizedBox(width: wiBetwMainFields),
                              Builder(builder: (context) {
                                if (item.wbeError == Colors.red ||
                                    item.wbeError == Colors.green ||
                                    item.wbeError == Colors.orange) {
                                  return Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: TextFormField(
                                            enabled: item.wbeError ==
                                                    Colors.red ||
                                                item.wbeError == Colors.green ||
                                                item.wbeError == Colors.orange,
                                            controller: TextEditingController(
                                                text: item.wbe),
                                            style: TextStyle(fontSize: 13),
                                            readOnly: true,
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return SelectWbeNuevoPage(
                                                    index: index,
                                                    e4e: item.e4e,
                                                    table: 'extraList',
                                                  );
                                                }),
                                              );
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              border: OutlineInputBorder(),
                                              labelText: 'wbe',
                                              labelStyle:
                                                  TextStyle(fontSize: 13),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: item.wbeError,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: item.wbeError,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: wiBetwMainFields),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            item.wbeproyecto,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return SizedBox();
                              }),
                              SizedBox(width: wiBetwMainFields),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller:
                                      TextEditingController(text: item.pdi),
                                  readOnly: true,
                                  style: TextStyle(fontSize: 13),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return SelectPdiNuevo(
                                          index: index,
                                          table: 'extraList',
                                        );
                                      }),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder(),
                                    labelText: 'pdi',
                                    labelStyle: TextStyle(fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: item.pdiError,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: item.pdiError,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: wiBetwMainFields),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: TextEditingController(
                                      text: item.tipoenvio),
                                  readOnly: true,
                                  style: TextStyle(fontSize: 13),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return SelectTypePageX(
                                          index: index,
                                        );
                                      }),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder(),
                                    labelText: 'tipo',
                                    labelStyle: TextStyle(fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: item.tipoenvioError,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: item.tipoenvioError,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: wiBetwMainFields),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  initialValue: item.comentario2,
                                  onChanged: (value) {
                                    context.read<MainBloc>().add(
                                          ModNuevo(
                                            tabla: 'extraList',
                                            campo: 'comentario2',
                                            valor: value.toString(),
                                            index: index,
                                          ),
                                        );
                                  },
                                  style: TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: OutlineInputBorder(),
                                    labelText: 'comentario2',
                                    labelStyle: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Builder(builder: (context) {
                          // print('item.e4e ${item.e4e}');
                          // print('item.e4e.length != 6 ${item.e4e.length != 6 }');
                          // print('item.mensaje ${item.mensaje}');
                          if (item.e4e.length != 6) return SizedBox();
                          if (item.mensaje.length > 0 &&
                              item.mensaje.substring(0, 1) == '*') {
                            return Row(
                              children: [
                                Text(
                                  item.mensaje,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            );
                          }
                          return SizedBox(
                            // height: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 100,
                                      height: 30,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        style: TextStyle(fontSize: 11),
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: OutlineInputBorder(),
                                          labelText: data.pedido,
                                          labelStyle: TextStyle(
                                            fontSize: 10,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: item.ctdError,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: item.ctdError,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          context.read<MainBloc>().add(
                                                ModNuevo(
                                                  tabla: 'extraList',
                                                  campo: 'ctd',
                                                  valor: value.toString(),
                                                  index: index,
                                                ),
                                              );
                                        },
                                      ),
                                    ),
                                    const Gap(10),
                                    SizedBox(
                                      width: 100,
                                      height: 30,
                                      child: Tooltip(
                                        message:
                                            'Si es positivo no ingresará a inventario de contratista, se debe informar una WBE en comentario2',
                                        child: DropdownButtonFormField<String>(
                                          value: 'NO',
                                          style: const TextStyle(fontSize: 11),
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text('Causar?'),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 6,
                                            ),
                                          ),
                                          onChanged: (String? newValue) {
                                            context.read<MainBloc>().add(
                                                  ModNuevo(
                                                    tabla: 'extraList',
                                                    campo: 'ctdf',
                                                    valor: newValue.toString(),
                                                    index: index,
                                                  ),
                                                );
                                          },
                                          items: <String>['SI', 'NO']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Row(
                                    children: [
                                      item.mensaje == 'ok'
                                          ? SizedBox()
                                          : Expanded(
                                              child: Text(
                                                item.mensaje,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  fontSize: 10,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                      Expanded(
                                        child: Text(
                                          'Cantidad disponible para versiones cerradas: ${item.disponibles}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 10,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Costo total: ${uSFormat.format(int.parse(item.costo))} COP',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 10,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        item.nuevo,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
