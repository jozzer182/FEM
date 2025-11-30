import 'package:fem_app/ficha/ficha_eliminados/model/ficha_eliminados_single_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../bloc/main_bloc.dart';
import '../../../resources/titulo.dart';

class FichaEliminadosPage extends StatefulWidget {
  const FichaEliminadosPage({super.key});

  @override
  State<FichaEliminadosPage> createState() => _FichaEliminadosPageState();
}

class _FichaEliminadosPageState extends State<FichaEliminadosPage> {
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
    context.read<MainBloc>().fichaCambiosController().obtener();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            List<ToCelda> titles = state.ficha!.cambios.titles;
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
              if (state.ficha == null ||
                  firstTimeLoading ||
                  state.ficha!.cambios.cambiosList.isEmpty) {
                if (state.ficha!.cambios.isEmpty) {
                  return const Center(
                    child: Text('No hay datos'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<EliminadosSingle> cambiosList =
                  state.ficha!.cambios.cambiosList;
              cambiosList = cambiosList
                  .where(
                    (e) => e.toList().any(
                          (el) => el.toLowerCase().contains(
                                filter.toLowerCase(),
                              ),
                        ),
                  )
                  .toList();
              if (cambiosList.length > endList) {
                cambiosList = cambiosList.sublist(0, endList);
              }
              return SingleChildScrollView(
                controller: _controller,
                child: SelectableRegion(
                  focusNode: FocusNode(),
                  selectionControls: emptyTextSelectionControls,
                  child: Column(
                    children: [
                      for (EliminadosSingle cambio in cambiosList)
                        Builder(builder: (context) {
                          return Row(
                            children: [
                              for (ToCelda celda in cambio.celdas)
                                Expanded(
                                  flex: celda.flex,
                                  child: Text(
                                    celda.valor,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: (cambio.persona.contains(
                                                  'yuly.barretorodriguez@enel.com') ||
                                              cambio.persona.contains(
                                                  'monica.pineda@enel.com'))
                                          ? Colors.blue
                                          : null,
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
    );
  }
}
