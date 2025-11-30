// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/fem/view/fem_RowDataW.dart';
import 'package:fem_app/fem/model/fem_model.dart';
import 'package:fem_app/fem/view/dialogs/fem_selec_pdi_page_all.dart';
import 'package:fem_app/version.dart';
import 'package:fem_app/pdis/model/pdis_model.dart';
import 'package:fem_app/pedidos/model/pedidos_model.dart';
import 'package:fem_app/resources/descarga_hojas.dart';
import 'package:fem_app/wbe/model/wbe_model.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/fem_model_single_fem.dart';

class FemPage extends StatefulWidget {
  const FemPage({super.key});

  @override
  State<FemPage> createState() => _FemPageState();
}

class _FemPageState extends State<FemPage> {
  List<String> year = ["2024", "2025", "2026", "2027", "2028"];
  String selectedYear = "2024";
  String selectedProyecto = "";
  String selectedCircuito = "";
  String selectedE4e = "";
  String? pedidoSeleccionado;
  bool confirmarDespacho = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _autocompleteKey = GlobalKey();
  List<SingleFEM> dataForTable = [];
  aEntero(String valor) {
    if (valor == '') {
      return 0;
    } else {
      return int.parse(valor);
    }
  }

  bool seMostroMensaje = false;

  void _mostrarMensaje() async {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text('Atención'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Invitamos a usar Fichas2, que es el nuevo módulo para la gestión de las fichas',
                style: TextStyle(fontSize: 14),
              ),
              const Gap(10),
              RichText(
                text: TextSpan(
                  text: 'Mira el video con todas las nuevas funcionalidades ',
                  // style: DefaultTextStyle.of(context).style,
                  style: TextStyle(fontSize: 14),

                  children: [
                    TextSpan(
                      text: 'este enlace',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse(
                              'https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EX4CHUZiFQBDrs86c8n2Fe0ByWgZNzN3e7dlbz7MQYaG9A?e=oyYfct'));
                        },
                    ),
                    // TextSpan(
                    //   text: ' para más información.',
                    // ),
                  ],
                ),
              ),
              const Gap(10),
              const Text(
                'No dudes en consultarnos si se te presenta algún problema.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }),
    );
  }

  @override
  void initState() {
    if (!seMostroMensaje) {
      //esperar 1 segundos antes de mostrar el mensaje
      Future.delayed(const Duration(seconds: 1), () {
        _mostrarMensaje();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Version().data,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              "Conectado como: ${FirebaseAuth.instance.currentUser!.email}, Fecha y hora: ${DateTime.now()}, Página actual: Ficha",
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
      ],
      floatingActionButton: BlocSelector<MainBloc, MainState, Fem?>(
        selector: (state) => state.fem,
        builder: (context, state) {
          if (state == null) return const CircularProgressIndicator();
          List<SingleFEM> data = [];
          // List<SingleFEM> dataForTable = [];
          List<SingleFEM> dataForCircuito = [];
          List<SingleFEM> dataForE4e = [];
          if (selectedYear == "2022") {
            data = state.f2022;
            dataForTable = [...data];
          }
          if (selectedYear == "2023") {
            data = state.f2023;
            dataForTable = [...data];
          }
          if (selectedYear == "2024") {
            data = state.f2024;
            dataForTable = [...data];
          }
          if (selectedYear == "2025") {
            data = state.f2025;
            dataForTable = [...data];
          }
          if (selectedYear == "2026") {
            data = state.f2026;
            dataForTable = [...data];
          }
          if (selectedYear == "2027") {
            data = state.f2027;
            dataForTable = [...data];
          }
          if (selectedYear == "2028") {
            data = state.f2028;
            dataForTable = [...data];
          }
          if (selectedProyecto.isNotEmpty) {
            data = data
                .where((e) => e.proyecto
                    .toLowerCase()
                    .contains(selectedProyecto.toLowerCase()))
                .toList();
            if (data.any((e) => e.proyecto == selectedProyecto)) {
              // print('called from project selected');
              data = data
                  .where((e) =>
                      e.proyecto.toLowerCase() ==
                      selectedProyecto.toLowerCase())
                  .toList();
            }
            dataForTable = data;
            dataForCircuito = data;
            dataForE4e = data;
          }
          if (selectedCircuito.isNotEmpty) {
            dataForCircuito = data;
            if (selectedE4e.isNotEmpty) {
              dataForCircuito = data
                  .where((e) => e.e4e
                      .toLowerCase()
                      .contains(selectedE4e.toString().toLowerCase()))
                  .toList();
              dataForTable = data;
            }
            data = data
                .where((e) => e.circuito
                    .toLowerCase()
                    .contains(selectedCircuito.toLowerCase()))
                .toList();
            dataForTable = data;
          }
          if (selectedE4e.isNotEmpty) {
            dataForE4e = data;
            if (selectedCircuito.isNotEmpty) {
              dataForE4e = data
                  .where((e) => e.circuito
                      .toLowerCase()
                      .contains(selectedCircuito.toString().toLowerCase()))
                  .toList();
              dataForTable = data;
            }
            data = data
                .where((e) => e.e4e
                    .toLowerCase()
                    .contains(selectedE4e.toString().toLowerCase()))
                .toList();
            dataForTable = data;
          }
          // if (dataForTable.isEmpty) return SizedBox();
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // SizedBox(
              //   width: 20,
              //   height: 20,
              //   child: FloatingActionButton(
              //     onPressed: () => DescargaHojas().ahora(
              //         datos: dataForTable,
              //         nombre:
              //             'FICHA DE ${selectedProyecto} del año ${selectedYear}'),
              //     child: Icon(
              //       Icons.download,
              //       size: 12.0,
              //     ),
              //     mini: true,
              //   ),
              // ),
              SizedBox(
                width: 35,
                // height: 20,
                // child: FloatingActionButton(
                //   onPressed: () => DescargaHojas().ahora(
                //       datos: dataForTable,
                //       nombre: 'FICHA DE ${selectedProyecto} del año ${selectedYear}'),
                //   child: Icon(Icons.download),
                //   mini: true,
                // ),
              ),
            ],
          );
        },
      ),
      appBar: AppBar(
        title: const Text("FICHA DE PROYECTO"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: BlocSelector<MainBloc, MainState, bool>(
            selector: (state) => state.isLoading,
            builder: (context, state) {
              // print('called');
              return state ? const LinearProgressIndicator() : const SizedBox();
            },
          ),
        ),
        actions: [
          BlocSelector<MainBloc, MainState, Fem?>(
              selector: (state) => state.fem,
              builder: (context, state) {
                if (state == null) return const CircularProgressIndicator();
                return ElevatedButton(
                  onPressed: () => DescargaHojas().ahora(
                      datos: dataForTable,
                      nombre:
                          'FICHA DE $selectedProyecto del año $selectedYear'),
                  child: const Text("Descarga"),
                );
              })
        ],
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          String dataDespacho = state.fechasFEM!.fechasFEMList
              .where((e) => e.estado == 'true')
              .first
              .pedido;
          List<SingleFEM> data = [];
          List<SingleFEM> dataForTable = [];
          List<SingleFEM> dataForCircuito = [];
          List<SingleFEM> dataForE4e = [];
          if (selectedYear == "2022") {
            data = state.fem!.f2022;
            dataForTable = [...data];
          }
          if (selectedYear == "2023") {
            data = state.fem!.f2023;
            dataForTable = [...data];
          }
          if (selectedYear == "2024") {
            data = state.fem!.f2024;
            dataForTable = [...data];
          }
          if (selectedYear == "2025") {
            data = state.fem!.f2025;
            dataForTable = [...data];
          }
          if (selectedYear == "2026") {
            data = state.fem!.f2026;
            dataForTable = [...data];
          }
          if (selectedYear == "2027") {
            data = state.fem!.f2027;
            dataForTable = [...data];
          }
          if (selectedYear == "2028") {
            data = state.fem!.f2028;
            dataForTable = [...data];
          }
          if (selectedProyecto.isNotEmpty) {
            data = data
                .where((e) => e.proyecto
                    .toLowerCase()
                    .contains(selectedProyecto.toLowerCase()))
                .toList();
            if (data.any((e) => e.proyecto == selectedProyecto)) {
              // print('called from project selected');
              data = data
                  .where((e) =>
                      e.proyecto.toLowerCase() ==
                      selectedProyecto.toLowerCase())
                  .toList();
            }
            dataForTable = data;
            dataForCircuito = data;
            dataForE4e = data;
          }
          if (selectedCircuito.isNotEmpty) {
            dataForCircuito = data;
            if (selectedE4e.isNotEmpty) {
              dataForCircuito = data
                  .where((e) => e.e4e
                      .toLowerCase()
                      .contains(selectedE4e.toString().toLowerCase()))
                  .toList();
              dataForTable = data;
            }
            data = data
                .where((e) => e.circuito
                    .toLowerCase()
                    .contains(selectedCircuito.toLowerCase()))
                .toList();
            dataForTable = data;
          }
          if (selectedE4e.isNotEmpty) {
            dataForE4e = data;
            if (selectedCircuito.isNotEmpty) {
              dataForE4e = data
                  .where((e) => e.circuito
                      .toLowerCase()
                      .contains(selectedCircuito.toString().toLowerCase()))
                  .toList();
              dataForTable = data;
            }
            data = data
                .where((e) => e.e4e
                    .toLowerCase()
                    .contains(selectedE4e.toString().toLowerCase()))
                .toList();
            dataForTable = data;
          }
          List listaDesplegable = [
            "",
            ...dataForCircuito.map((e) => e.circuito).toList()
          ];
          listaDesplegable = listaDesplegable.toSet().toList();
          listaDesplegable.sort((a, b) => a.compareTo(b));
          // print(listaDesplegable);
          // print(
          //     'Desde FemPage lenght pedido: ${state.pedidos!.pedidosListCart.length}');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Builder(
                      builder: (context) {
                        if (state.isLoading)
                          return const CircularProgressIndicator();
                        return Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            iconSize: 20,
                            value: selectedYear,
                            items: year
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                confirmarDespacho = false;
                                pedidoSeleccionado = null;
                                selectedCircuito = "";
                                selectedProyecto = "";
                                _controller.text = "";
                                selectedE4e = "";
                                selectedYear = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: "AÑO",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 6,
                      child: RawAutocomplete<String>(
                        textEditingController: _controller,
                        focusNode: _focusNode,
                        key: _autocompleteKey,
                        displayStringForOption: (option) {
                          return option;
                        },
                        optionsBuilder: (textEditingValue) async {
                          var optionsX = await data
                              .map((e) => e.proyecto)
                              .toSet()
                              .where((e) => e.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase()))
                              .toList();
                          optionsX.sort((a, b) => a.compareTo(b));
                          return optionsX;
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Material(
                            child: ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (context, i) {
                                String option = options.toList()[i];
                                return ListTile(
                                  title: Text(option,
                                      style: const TextStyle(fontSize: 14)),
                                  onTap: () async {
                                    onSelected(options.toList()[i]);
                                    setState(() {
                                      selectedProyecto = options.toList()[i];
                                      selectedCircuito = "";
                                      selectedE4e = "";
                                    });
                                    await FirebaseAnalytics.instance.logSearch(
                                        searchTerm: selectedProyecto,
                                        endDate: selectedYear);
                                    // print(selectedProyecto);
                                    // context.read<MainBloc>().add(
                                    //       ChangePlanilla(
                                    //         tabla: "planillab",
                                    //         campo: 'cc_lider_contrato_e',
                                    //         valor: option,
                                    //       ),
                                    //     );
                                  },
                                );
                              },
                            ),
                          );
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          return TextField(
                            controller:
                                textEditingController, // Required by autocomplete
                            focusNode: focusNode, // Required by autocomplete
                            onChanged: (value) {
                              // selectedProyecto = "";
                              setState(() {
                                selectedProyecto = "";
                                selectedCircuito = "";
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: "PROYECTO",
                              border: OutlineInputBorder(),
                            ),
                            enabled: selectedYear.isNotEmpty,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 3,
                        child: DropdownButtonFormField(
                          items: listaDesplegable
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCircuito = value.toString();
                              selectedE4e = "";
                            });
                          },
                          value: selectedCircuito,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: "CIRCUITO",
                            border: const OutlineInputBorder(),
                            enabled: selectedProyecto.isNotEmpty,
                          ),
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Autocomplete<String>(
                        displayStringForOption: (option) {
                          return option;
                        },
                        optionsBuilder: (textEditingValue) {
                          var optionsX =
                              dataForE4e.map((e) => e.e4e).toSet().toList();
                          optionsX.sort((a, b) => a.compareTo(b));
                          return optionsX;
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Material(
                            child: ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (context, i) {
                                String option = options.toList()[i];
                                return ListTile(
                                  title: Text(option,
                                      style: const TextStyle(fontSize: 14)),
                                  onTap: () {
                                    onSelected(options.toList()[i]);
                                    setState(() {
                                      selectedE4e = options.toList()[i];
                                    });
                                    // context.read<MainBloc>().add(
                                    //       ChangePlanilla(
                                    //         tabla: "planillab",
                                    //         campo: 'cc_lider_contrato_e',
                                    //         valor: option,
                                    //       ),
                                    //     );
                                  },
                                );
                              },
                            ),
                          );
                        },
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          return TextField(
                            controller:
                                textEditingController, // Required by autocomplete
                            focusNode: focusNode, // Required by autocomplete
                            onChanged: (value) {
                              setState(() {
                                selectedE4e = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: "E4E",
                              border: OutlineInputBorder(),
                            ),
                            // enabled: selectedProyecto.isNotEmpty,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 30,
                  child: BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      String dataFecha;
                      String? estadoPedido;
                      List<String> pedidosDisponibles = [];
                      if (state.fechasFEM == null) {
                        dataDespacho = 'cargando...';
                        dataFecha = 'cargando...';
                      } else {
                        pedidosDisponibles = state.fechasFEM!.fechasFEMList
                            .where((e) =>
                                e.estado == 'true' && selectedYear == e.ano)
                            .map((e) => e.pedido)
                            .toList();
                        if (pedidosDisponibles.isEmpty) {
                          return const Text(
                              'No hay pedidos disponibles para el año seleccionado');
                        }
                        pedidoSeleccionado =
                            pedidoSeleccionado ?? pedidosDisponibles.first;
                        dataFecha = state.fechasFEM!.fechasFEMList
                            .where((e) =>
                                e.estado == 'true' &&
                                selectedYear == e.ano &&
                                pedidoSeleccionado == e.pedido)
                            .first
                            .fecha;
                        estadoPedido = state.fechasFEM!.fechasFEMList
                                    .where((e) =>
                                        e.estado == 'true' &&
                                        selectedYear == e.ano &&
                                        pedidoSeleccionado == e.pedido)
                                    .first
                                    .estado ==
                                'true'
                            ? 'ABIERTO'
                            : 'CERRADO';
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text(
                                  "PEDIDO: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    iconSize: 20,
                                    value: pedidoSeleccionado,
                                    items: pedidosDisponibles
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        pedidoSeleccionado = value.toString();
                                      });
                                    },
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      enabled: selectedYear.isNotEmpty,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "FECHA: $dataFecha",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                              child: ElevatedButton(
                            child: Text(!confirmarDespacho
                                ? 'Confirmar Despacho'
                                : 'Volver a Ficha'),
                            onPressed: () {
                              setState(() {
                                confirmarDespacho = !confirmarDespacho;
                              });
                            },
                          )),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (data.isNotEmpty &&
                        selectedProyecto.isNotEmpty &&
                        confirmarDespacho &&
                        pedidoSeleccionado != null) {
                      return Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.tertiary),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return SelectPdiAllPage(
                                      year: selectedYear,
                                      dataTable: dataForTable,
                                    );
                                  }),
                                );
                              },
                              child: const Text('Establecer PDI para Todos'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Tooltip(
                              message:
                                  "Se confirmarán solo los materiales que aparezcan con el (+) habilitado",
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.tertiary),
                                onPressed: () {
                                  for (SingleFEM row in dataForTable) {
                                    int ctd = aEntero(row.asRowDespacho2(
                                            pedidoSeleccionado:
                                                pedidoSeleccionado!)['Q'][
                                        0]); // me aseguro del null en la aparicion del boton
                                    var estdespachoObj =
                                        jsonDecode(row.estdespacho);
                                    bool noEstaPedido = estdespachoObj[0]
                                            [pedidoSeleccionado] ==
                                        '0';
                                    if (row.pdi != '' &&
                                        ctd > 0 &&
                                        noEstaPedido) {
                                      PdisSingle pdi = state.pdis!.pdisList
                                          .firstWhere((e) => e.lote == row.pdi,
                                              orElse: () =>
                                                  PdisSingle.fromZero());
                                      WbeSingle wbe = state.wbe!.wbeList
                                          .firstWhere((e) => e.wbe == row.wbe,
                                              orElse: () =>
                                                  WbeSingle.fromZero());
                                      PedidosSingle newPedido = PedidosSingle(
                                        pedido: pedidoSeleccionado!,
                                        id: row.id,
                                        e4e: row.e4e,
                                        descripcion: row.descripcion,
                                        ctdi: ctd.toString(),
                                        ctdf: "",
                                        um: row.um,
                                        comentario: row.comentario2,
                                        solicitante: FirebaseAuth
                                                .instance.currentUser!.email ??
                                            "",
                                        tipoenvio: row.tipo == ''
                                            ? 'PDI'
                                            : 'PLATAFORMA',
                                        pdi: row.pdi,
                                        pdiname: pdi.almacen,
                                        proyecto: row.proyecto,
                                        ref: row.circuito,
                                        wbe: row.wbe,
                                        wbeproyecto: wbe.proyecto,
                                        wbeparte: wbe.wbe1,
                                        wbeestado: wbe.status,
                                        fecha: DateTime.now()
                                            .toString()
                                            .substring(0, 16),
                                        estado: "Solicitado",
                                        lastperson: FirebaseAuth
                                                .instance.currentUser!.email ??
                                            "",
                                      );
                                      BlocProvider.of<MainBloc>(context)
                                          .add(AddCesta(
                                        pedido: pedidoSeleccionado!,
                                        singleFEM: row,
                                        year: selectedYear,
                                        isSingle: false,
                                      ));
                                    }
                                  }
                                },
                                child: const Text("Confirmar Todo"),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Builder(
                  builder: (context) {
                    if (data.isNotEmpty) {
                      List<Widget> titlerow = [];
                      List<Widget> titlerow2 = [];
                      if (confirmarDespacho) {
                        data[0].asRowDespacho(mes: '11', q: '1').forEach(
                          (k, v) {
                            switch (k) {
                              case 'Q':
                              case 'A':
                                titlerow.add(
                                  Expanded(
                                    flex: v[1],
                                    child: Center(
                                      child: Text(
                                        k,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                break;
                              case 'Causar?':
                                titlerow.add(
                                  Expanded(
                                    flex: v[1],
                                    child: Tooltip(
                                      message:
                                          'Si es positivo no ingresará a inventario de contratista',
                                      child: Text(
                                        k,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                break;
                              default:
                                titlerow.add(
                                  Expanded(
                                    flex: v[1],
                                    child: Text(
                                      k,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                            }
                          },
                        );
                      } else {
                        data[0].titles.forEach((key, value) {
                          titlerow2.add(
                            Expanded(
                              flex: value[0],
                              child: Text(
                                key,
                                style: TextStyle(
                                  color: value[2],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        });

                        data[0].asRow.forEach(
                          (k, v) {
                            switch (k) {
                              case '01':
                              case '02':
                              case '03':
                              case '04':
                              case '05':
                              case '06':
                              case '07':
                              case '08':
                              case '09':
                              case '10':
                              case '11':
                              case '12':
                                titlerow.add(
                                  Expanded(
                                    flex: v[1],
                                    child: Center(
                                      child: Text(
                                        k,
                                        style: TextStyle(
                                          color: v[2],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                break;
                              default:
                                titlerow.add(
                                  Expanded(
                                    flex: v[1],
                                    child: Text(
                                      k,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                            }
                          },
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: titlerow2,
                            ),
                            Row(
                              children: titlerow,
                            ),
                          ],
                        ),
                      );
                    }
                    return const Expanded(
                      child: Center(
                        child: Text(
                            'Por favor seleccione un año para cargar datos'),
                      ),
                    );
                  },
                ),
                BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    if (selectedProyecto.isEmpty) {
                      return const Text('Seleccione un proyecto');
                    }

                    return DataTableW(
                      data: dataForTable,
                      selectedProyecto: selectedProyecto,
                      selectedCircuito: selectedCircuito,
                      pedidoSeleccionado: pedidoSeleccionado.toString(),
                      confirmarDespacho: confirmarDespacho,
                      year: selectedYear,
                      pedido: dataDespacho,
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class DataTableW extends StatefulWidget {
  const DataTableW({
    super.key,
    required this.data,
    required this.selectedProyecto,
    required this.selectedCircuito,
    required this.pedidoSeleccionado,
    required this.confirmarDespacho,
    required this.year,
    required this.pedido,
  });

  final List<SingleFEM> data;
  final String selectedProyecto;
  final String selectedCircuito;
  final String year;
  final String pedido;
  final bool confirmarDespacho;
  final String pedidoSeleccionado;

  @override
  State<DataTableW> createState() => _DataTableWState();
}

class _DataTableWState extends State<DataTableW> {
  late List<SingleFEM> data2;
  final ScrollController _controller = ScrollController();
  int listMax = 70;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // BlocProvider.of<MainBloc>(context).add(ListLoadMore(table: 'Mb51B'));
      // print("reach the bottom");
      setState(() {
        listMax += 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.length >= listMax) {
      data2 = widget.data.sublist(0, listMax);
    } else {
      data2 = widget.data;
    }
    // data2.sort((a, b) => int.parse(a.e4e).compareTo(int.parse(b.e4e)));

    return Expanded(
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: data2.length,
          itemBuilder: (context, index) {
            // print('index: $index');
            // print('data2.length: ${data2.length}');
            // print('data2: ${data2[index]}');
            return RowDataW(
              dataW: data2[index],
              confirmarDespacho: widget.confirmarDespacho,
              year: widget.year,
              pedido: widget.pedido,
              pedidoSeleccionado: widget.pedidoSeleccionado,
            );
          },
        ),
      ),
    );
  }
}
