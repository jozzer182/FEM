// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/nuevo/model/nuevo_model.dart';

class HeaderNuevo extends StatefulWidget {
  const HeaderNuevo({super.key});

  @override
  State<HeaderNuevo> createState() => _HeaderNuevoState();
}

class _HeaderNuevoState extends State<HeaderNuevo> {
  List<String> years = [
    // "2024",
    "2025",
    "2026",
    "2027",
    "2028",
  ];
  TextEditingController rowsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        var data = state.nuevo!.encabezado;
        List<String> personas =
            state.personas?.personasList.map((e) => e.email).toList() ?? [];
        personas.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
        return Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      items: years
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context.read<MainBloc>().add(
                              ModNuevo(
                                tabla: 'nuevo',
                                campo: 'ano',
                                valor: value.toString(),
                              ),
                            );
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: const OutlineInputBorder(),
                        labelText: 'Año',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: data.anoError,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: data.anoError,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        if (state.budget == null) {
                          return const CircularProgressIndicator();
                        }
                        List<String> proyectos = state.budget!.budgetList
                            .where((e) =>
                                e.ejecutor.contains('PM') ||
                                e.ejecutor.contains('Permiting'))
                            .map((e) => e.proyecto)
                            .toSet()
                            .toList();
                        proyectos.sort();
                        EncabezadoNuevo data = state.nuevo!.encabezado;
                        bool estaEnLista = false;
                        return Autocomplete(
                          displayStringForOption: (option) {
                            return option;
                          },
                          optionsBuilder: (textEditingValue) {
                            estaEnLista =
                                proyectos.contains(textEditingValue.text);
                            // print('estaEnLista: $estaEnLista');
                            // print(
                            //     'textEditingController: ${textEditingValue.text}');
                            return proyectos.where((e) => e
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()));
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Material(
                              child: SizedBox(
                                width: 300,
                                child: ListView.builder(
                                  itemCount: options.length,
                                  itemBuilder: (context, i) {
                                    return ListTile(
                                      title: Text(options.toList()[i]),
                                      onTap: () {
                                        onSelected(options.toList()[i]);
                                        context.read<MainBloc>().add(
                                              ModNuevo(
                                                tabla: 'nuevo',
                                                campo: 'proyecto',
                                                valor: options.toList()[i],
                                              ),
                                            );
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            estaEnLista =
                                proyectos.contains(textEditingController.text);

                            // print('estaEnLista: $estaEnLista');
                            // print(
                            //     'textEditingController: ${textEditingController.text}');
                            return TextFormField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                labelText: 'Proyecto',
                                border: const OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: estaEnLista
                                            ? Colors.green
                                            : Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: estaEnLista
                                            ? Colors.green
                                            : Colors.red)),
                              ),
                              onChanged: (value) {
                                if (estaEnLista) {
                                  context.read<MainBloc>().add(
                                        ModNuevo(
                                          tabla: 'nuevo',
                                          campo: 'proyecto',
                                          valor: value,
                                        ),
                                      );
                                } else {
                                  context.read<MainBloc>().add(
                                        ModNuevo(
                                          tabla: 'nuevo',
                                          campo: 'proyecto',
                                          valor: "",
                                        ),
                                      );
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: TextEditingController(text: data.codigo),
                      decoration: const InputDecoration(
                        enabled: false,
                        border: OutlineInputBorder(),
                        labelText: 'Código',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: TextEditingController(text: data.unidad),
                      decoration: const InputDecoration(
                        enabled: false,
                        border: OutlineInputBorder(),
                        labelText: 'Unidad',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: TextEditingController(
                          text: FirebaseAuth.instance.currentUser!.email),
                      decoration: const InputDecoration(
                        enabled: false,
                        border: OutlineInputBorder(),
                        labelText: 'Solicitante',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        if (state.budget == null) {
                          return const CircularProgressIndicator();
                        }
                        // List<String> proyectos = state.budget!.budgetList
                        //     .where((e) =>
                        //         e.ejecutor.contains('PM') ||
                        //         e.ejecutor.contains('Permiting'))
                        //     .map((e) => e.proyecto)
                        //     .toSet()
                        //     .toList();
                        // proyectos.sort();
                        // var data = state.nuevo!.encabezado;
                        bool estaEnLista = false;
                        return Autocomplete(
                          displayStringForOption: (option) {
                            return option;
                          },
                          optionsBuilder: (textEditingValue) {
                            estaEnLista =
                                personas.contains(textEditingValue.text);
                            // print('estaEnLista: $estaEnLista');
                            // print(
                            //     'textEditingController: ${textEditingValue.text}');
                            return personas.where((e) => e
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()));
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Material(
                              child: SizedBox(
                                width: 300,
                                child: ListView.builder(
                                  itemCount: options.length,
                                  itemBuilder: (context, i) {
                                    return ListTile(
                                      title: Text(options.toList()[i]),
                                      onTap: () {
                                        onSelected(options.toList()[i]);
                                        context.read<MainBloc>().add(
                                              ModNuevo(
                                                tabla: 'nuevo',
                                                campo: 'pm',
                                                valor: options.toList()[i],
                                              ),
                                            );
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            estaEnLista = textEditingController.text
                                .toLowerCase()
                                .contains('@enel.com');

                            // print('estaEnLista: $estaEnLista');
                            // print(
                            //     'textEditingController: ${textEditingController.text}');
                            return TextFormField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                labelText: 'PM',
                                border: const OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: estaEnLista
                                            ? Colors.green
                                            : Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: estaEnLista
                                            ? Colors.green
                                            : Colors.red)),
                              ),
                              onChanged: (value) {
                                if (estaEnLista) {
                                  context.read<MainBloc>().add(
                                        ModNuevo(
                                          tabla: 'nuevo',
                                          campo: 'pm',
                                          valor: value,
                                        ),
                                      );
                                } else {
                                  context.read<MainBloc>().add(
                                        ModNuevo(
                                          tabla: 'nuevo',
                                          campo: 'pm',
                                          valor: "",
                                        ),
                                      );
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // const SizedBox(width: 10),
                  // Expanded(
                  //   flex: 2,
                  //   child: DropdownButtonFormField(
                  //     isExpanded: true,
                  //     items: personas
                  //         .map((e) => DropdownMenuItem(
                  //               value: e,
                  //               child: Text(e),
                  //             ))
                  //         .toList(),
                  //     onChanged: (value) {
                  //       context.read<MainBloc>().add(
                  //             ModNuevo(
                  //               tabla: 'nuevo',
                  //               campo: 'pm',
                  //               valor: value.toString(),
                  //             ),
                  //           );
                  //     },
                  //     decoration: InputDecoration(
                  //       contentPadding:
                  //           const EdgeInsets.symmetric(horizontal: 10),
                  //       border: const OutlineInputBorder(),
                  //       labelText: 'PM',
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: data.pmError,
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: data.pmError,
                  //           width: 2,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      onChanged: (value) {
                        context.read<MainBloc>().add(
                              ModNuevo(
                                tabla: 'nuevo',
                                campo: 'comentario1',
                                valor: value.toString(),
                              ),
                            );
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Comentario',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<MainBloc>().add(
                            ModNuevo(
                              tabla: 'nuevoRows',
                              campo: 'agregar',
                              valor: '1',
                            ),
                          );
                    },
                    child: const Icon(Icons.add)),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      context.read<MainBloc>().add(
                            ModNuevo(
                              tabla: 'nuevoRows',
                              campo: 'quitar',
                              valor: '1',
                            ),
                          );
                    },
                    child: const Icon(Icons.remove)),
                const SizedBox(width: 10),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: TextField(
                    controller: rowsController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: '# Filas',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      context.read<MainBloc>().add(
                            ModNuevo(
                              tabla: 'nuevoRows',
                              campo: 'resize',
                              valor: rowsController.text.toString(),
                            ),
                          );
                    },
                    child: const Text('Aplicar'))
              ],
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
