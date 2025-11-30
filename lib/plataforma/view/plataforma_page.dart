// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:fem_app/plataforma/model/plataforma_model.dart';
import 'package:statistics/statistics.dart';

import '../../bloc/main_bloc.dart';
import '../../codigoshabilitados/model/codigoshabilitados_model.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';

class PlataformaPage extends StatefulWidget {
  const PlataformaPage({super.key});

  @override
  State<PlataformaPage> createState() => _PlataformaPageState();
}

class _PlataformaPageState extends State<PlataformaPage> {
  String filter = '';
  int endList = 70;
  bool firstTimeLoading = true;
  final ScrollController _controller = ScrollController();
  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        endList += 70;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        firstTimeLoading = false;
      });
    });
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plataforma'),
        actions: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.plataforma == null || firstTimeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                String fechaActualizacion =
                    state.plataforma!.plataformaList.first.actualizado;
                DateTime fecha = DateTime.parse(fechaActualizacion);
                return Center(
                  child: Text(
                    'Actualizado:' +
                        '\n${fecha.day.toStringPadded(2)}/${fecha.month.toStringPadded(2)}/${fecha.year}' +
                        '\n${fecha.hour.toStringPadded(2)}:${fecha.minute.toStringPadded(2)}',
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
          ),
          const Gap(5),
        ],
      ),
      floatingActionButton: BlocSelector<MainBloc, MainState, Plataforma?>(
        selector: (state) => state.plataforma,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahora(
                datos: state.plataformaList,
                nombre: 'Plataforma',
              ),
              child: const Icon(Icons.download),
            );
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Búsqueda',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(5),
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              List<ToCelda> titles = state.plataforma!.titles;
              return Row(
                children: [
                  for (ToCelda celda in titles)
                    Expanded(
                      flex: celda.flex,
                      child: Text(
                        celda.valor,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const Gap(5),
          Expanded(
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state.plataforma == null || firstTimeLoading || state.codigosHabilitados == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<CodigoHabilitado> codigosHabilitados =
                    state.codigosHabilitados!.codigoshabilitados;
                List<PlataformaSingle> plataformaList =
                    state.plataforma!.plataformaList;
                plataformaList = plataformaList
                    .where(
                      (e) => e.toList().any(
                            (el) => el.toLowerCase().contains(
                                  filter.toLowerCase(),
                                ),
                          ),
                    )
                    .toList();
                if (plataformaList.length > endList) {
                  plataformaList = plataformaList.sublist(0, endList);
                }
                return SingleChildScrollView(
                  controller: _controller,
                  child: SelectableRegion(
                    focusNode: FocusNode(),
                    selectionControls: emptyTextSelectionControls,
                    child: Column(
                      children: [
                        for (PlataformaSingle plataforma in plataformaList)
                          Builder(builder: (context) {
                            String status = plataforma.status;
                            bool isCtec = status.toLowerCase().contains('ctec');
                            bool isBloc = status.toLowerCase().contains('bloc');
                            bool esHabilitado = codigosHabilitados.any(
                                (element) => element.e4e == plataforma.material);
                            Color? color;
                            Color? colorTexto;
                            if (isBloc || isCtec) {
                              color = Colors.red[100];
                            } else if(!esHabilitado){
                              colorTexto = Colors.red[900];
                            }
                            return Container(
                              color: color,
                              child: Row(
                                children: [
                                  for (ToCelda celda in plataforma.celdas)
                                    Expanded(
                                      flex: celda.flex,
                                      child: Text(
                                        celda.valor,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: colorTexto,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
