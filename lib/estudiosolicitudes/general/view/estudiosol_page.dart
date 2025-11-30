import 'package:fem_app/estudiosolicitudes/proyecto/view/proyecto_vista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/main_bloc.dart';
import '../../../resources/descarga_hojas.dart';
import '../../proyecto/model/proyecto_model.dart';
import '../model/estudiosol_model.dart';
import '../model/estudiosol_reg.dart';
import 'confirm_all_dialog.dart';
import 'estudiosol_grafica.dart';

class EstudioSolPage extends StatefulWidget {
  const EstudioSolPage({super.key});

  @override
  State<EstudioSolPage> createState() => _EstudioSolPageState();
}

class _EstudioSolPageState extends State<EstudioSolPage> {
  String year = '2024';
  String filterE4e = '';
  String filterProyecto = '';
  int endList = 70;
  final ScrollController _controller = ScrollController();
  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        endList += 70;
      });
    }
  }

  final uSFormat = NumberFormat.currency(
    locale: "en_US",
    symbol: "\$",
    decimalDigits: 0,
  );

  @override
  void initState() {
    _controller.addListener(_onScroll);
    context.read<MainBloc>().estudioSolController().obtener;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Estudio de Solicitudes'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: BlocSelector<MainBloc, MainState, bool>(
                selector: (state) => state.isLoading,
                builder: (context, state) {
                  return state
                      ? const LinearProgressIndicator()
                      : const SizedBox();
                },
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    filterE4e = '';
                    filterProyecto = '';
                  });
                },
                child: const Text(
                  'Limpiar\nfiltros',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          floatingActionButton: BlocSelector<MainBloc, MainState, EstudioSol?>(
            selector: (state) => state.estudioSol,
            builder: (context, state) {
              if (state == null) {
                return const CircularProgressIndicator();
              } else {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () => DescargaHojas().ahoraMap(
                        datos: state.list.map((e) => e.toMap()).toList(),
                        nombre: 'Solicitados'),
                    child: const Icon(Icons.download),
                  ),
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
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            filterE4e = value;
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: 'Filtro E4E',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            filterProyecto = value;
                          });
                        },
                        decoration: const InputDecoration(
                            labelText: 'Filtro Proyecto',
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  if (filterE4e.length != 6) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Para Todos los registros: '),
                        SizedBox(
                          width: 35,
                          child: IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              List<EstudioSolReg> listEnviar = state
                                  .estudioSol!.listProyecto
                                  .expand(
                                    (e) => e.list.where(
                                      (el) =>
                                          el.e4e.contains(filterE4e) &&
                                          el.proyecto.contains(filterProyecto),
                                    ),
                                  )
                                  .toList();
                              context
                                  .read<MainBloc>()
                                  .estudioSolController()
                                  .setListEnviar(listEnviar);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const ConfirmAllDialog(
                                    aprobar: true,
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.check_circle),
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              List<EstudioSolReg> listEnviar = state
                                  .estudioSol!.listProyecto
                                  .expand(
                                    (e) => e.list.where(
                                      (el) =>
                                          el.e4e.contains(filterE4e) &&
                                          el.proyecto.contains(filterProyecto),
                                    ),
                                  )
                                  .toList();
                              context
                                  .read<MainBloc>()
                                  .estudioSolController()
                                  .setListEnviar(listEnviar);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const ConfirmAllDialog(
                                    aprobar: false,
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.cancel),
                          ),
                        ),
                        SizedBox(
                          width: 35,
                          child: Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                child: Builder(builder: (context) {
                  if (state.estudioSol == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<EstudioProyecto> listProyecto =
                      state.estudioSol!.listProyecto;
                  if (filterE4e.isNotEmpty) {
                    listProyecto = listProyecto
                        .map((e) => EstudioProyecto(
                              list: e.list
                                  .where((element) =>
                                      element.e4e.contains(filterE4e) &&
                                      element.proyecto.contains(filterProyecto))
                                  .toList(),
                              proyecto: e.proyecto,
                            ))
                        .toList();
                  }
                  return SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: [
                        for (EstudioProyecto proyecto in listProyecto)
                          // if (proyecto.proyecto.contains(filterProyecto))
                          ProyectoWidget(
                            proyecto: proyecto,
                            filter: filterE4e,
                          ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              if (filterE4e.length == 6)
                Expanded(
                  child: GraficaDisponibleEstudiosol(filterE4e: filterE4e),
                ),
            ],
          ),
        );
      },
    );
  }
}
