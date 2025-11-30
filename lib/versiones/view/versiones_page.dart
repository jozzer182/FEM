import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../model/versiones_model.dart';

class VersionOficialPage extends StatefulWidget {
  const VersionOficialPage({super.key});

  @override
  State<VersionOficialPage> createState() => _VersionOficialPageState();
}

class _VersionOficialPageState extends State<VersionOficialPage> {
  String year = '2024';
  String filter = '';
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

  @override
  void initState() {
    _controller.addListener(_onScroll);
    context.read<MainBloc>().fichasController().onSeleccionarYear(year: year);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Versiones Oficiales'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Uri url = Uri.parse(
                    'https://drive.google.com/drive/folders/1Fzsb4-cSES1JAuNQrghTskWfDs0uR2i6?usp=sharing');
                launchUrl(url);
              },
              child: Text('Archivos\nOficiales')),
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.versiones == null) return const SizedBox();
              List<VersionesSingle> version = [];
              if (state.fichas != null) {
                if (year == '2023') version = state.versiones?.v2023 ?? [];
                if (year == '2024') version = state.versiones?.v2024 ?? [];
                if (year == '2025') version = state.versiones?.v2025 ?? [];
                if (year == '2026') version = state.versiones?.v2026 ?? [];
                if (year == '2027') version = state.versiones?.v2027 ?? [];
                if (year == '2028') version = state.versiones?.v2028 ?? [];
              }
              return ElevatedButton(
                onPressed: () {
                  DescargaHojas().ahoraMap(
                    datos: version.map((e) => e.toMap()).toList(),
                    nombre: 'Fichas Oficiales del $year',
                  );
                },
                child: const Icon(Icons.download),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: year,
                    onChanged: (String? newValue) {
                      setState(() {
                        year = newValue!;
                      });
                      context
                          .read<MainBloc>()
                          .fichasController()
                          .onSeleccionarYear(year: year);
                    },
                    items: <String>[
                      '2023',
                      '2024',
                      '2025',
                      '2026',
                      '2027',
                      '2028'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Año',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
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
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  'Cód',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Proyecto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(1),
                Expanded(
                    child: Text(
                  'Un',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Ejecutor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(1),
                Expanded(
                    flex: 2,
                    child: Text(
                      'E4e',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Gap(1),
                Expanded(
                  flex: 7,
                  child: Text(
                    'Descripción',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(1),
                Expanded(
                    child: Text(
                  'm01',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm02',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm03',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm04',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm05',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm06',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm07',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm08',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm09',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm10',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm11',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'm12',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Gap(1),
                Expanded(
                    child: Text(
                  'total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ),
          const Gap(2),
          Expanded(
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                List<VersionesSingle> version = [];
                if (state.fichas != null) {
                  if (year == '2023') version = state.versiones?.v2023 ?? [];
                  if (year == '2024') version = state.versiones?.v2024 ?? [];
                  if (year == '2025') version = state.versiones?.v2025 ?? [];
                  if (year == '2026') version = state.versiones?.v2026 ?? [];
                  if (year == '2027') version = state.versiones?.v2027 ?? [];
                  if (year == '2028') version = state.versiones?.v2028 ?? [];
                  version = version
                      .where(
                        (el) => el.toList().any(
                              (e) => e.toLowerCase().contains(
                                    filter.toLowerCase(),
                                  ),
                            ),
                      )
                      .toList();
                }
                if (version.length > endList) {
                  version = version.sublist(0, endList);
                }
                return SingleChildScrollView(
                  controller: _controller,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      for (VersionesSingle reg in version)
                        Builder(builder: (context) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                reg.codigo,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  reg.proyecto,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.unidad,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  reg.pm,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const Gap(1),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    reg.e4e,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  )),
                              const Gap(1),
                              Expanded(
                                flex: 7,
                                child: Text(
                                  reg.descripcion,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m01,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m02,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m03,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m04,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m05,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m06,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m07,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m08,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m09,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m10,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m11,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.m12,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                              const Gap(1),
                              Expanded(
                                  child: Text(
                                reg.total.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              )),
                            ],
                          );
                        }),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
