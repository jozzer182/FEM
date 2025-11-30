import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:fem_app/resources/a_entero_2.dart';

import '../../bloc/main_bloc.dart';
import '../../disponibilidad/model/disponibilidad_ano_list.dart';
import '../../disponibilidad/model/disponibilidad_model.dart';
import 'analisiscodigo_page_table_fem.dart';
import 'analisiscodigo_page_table_oe.dart';
import 'analisiscodigo_page_table_otros.dart';

class AnalisisCodigoPage extends StatefulWidget {
  const AnalisisCodigoPage({super.key});

  @override
  State<AnalisisCodigoPage> createState() => _AnalisisCodigoPageState();
}

class _AnalisisCodigoPageState extends State<AnalisisCodigoPage> {
  String filter = '';
  String mes = 12.toString();
  String year = '2025';
  final uSFormat = NumberFormat.currency(
    locale: "en_US",
    symbol: "\$",
    decimalDigits: 0,
  );

  DateTime fechaSeleccionada = DateTime(2025, 12, 30);

  @override
  Widget build(BuildContext context) {
    // print('filter: $filter');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análisis Disponibilidad por Código'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            searchField(),
            const Divider(),
            TablaOe(
              fechaSeleccionada: fechaSeleccionada,
              filter: filter,
            ),
            const Divider(),
            TablaFem(
              fechaSeleccionada: fechaSeleccionada,
              filter: filter,
            ),
            const Divider(),
            TablaOtros(
              fechaSeleccionada: fechaSeleccionada,
              filter: filter,
            ),
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Código E4E',
                  ),
                  onChanged: (value) {
                    if (value.length == 6) {
                      setState(() {
                        filter = value;
                      });
                    } else {
                      setState(() {
                        filter = '';
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: 100,
                child: DropdownButtonFormField<String>(
                  value: mes,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      fechaSeleccionada = DateTime(
                        int.parse(year),
                        int.parse(newValue!) + 1,
                        1,
                      ).subtract(const Duration(days: 1));
                      mes = newValue;
                    });
                  },
                  items: <String>[
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '11',
                    '12'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mes',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              //Dropdown for year
              SizedBox(
                width: 100,
                child: DropdownButtonFormField<String>(
                  value: year,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      fechaSeleccionada = DateTime(
                        int.parse(newValue!),
                        int.parse(mes) + 1,
                        1,
                      ).subtract(const Duration(days: 1));
                      year = newValue;
                    });
                  },
                  items: <String>[
                    '2024',
                    '2025',
                    '2026',
                    '2027',
                    '2028',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Año',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state.disponibilidad == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (filter.length != 6) {
              return const SizedBox.shrink();
            }
            List<DisponibilidadSingle> dispList = state
                .disponibilidad!.disponibilidadList
                .where((disponibilidad) => disponibilidad.e4e.contains(filter))
                .toList();
            List<AnoList> anoList = state.disponibilidad!.anoList
                .where((e) => e.e4e.contains(filter))
                .toList();
            if (dispList.isEmpty || anoList.isEmpty) {
              return const Text('No hay datos para este código');
            }
            DisponibilidadSingle disp = dispList.first;
            AnoList anoListSingle = anoList.first;
            // print('disp: ${dispMes.toMap()}');
            // String mesW0 = mes.toString().padLeft(2, "0");
            int? disponibleMes = anoListSingle.mesList
                .firstWhere((e) =>
                    e.mes == fechaSeleccionada.month &&
                    e.ano == fechaSeleccionada.year)
                .proyectado;
            int precio = aEntero(state.mm60!.mm60List
                .where((mm60) => mm60.material.contains(filter))
                .first
                .precio);
            bool estaOeDemana =
                aEntero(disp.fem) + aEntero(disp.otros) + aEntero(disp.oe) > 0;
            // int totalOe = state.analisisCodigo!.totalOe;
            // int totalFem = state.analisisCodigo!.totalFem;
            // int totalOraCe = state.analisisCodigo!.totalOraCe;
            // int cobertura =
            //     aEntero(disp.plataforma) + totalOe - totalFem - totalOraCe;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                        'Disponibilidad mes $mes: $disponibleMes'),
                    Text(
                        'Rotura Stock: ${anoListSingle.roturaStock}'),
                    Text(
                        'Disponibilidad final (${disp.mesFin}): ${disp.total}'),
                    Text('Plataforma hoy: ${disp.plataforma}'),
                  ],
                ),
                const Gap(3),
                estaOeDemana
                    ? const SizedBox.shrink()
                    : Text(
                        'Descripción: ${disp.descripcion} - ${disp.um} - Precio: ${uSFormat.format(precio)}',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
              ],
            );
          },
        ),
      ],
    );
  }
}
