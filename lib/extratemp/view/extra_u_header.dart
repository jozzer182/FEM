import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';

class HeaderExtra extends StatefulWidget {
  const HeaderExtra({super.key});

  @override
  State<HeaderExtra> createState() => _HeaderExtraState();
}

class _HeaderExtraState extends State<HeaderExtra> {
  List<String> years = ["2023", "2024", "2025", "2026", "2027", "2028"];
  TextEditingController rowsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        var data = state.extra!.encabezado;
        List<String> personas =
            state.personas?.personasList.map((e) => e.email).toList() ?? [];
        personas.sort();
        return Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  // Expanded(
                  //   flex: 3,
                  //   child: DropdownButtonFormField(
                  //     isExpanded: true,
                  //     items: years
                  //         .map((e) => DropdownMenuItem(
                  //               value: e,
                  //               child: Text(e),
                  //             ))
                  //         .toList(),
                  //     onChanged: (value) {
                  //       context.read<MainBloc>().add(
                  //             ModNuevo(
                  //               tabla: 'nuevo',
                  //               campo: 'ano',
                  //               valor: value.toString(),
                  //             ),
                  //           );
                  //     },
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  //       border: OutlineInputBorder(),
                  //       labelText: 'Año',
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: data.anoError,
                  //         ),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: data.anoError,
                  //           width: 2,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        if (state.budget == null)
                          return const CircularProgressIndicator();
                        List<String> proyectos = state.budget!.budgetList
                            .where((e) =>
                                e.ejecutor.contains('PM') ||
                                e.ejecutor.contains('Permiting'))
                            .map((e) => e.proyecto)
                            .toSet()
                            .toList();
                        proyectos.sort();
                        // var data = state.nuevo!.encabezado;
                        return DropdownButtonFormField(
                          isExpanded: true,
                          items: proyectos
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // print(value);
                            context.read<MainBloc>().add(
                                  ModNuevo(
                                    tabla: 'extra',
                                    campo: 'proyecto',
                                    valor: value.toString(),
                                  ),
                                );
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(),
                            labelText: 'Proyecto',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: data.proyectoError,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: data.proyectoError,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10),
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
                  SizedBox(width: 10),
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
                  // SizedBox(width: 10),
                  // Expanded(
                  //   flex: 2,
                  //   child: TextFormField(
                  //     controller: TextEditingController(text: data.pedido),
                  //     decoration: const InputDecoration(
                  //       enabled: false,
                  //       border: OutlineInputBorder(),
                  //       labelText: 'Unidad',
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 10),
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
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      items: personas
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        context.read<MainBloc>().add(
                              ModNuevo(
                                tabla: 'extra',
                                campo: 'pm',
                                valor: value.toString(),
                              ),
                            );
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(),
                        labelText: 'PM',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: data.pmError,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: data.pmError,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      onChanged: (value) {
                        context.read<MainBloc>().add(
                              ModNuevo(
                                tabla: 'extra',
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<MainBloc>().add(
                            ModNuevo(
                              tabla: 'extraRows',
                              campo: 'agregar',
                              valor: '1',
                            ),
                          );
                    },
                    child: Icon(Icons.add)),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      context.read<MainBloc>().add(
                            ModNuevo(
                              tabla: 'extraRows',
                              campo: 'quitar',
                              valor: '1',
                            ),
                          );
                    },
                    child: Icon(Icons.remove)),
                SizedBox(width: 10),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: TextField(
                    controller: rowsController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: '# Filas',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      context.read<MainBloc>().add(
                            ModNuevo(
                              tabla: 'extraRows',
                              campo: 'resize',
                              valor: rowsController.text.toString(),
                            ),
                          );
                    },
                    child: Text('Aplicar'))
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
