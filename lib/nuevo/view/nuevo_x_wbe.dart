import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/plataforma/model/plataforma_model.dart';

class SelectWbeNuevoPage extends StatefulWidget {
  final String e4e;
  final int index;
  final String table;
  const SelectWbeNuevoPage({
    super.key,
    required this.e4e,
    required this.index,
    required this.table,
  });

  @override
  State<SelectWbeNuevoPage> createState() => _SelectWbeNuevoPageState();
}

class _SelectWbeNuevoPageState extends State<SelectWbeNuevoPage> {
  String filter = '';
  bool enCompra = false;
  TextEditingController wbe = TextEditingController();
  TextEditingController proyecto = TextEditingController();
  TextEditingController estado = TextEditingController();

  @override
  void initState() {
    wbe
      ..addListener(() {
        setState(() {});
      });
    proyecto
      ..addListener(() {
        setState(() {});
      });
    estado
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  void dispose() {
    wbe.dispose();
    proyecto.dispose();
    estado.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar WBE'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: TextField(
              // controller: busqueda,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // context.read<MainBloc>().add(Busqueda(busqueda.text));
                  },
                ),
                border: const OutlineInputBorder(),
                labelText: 'Búsqueda',
              ),
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
          enCompra
              ? const SizedBox()
              : SizedBox(
                  height: 200,
                  width: 300,
                  child: BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      if (state.plataforma == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<PlataformaSingle> plataformaList = state
                          .plataforma!.plataformaList
                          .where((e) => e.material == widget.e4e)
                          .toList();
                      plataformaList = plataformaList
                          .where(
                            (e) => e.toList().any(
                                  (el) => el.toLowerCase().contains(
                                        filter.toLowerCase(),
                                      ),
                                ),
                          )
                          .toList();
                      return ListView.builder(
                        itemCount: plataformaList.length,
                        itemBuilder: (context, index) {
                          String proyecto = plataformaList[index].proyecto;
                          if (proyecto.isEmpty) proyecto = "Libre Utilización";
                          return Tooltip(
                            message: plataformaList[index].status,
                            child: ListTile(
                              title: Text(proyecto),
                              subtitle: Text(plataformaList[index].wbe),
                              trailing:
                                  Text('total ${plataformaList[index].ctd}'),
                              enabled: !plataformaList[index]
                                  .status
                                  .contains('CTEC'),
                              onTap: () {
                                context.read<MainBloc>().add(
                                      ModNuevo(
                                        tabla: widget.table,
                                        campo: 'wbe',
                                        valor: plataformaList[index].wbe,
                                        index: widget.index,
                                      ),
                                    );
                                context.read<MainBloc>().add(
                                      ModNuevo(
                                        tabla: widget.table,
                                        campo: 'proyectowbe',
                                        valor: plataformaList[index].proyecto,
                                        index: widget.index,
                                      ),
                                    );
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
          const SizedBox(height: 30),
          Builder(builder: (context) {
            if (!enCompra) {
              return ElevatedButton(
                child: const Text('Material en orden de compra'),
                onPressed: () {
                  setState(() {
                    enCompra = !enCompra;
                  });
                },
              );
            }
            return SizedBox(
              width: 300,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: wbe,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'WBE',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: wbe.text.length != 22
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: wbe.text.length != 22
                                ? Colors.red
                                : Colors.green,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: proyecto,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'PROYECTO',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: proyecto.text.isEmpty
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: proyecto.text.isEmpty
                                ? Colors.red
                                : Colors.green,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: estado,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'ESTADO EN SAP',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: estado.text.isEmpty ||
                                    estado.text.contains('CTEC')
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: estado.text.isEmpty ||
                                    estado.text.contains('CTEC')
                                ? Colors.red
                                : Colors.green,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text('Guardar'),
                        onPressed: wbe.text.length == 22 &&
                                proyecto.text.isNotEmpty &&
                                !estado.text.contains('CTEC') &&
                                estado.text.isNotEmpty
                            ? () {
                                if (wbe.text.length == 22 &&
                                    proyecto.text.isNotEmpty &&
                                    !estado.text.contains('CTEC') &&
                                    estado.text.isNotEmpty) {
                                  context.read<MainBloc>().add(
                                        ModNuevo(
                                          tabla: 'nuevoList',
                                          campo: 'wbe',
                                          valor: wbe.text,
                                          index: widget.index,
                                        ),
                                      );
                                  context.read<MainBloc>().add(
                                        ModNuevo(
                                          tabla: 'nuevoList',
                                          campo: 'proyectowbe',
                                          valor: proyecto.text,
                                          index: widget.index,
                                        ),
                                      );
                                  Navigator.pop(context);
                                }
                              }
                            : null,
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        child: const Text('X'),
                        onPressed: () {
                          setState(() {
                            enCompra = !enCompra;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
