import 'package:fem_app/ficha/ficha_solicitados/model/ficha_solicitados_single_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../bloc/main_bloc.dart';
import '../../../resources/titulo.dart';
import 'solicitados_dialog_eliminar.dart';

class FichaSolicitadosPage extends StatefulWidget {
  const FichaSolicitadosPage({super.key});

  @override
  State<FichaSolicitadosPage> createState() => _FichaSolicitadosPageState();
}

class _FichaSolicitadosPageState extends State<FichaSolicitadosPage> {
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
    context.read<MainBloc>().fichaSolicitadosController().obtener();
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
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    filter = '';
                  });
                },
                child: const Text('Limpiar'),
              ),
            ],
          ),
        ),
        const Gap(5),
        BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            List<ToCelda> titles = state.ficha!.solicitados.titles;
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
                const SizedBox(
                  width: 87,
                ),
              ],
            );
          },
        ),
        const Gap(5),
        Expanded(
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              // print("state.ficha!.solicitados.solicitadosList: ${state.ficha!.solicitados.solicitadosList}");
              if (state.ficha == null ||
                  firstTimeLoading ||
                  state.ficha!.solicitados.solicitadosList.isEmpty) {
                if (state.ficha!.solicitados.isEmpty) {
                  return const Center(
                    child: Text('No hay solicitados registrados'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<SolicitadoSingle> solicitadosList =
                  state.ficha!.solicitados.solicitadosList;
              solicitadosList = solicitadosList
                  .where(
                    (e) => e.toList().any(
                          (el) => el.toLowerCase().contains(
                                filter.toLowerCase(),
                              ),
                        ),
                  )
                  .toList();
              if (solicitadosList.length > endList) {
                solicitadosList = solicitadosList.sublist(0, endList);
              }
              return ListView.builder(
                controller: _controller,
                itemCount: solicitadosList.length,
                itemBuilder: (context, index) {
                  if (filter.isNotEmpty &&
                      !state.ficha!.solicitados.solicitadosList[index].proyecto
                          .toLowerCase()
                          .contains(filter.toLowerCase())) {
                    return const SizedBox.shrink();
                  }

                  return InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        for (ToCelda celda in solicitadosList[index].celdas)
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
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogEliminarSolicitado(
                                    solicitado: solicitadosList[index],
                                  );
                                },
                              );
                            },
                            child: const Text('Eliminar'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
