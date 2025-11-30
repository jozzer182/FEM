import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/main_bloc.dart';
import '../../../resources/descarga_hojas.dart';

class ActionsOficial extends StatefulWidget {
  final ValueNotifier<int> selectedTabIndex;
  final TabController tabController;
  const ActionsOficial({
    required this.selectedTabIndex,
    required this.tabController,
    super.key,
  });

  @override
  State<ActionsOficial> createState() => _ActionsOficialState();
}

class _ActionsOficialState extends State<ActionsOficial> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
            valueListenable: widget.selectedTabIndex,
            builder: (c, value, child) {
              bool esOficialTab = widget.tabController.index == 5;
              if (esOficialTab) {
                return BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (state.ficha == null) {
                      return const CircularProgressIndicator();
                    }
                    List<Map<String, dynamic>> datos = state
                        .ficha!.fficha.version
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
                                  'Ficha Oficial de ${state.ficha!.fficha.ficha.first.proyecto}'),
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
