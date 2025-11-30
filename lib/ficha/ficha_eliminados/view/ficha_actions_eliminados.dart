import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/main_bloc.dart';
import '../../../resources/descarga_hojas.dart';

class ActionsEliminados extends StatefulWidget {
  final ValueNotifier<int> selectedTabIndex;
  final TabController tabController;
  const ActionsEliminados({
    required this.selectedTabIndex,
    required this.tabController,
    super.key,
  });

  @override
  State<ActionsEliminados> createState() => _ActionsEliminadosState();
}

class _ActionsEliminadosState extends State<ActionsEliminados> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
            valueListenable: widget.selectedTabIndex,
            builder: (c, value, child) {
              bool esCambiosTab = widget.tabController.index == 4;
              if (esCambiosTab) {
                return BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (state.ficha == null||state.ficha!.cambios.cambiosList.isEmpty) {
                      return const CircularProgressIndicator();
                    }
                    List<Map<String, dynamic>> datos = state
                        .ficha!.cambios.cambiosList
                        .map((e) => e.toMap())
                        .toList();
                    return Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () => DescargaHojas().ahoraMap(
                              datos: datos,
                              nombre:
                                  'Eliminados de ficha de ${state.ficha!.fficha.ficha.first.proyecto}'),
                          child: const Icon(Icons.download),
                        ),
                      ],
                    );
                  },
                );
              }
              return const SizedBox();
            },
          );
  }
}
