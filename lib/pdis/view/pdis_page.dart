// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:fem_app/pdis/model/pdis_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';

class PdisPage extends StatefulWidget {
  const PdisPage({
    super.key,
  });

  @override
  State<PdisPage> createState() => _PdisPageState();
}

class _PdisPageState extends State<PdisPage> {
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
        title: const Text('PDIS'),
      ),
      floatingActionButton: BlocSelector<MainBloc, MainState, Pdis?>(
        selector: (state) => state.pdis,
        builder: (context, state) {
          if (state == null) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () => DescargaHojas().ahora(
                datos: state.pdisList,
                nombre: 'PDIS',
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
              List<ToCelda> titles = state.pdis!.titles;
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
                if (state.pdis == null || firstTimeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<PdisSingle> pdisList = state.pdis!.pdisList;
                pdisList = pdisList
                    .where(
                      (e) => e.toList().any(
                            (el) => el.toLowerCase().contains(
                                  filter.toLowerCase(),
                                ),
                          ),
                    )
                    .toList();
                if (pdisList.length > endList) {
                  pdisList = pdisList.sublist(0, endList);
                }
                return SingleChildScrollView(
                  controller: _controller,
                  child: SelectableRegion(
                    focusNode: FocusNode(),
                    selectionControls: emptyTextSelectionControls,
                    child: Column(
                      children: [
                        for (PdisSingle pdis in pdisList)
                          Builder(builder: (context) {
                            return Row(
                              children: [
                                for (ToCelda celda in pdis.celdas)
                                  Expanded(
                                    flex: celda.flex,
                                    child: Text(
                                      celda.valor,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                              ],
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
