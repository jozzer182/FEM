// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:fem_app/disponibilidad/model/disponibilidad_model.dart';
import 'package:fem_app/resources/a_entero_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../codigoshabilitados/model/codigoshabilitados_model.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';

class DisponibilidadPage extends StatefulWidget {
  const DisponibilidadPage({
    super.key,
  });

  @override
  State<DisponibilidadPage> createState() => _DisponibilidadPageState();
}

class _DisponibilidadPageState extends State<DisponibilidadPage> {
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
        title: const Text('Disponibilidad'),
        actions: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.disponibilidad == null) {
                return const SizedBox();
              }
              return ElevatedButton(
                onPressed: () {
                  DescargaHojas().ahora(
                    datos: state.disponibilidad!.disponibilidadMesList,
                    nombre: 'Disponibilidad por Mes',
                  );
                },
                child: const Text(
                  'Descarga\nPor Mes',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: BlocSelector<MainBloc, MainState, Disponibilidad?>(
        selector: (state) => state.disponibilidad,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahora(
                datos: state.disponibilidadList,
                nombre: 'Disponibilidad',
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
              List<ToCelda> titles = state.disponibilidad!.titles;
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
                if (state.disponibilidad == null ||
                    firstTimeLoading ||
                    state.codigosHabilitados == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<CodigoHabilitado> codigosHabilitados =
                    state.codigosHabilitados!.codigoshabilitados;
                List<DisponibilidadSingle> disponibilidadList =
                    state.disponibilidad!.disponibilidadList;
                disponibilidadList = disponibilidadList
                    .where(
                      (e) => e.toList().any(
                            (el) => el.toLowerCase().contains(
                                  filter.toLowerCase(),
                                ),
                          ),
                    )
                    .toList();
                if (disponibilidadList.length > endList) {
                  disponibilidadList = disponibilidadList.sublist(0, endList);
                }
                return SingleChildScrollView(
                  controller: _controller,
                  child: SelectableRegion(
                    focusNode: FocusNode(),
                    selectionControls: emptyTextSelectionControls,
                    child: Column(
                      children: [
                        for (DisponibilidadSingle disponibilidad
                            in disponibilidadList)
                          Builder(builder: (context) {
                            Color? colorFila;
                            Color? colorTexto;
                            int total = aEntero(disponibilidad.total);
                            int fem = aEntero(disponibilidad.fem);
                            int plataforma = aEntero(disponibilidad.plataforma);
                            int oe = aEntero(disponibilidad.oe);
                            int otros = aEntero(disponibilidad.otros);
                            bool noHayDisponibilidad = total <= 0;
                            bool noEsFem = fem == 0;
                            bool esVacio = plataforma == 0 &&
                                oe == 0 &&
                                otros == 0 &&
                                fem == 0;
                            bool esHabilitado = codigosHabilitados.any(
                                (element) => element.e4e == disponibilidad.e4e);
                            if (esVacio) {
                              colorFila = Colors.grey[300];
                              colorTexto = Colors.grey[500];
                            } else if (noHayDisponibilidad && noEsFem) {
                              colorFila = Colors.orange[100];
                            } else if (noHayDisponibilidad) {
                              colorFila = Colors.red[100];
                            }
                            if (!esHabilitado) {
                              colorTexto ??= Colors.red[900];
                            }
                            return Container(
                              color: colorFila,
                              child: Row(
                                children: [
                                  for (ToCelda celda in disponibilidad.celdas)
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
