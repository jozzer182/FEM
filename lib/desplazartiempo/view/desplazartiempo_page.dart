import 'package:fem_app/desplazartiempo/model/desplazartiempo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import 'boton_guardar/desplazartiempo_boton_guardar.dart';
import 'desplazartiempo_ficha.dart';

class DesplazarTiempoPage extends StatefulWidget {
  const DesplazarTiempoPage({super.key});

  @override
  State<DesplazarTiempoPage> createState() => _DesplazarTiempoPageState();
}

class _DesplazarTiempoPageState extends State<DesplazarTiempoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<int> _selectedTabIndex;
  bool habilitado = false;
  TextEditingController controller = TextEditingController();

  void _handleTabSelection() {
    // Imprime el índice de la pestaña seleccionada en la consola
    // print("Pestaña seleccionada: ${_tabController.index}");
    // Actualiza el índice de la pestaña seleccionada
    _selectedTabIndex.value = _tabController.index;
  }

  @override
  void initState() {
    // Configura el TabController con la cantidad de pestañas
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
    // Agrega un listener para detectar cambios de pestaña
    _tabController.addListener(_handleTabSelection);
    _selectedTabIndex = ValueNotifier<int>(0);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // Asegúrate de liberar recursos cuando el widget se dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    habilitado = controller.text.length == 6;
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state.desplazarTiempo == null) {
          return const Center(
            child: Text('No hay datos para este año'),
          );
        }
        bool soloNuevo = state.desplazarTiempo!.soloNuevo;
        return Scaffold(
          appBar: AppBar(
            title: Text('Desplazar Tiempo'),
            actions: [
              if (habilitado)
                Row(
                  children: [
                    const Gap(20),
                    const BotonGuardarDesplazarTiempo(),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          controller.text = '';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green, // Color de fondo del botón
                      ),
                      child: const Text('Cancelar'),
                    ),
                    const Gap(20),
                  ],
                ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(habilitado ? 150.0 : 115.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      readOnly: habilitado,
                      controller: controller,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: 'Buscar...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorText: controller.text.length != 6 &&
                                controller.text.isNotEmpty
                            ? 'El filtro debe tener al menos 6 caracteres'
                            : null,
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        if (value.length == 6) {
                          BlocProvider.of<MainBloc>(context)
                              .desplazarTiempoController()
                              .inicial
                              .llenarFichas(value);
                        }
                      },
                    ),
                  ),
                  if (habilitado)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            int year = 2024 + _tabController.index;
                            BlocProvider.of<MainBloc>(context)
                                .desplazarTiempoController()
                                .lista
                                .agregar(
                                  year.toString(),
                                  controller.text,
                                );
                            // print(_tabController.index);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondary, // Color secundario
                          ),
                          child: const Text('Agregar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            int year = 2024 + _tabController.index;
                            BlocProvider.of<MainBloc>(context)
                                .desplazarTiempoController()
                                .lista
                                .eliminar(year.toString());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondary, // Color secundario
                          ),
                          child: const Text('Eliminar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<MainBloc>(context)
                                .desplazarTiempoController()
                                .inicial
                                .llenarFichas(controller.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondary, // Color secundario
                          ),
                          child: const Text('Limpiar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<MainBloc>(context)
                                .desplazarTiempoController()
                                .lista
                                .solonuevo;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: soloNuevo
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context)
                                    .colorScheme
                                    .tertiary, // Color secundario
                          ),
                          child: const Text('Solo Nuevos'),
                        ),
                      ],
                    ),
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: '2024'),
                      Tab(text: '2025'),
                      Tab(text: '2026'),
                      Tab(text: '2027'),
                      Tab(text: '2028'),
                    ],
                  ),
                  BlocSelector<MainBloc, MainState, bool>(
                    selector: (state) => state.isLoading,
                    builder: (context, state) {
                      // print('called');
                      return state
                          ? const LinearProgressIndicator()
                          : const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
          body: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (!habilitado) {
                return TabBarView(
                  controller: _tabController,
                  children: const [
                    Center(child: Text('Por favor, especifique un código E4E')),
                    Center(child: Text('Por favor, especifique un código E4E')),
                    Center(child: Text('Por favor, especifique un código E4E')),
                    Center(child: Text('Por favor, especifique un código E4E')),
                    Center(child: Text('Por favor, especifique un código E4E')),
                  ],
                );
              }
              DesplazarTiempo? desplazarTiempo = state.desplazarTiempo;
              if (desplazarTiempo == null) {
                return const Center(child: Text('No hay datos'));
              }

              return TabBarView(
                controller: _tabController,
                children: const [
                  VistaFichaDesplazartiempo(
                    fichaAno: FichaAno.f2024,
                  ),
                  VistaFichaDesplazartiempo(
                    fichaAno: FichaAno.f2025,
                  ),
                  VistaFichaDesplazartiempo(
                    fichaAno: FichaAno.f2026,
                  ),
                  VistaFichaDesplazartiempo(
                    fichaAno: FichaAno.f2027,
                  ),
                  VistaFichaDesplazartiempo(
                    fichaAno: FichaAno.f2028,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

enum FichaAno { f2024, f2025, f2026, f2027, f2028 }
