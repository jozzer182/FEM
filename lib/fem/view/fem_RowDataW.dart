import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/fem/view/dialogs/fem_Selec_cantidadFEM.dart';
// ignore: unused_import
import 'package:fem_app/fem/model/fem_model.dart';
import 'package:fem_app/fem/view/dialogs/fem_selec_pdi_page.dart';
import 'package:fem_app/fem/view/dialogs/fem_selec_type_page.dart';
import 'package:fem_app/fem/view/dialogs/fem_selec_wbe_page.dart';

import '../model/fem_model_single_fem.dart';

class RowDataW extends StatefulWidget {
  const RowDataW({
    super.key,
    required this.dataW,
    required this.confirmarDespacho,
    required this.pedidoSeleccionado,
    required this.pedido,
    required this.year,
  });

  final SingleFEM dataW;
  final String year;
  final bool confirmarDespacho;
  final String pedido;
  final String pedidoSeleccionado;

  @override
  State<RowDataW> createState() => _RowDataWState();
}

class _RowDataWState extends State<RowDataW> {
  bool editRow = false;
  aEntero(String valor) {
    if (valor == '') {
      return 0;
    } else {
      return int.parse(valor);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('build RowDataW');
    //       print('pedidoSeleccionado: ${widget.pedidoSeleccionado}');
    return InkWell(
      onTap: () async {
        // print(widget.dataW);
        if (editRow) {
          context.read<MainBloc>().add(
                ModFemDB(
                  singleFEM: widget.dataW,
                  year: widget.year,
                ),
              );
          await FirebaseAnalytics.instance.logSelectItem(
            itemListId: widget.dataW.id,
            itemListName: widget.dataW.descripcion,
          );
        } else {
          //necesitamos calcular el total antes de cambios y guardarlo
          context.read<MainBloc>().add(
                HoldCtd(
                  singleFEM: widget.dataW,
                  year: widget.year,
                ),
              );
        }
        setState(() {
          editRow = !editRow;
        });
      },
      child: Container(
        color:
            widget.dataW.estdespacho == widget.pedido ? Colors.grey[200] : null,
        child: Builder(builder: (context) {
          List<Widget> row = [];
          if (widget.confirmarDespacho) {
            Map data = widget.dataW
                .asRowDespacho2(pedidoSeleccionado: widget.pedidoSeleccionado);
            data.forEach(
              (k, v) {
                // print(k);
                switch (k) {
                  case 'Q':
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: Center(
                          child: editRow
                              ? SizedBox(
                                  height: 20,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return ChangeMsg(
                                            mes: widget.pedidoSeleccionado
                                                .substring(0, 2),
                                            year: widget.year,
                                            singleFEM: widget.dataW,
                                          );
                                        }),
                                      );
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller:
                                          TextEditingController(text: v[0]),
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: const InputDecoration(
                                        suffixIconConstraints: BoxConstraints(
                                            minWidth: 0, minHeight: 0),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  v[0],
                                  style: const TextStyle(fontSize: 12),
                                ),
                        ),
                      ),
                    );
                    break;
                  case 'A':
                    var objeto = jsonDecode(v[0]);
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: BlocBuilder<MainBloc, MainState>(
                          builder: (context, state) {
                            // String dataDespacho = state.fechas!.fechasList
                            //     .where((e) => e.estadoPed == 'ACTUAL')
                            //     .first
                            //     .pedido;
                            // PdisSingle pdi = state.pdis!.pdisList.firstWhere(
                            //     (e) => e.lote == widget.dataW.pdi,
                            //     orElse: () => PdisSingle.fromZero());
                            // WbeSingle wbe = state.wbe!.wbeList.firstWhere(
                            //     (e) => e.wbe == widget.dataW.wbe,
                            //     orElse: () => WbeSingle.fromZero());

                            if (editRow == true ||
                                widget.dataW.pdi == '' ||
                                aEntero(data['Q'][0]) < 1)
                              return const SizedBox();
                            if (objeto[0][widget.pedidoSeleccionado] == '0') {
                              return IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  size: 20,
                                ),
                                onPressed: () {
                                  BlocProvider.of<MainBloc>(context).add(
                                    AddCesta(
                                      pedido: widget.pedidoSeleccionado,
                                      singleFEM: widget.dataW,
                                      year: widget.year,
                                      isSingle: true,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  size: 20,
                                ),
                                onPressed: () {
                                  BlocProvider.of<MainBloc>(context).add(
                                    DeleteCesta(
                                      pedido: widget.pedidoSeleccionado,
                                      singleFEM: widget.dataW,
                                      id: widget.dataW.id,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    );
                    break;
                  case 'PDI':
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: !editRow
                            ? Text(
                                v[0],
                                style: const TextStyle(fontSize: 12),
                              )
                            : SizedBox(
                                height: 20,
                                child: InkWell(
                                  onTap: () {
                                    // print('PDI');
                                    showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return SelectPdiPage(
                                          year: widget.year,
                                          singleFEM: widget.dataW,
                                        );
                                      }),
                                    );
                                  },
                                  child: TextField(
                                    enabled: false,
                                    controller:
                                        TextEditingController(text: v[0]),
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    );
                    break;
                  case 'WBE':
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: !editRow
                            ? Text(
                                v[0],
                                style: const TextStyle(fontSize: 12),
                              )
                            : SizedBox(
                                height: 20,
                                child: InkWell(
                                  onTap: () {
                                    // print('PDI');
                                    showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return SelectWbePage(
                                          year: widget.year,
                                          singleFEM: widget.dataW,
                                        );
                                      }),
                                    );
                                  },
                                  child: TextField(
                                    enabled: false,
                                    controller:
                                        TextEditingController(text: v[0]),
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      suffixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    );
                    break;
                  case 'Comentario':
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: !editRow
                            ? Text(
                                v[0].toString(),
                                style: const TextStyle(fontSize: 12),
                              )
                            : SizedBox(
                                height: 20,
                                child: TextFormField(
                                  initialValue: v[0].toString(),
                                  // controller: _comentarioController,
                                  style: const TextStyle(fontSize: 12),
                                  onChanged: (value) {
                                    context.read<MainBloc>().add(
                                          ModFemList(
                                            year: widget.year,
                                            singleFEM: widget.dataW,
                                            field: 'comentario',
                                            value: value,
                                          ),
                                        );
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    suffixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    );
                    break;
                  case 'Causar?':
                    v[0] = v[0] == 'SI' ? 'SI' : 'NO';
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: !editRow
                            ? Center(
                                child: Text(
                                  v[0].toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )
                            : SizedBox(
                                height: 20,
                                child:                                 
                                DropdownButtonFormField<String>(
                                  value: v[0].toString(),
                                  style: const TextStyle(fontSize: 11),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    context.read<MainBloc>().add(
                                          ModFemList(
                                            year: widget.year,
                                            singleFEM: widget.dataW,
                                            field: 'proyecto',
                                            value: newValue ?? 'NO',
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
                    );
                    break;
                  case 'Cto':
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: !editRow
                            ? Text(
                                v[0].toString(),
                                style: const TextStyle(fontSize: 12),
                              )
                            : SizedBox(
                                height: 20,
                                child: TextFormField(
                                  initialValue: v[0].toString(),
                                  // controller: _comentarioController,
                                  style: const TextStyle(fontSize: 12),
                                  onChanged: (value) {
                                    context.read<MainBloc>().add(
                                          ModFemList(
                                            year: widget.year,
                                            singleFEM: widget.dataW,
                                            field: 'cto',
                                            value: value,
                                          ),
                                        );
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    suffixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    );
                    break;
                  case 'Tipo':
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: !editRow
                            ? Builder(builder: (context) {
                                switch (v[0]) {
                                  case 'PDI':
                                    return const Icon(Icons.location_city);
                                  case 'PLATAFORMA':
                                    return const Icon(Icons.train);
                                  default:
                                    return const Icon(Icons.question_mark);
                                }
                              })
                            : Builder(builder: (context) {
                                switch (v[0]) {
                                  case 'PDI':
                                    return IconButton(
                                        icon: const Icon(Icons.location_city),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return SelectTypePage(
                                                year: widget.year,
                                                singleFEM: widget.dataW,
                                              );
                                            }),
                                          );
                                        });
                                  case 'PLATAFORMA':
                                    return IconButton(
                                        icon: const Icon(Icons.train),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return SelectTypePage(
                                                year: widget.year,
                                                singleFEM: widget.dataW,
                                              );
                                            }),
                                          );
                                        });
                                  default:
                                    return IconButton(
                                        icon: const Icon(Icons.question_mark),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return SelectTypePage(
                                                year: widget.year,
                                                singleFEM: widget.dataW,
                                              );
                                            }),
                                          );
                                        });
                                }
                              }),
                      ),
                    );
                    break;
                  default:
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: Text(
                          v[0],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                }
              },
            );
          } else {
            widget.dataW.asRow.forEach(
              (k, v) {
                switch (k) {
                  case '01':
                  case '02':
                  case '03':
                  case '04':
                  case '05':
                  case '06':
                  case '07':
                  case '08':
                  case '09':
                  case '10':
                  case '11':
                  case '12':
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: Center(
                          child: editRow
                              ? SizedBox(
                                  height: 20,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return ChangeMsg(
                                            mes: k,
                                            year: widget.year,
                                            singleFEM: widget.dataW,
                                          );
                                        }),
                                      );
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller:
                                          TextEditingController(text: v[0]),
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: const InputDecoration(
                                        suffixIconConstraints: BoxConstraints(
                                            minWidth: 0, minHeight: 0),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  v[0],
                                  style: const TextStyle(fontSize: 12),
                                ),
                        ),
                      ),
                    );
                    break;
                  case 'Cto':
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: !editRow
                            ? Text(
                                v[0].toString(),
                                style: const TextStyle(fontSize: 12),
                              )
                            : SizedBox(
                                height: 20,
                                child: TextFormField(
                                  initialValue: v[0].toString(),
                                  // controller: _comentarioController,
                                  style: const TextStyle(fontSize: 12),
                                  onChanged: (value) {
                                    context.read<MainBloc>().add(
                                          ModFemList(
                                            year: widget.year,
                                            singleFEM: widget.dataW,
                                            field: 'cto',
                                            value: value,
                                          ),
                                        );
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    suffixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    );
                    break;
                  default:
                    row.add(
                      Expanded(
                        flex: v[1],
                        child: Text(
                          v[0],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                }
              },
            );
          }
          return Row(
            children: row,
          );
        }),
      ),
    );
  }
}
