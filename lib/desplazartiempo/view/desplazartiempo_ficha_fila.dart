import 'package:fem_app/fem/model/fem_model_single_fem_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../fem/model/fem_model_single_fem.dart';
import '../../resources/field_pre/field_pre_texto.dart';

class VistaFichaFilaDesplazarTiempo extends StatefulWidget {
  final SingleFEM fem;
  final String ano;
  const VistaFichaFilaDesplazarTiempo({
    required this.ano,
    required this.fem,
    super.key,
  });

  @override
  State<VistaFichaFilaDesplazarTiempo> createState() =>
      _VistaFichaFilaDesplazarTiempoState();
}

class _VistaFichaFilaDesplazarTiempoState
    extends State<VistaFichaFilaDesplazarTiempo> {
  List<String> meses = [
    'm01',
    'm02',
    'm03',
    'm04',
    'm05',
    'm06',
    'm07',
    'm08',
    'm09',
    'm10',
    'm11',
    'm12',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        List<String> proyectos = [];
        if (state.budget != null) {
          proyectos = state.budget!.budgetList
              .map((e) => e.proyecto.toUpperCase())
              .toList();
          proyectos.sort();
        }
        List<String> personas = [];
        if (state.personas != null) {
          personas = state.personas!.personasList
              .map((e) => e.email.toUpperCase())
              .toList();
          personas.sort();
        }
        List<String> unidades = [];
        if (state.budget != null) {
          unidades = state.budget!.budgetList
              .map((e) => e.ejecutor.toUpperCase())
              .toList();
          unidades.sort();
        }
        return SizedBox(
          height: 60,
          child: Row(
            children: [
              if (widget.fem.estado == 'nuevo')
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: FieldTexto(
                              flex: null,
                              size: 16,
                              edit: true,
                              label: 'Proyecto',
                              opciones: proyectos,
                              color: widget.fem.proyecto.isNotEmpty
                                  ? Colors.green
                                  : Colors.red,
                              initialValue: widget.fem.proyecto,
                              asignarValor: (value) {
                                BlocProvider.of<MainBloc>(context)
                                    .desplazarTiempoController()
                                    .lista
                                    .modificarEnum(
                                      ano: widget.ano,
                                      id: widget.fem.id,
                                      value: value,
                                      tipoFem: TipoFem.proyecto,
                                    );
                              },
                            ),
                          ),
                          const Gap(2),
                          Expanded(
                            flex: 1,
                            child: FieldTexto(
                              flex: null,
                              size: 16,
                              edit: false,
                              isNumber: true,
                              label: 'E4E',
                              color: widget.fem.e4e.length == 6
                                  ? Colors.green
                                  : Colors.red,
                              initialValue: widget.fem.e4e,
                              asignarValor: (value) {
                                BlocProvider.of<MainBloc>(context)
                                    .desplazarTiempoController()
                                    .lista
                                    .modificarEnum(
                                      ano: widget.ano,
                                      id: widget.fem.id,
                                      value: value,
                                      tipoFem: TipoFem.e4e,
                                    );
                              },
                            ),
                          ),
                          const Gap(2),
                          Expanded(
                            flex: 3,
                            child: FieldTexto(
                              flex: null,
                              size: 16,
                              edit: true,
                              label: 'Descripcion',
                              color: widget.fem.descripcion.isNotEmpty
                                  ? Colors.green
                                  : Colors.red,
                              initialValue: widget.fem.descripcion,
                              asignarValor: (value) {
                                BlocProvider.of<MainBloc>(context)
                                    .desplazarTiempoController()
                                    .lista
                                    .modificarEnum(
                                      ano: widget.ano,
                                      id: widget.fem.id,
                                      value: value,
                                      tipoFem: TipoFem.descripcion,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: FieldTexto(
                              flex: null,
                              size: 16,
                              edit: true,
                              label: 'PM',
                              opciones: personas,
                              color: widget.fem.pm.isNotEmpty
                                  ? Colors.green
                                  : Colors.red,
                              initialValue: widget.fem.pm,
                              asignarValor: (value) {
                                BlocProvider.of<MainBloc>(context)
                                    .desplazarTiempoController()
                                    .lista
                                    .modificarEnum(
                                      ano: widget.ano,
                                      id: widget.fem.id,
                                      value: value,
                                      tipoFem: TipoFem.pm,
                                    );
                              },
                            ),
                          ),
                          const Gap(2),
                          Expanded(
                            flex: 3,
                            child: FieldTexto(
                              flex: null,
                              size: 16,
                              edit: true,
                              label: 'Unidad',
                              opciones: unidades,
                              color: widget.fem.unidad.isNotEmpty
                                  ? Colors.green
                                  : Colors.red,
                              initialValue: widget.fem.unidad,
                              asignarValor: (value) {
                                BlocProvider.of<MainBloc>(context)
                                    .desplazarTiempoController()
                                    .lista
                                    .modificarEnum(
                                      ano: widget.ano,
                                      id: widget.fem.id,
                                      value: value,
                                      tipoFem: TipoFem.unidad,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          widget.fem.proyecto,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.fem.e4e,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          widget.fem.descripcion,
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Row(
                  children: [
                    for (String mes in meses)
                      Expanded(
                        child: Builder(builder: (context) {
                          List<String> quincenas = ['q1', 'q2'];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (String quincena in quincenas)
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: FieldTexto(
                                    flex: null,
                                    size: 16,
                                    edit: true,
                                    label: '$mes$quincena',
                                    color:
                                        widget.fem.toMapInt()['$mes$quincena'] >
                                                0
                                            ? Colors.green
                                            : null,
                                    initialValue: widget.fem
                                        .toMap()['$mes$quincena']
                                        .toString(),
                                    isNumber: true,
                                    asignarValor: (value) {
                                      // print('''ano: ${widget.ano},
                                      //       id: ${widget.fem.id},
                                      //       value: $value,
                                      //       campo: '$mes$quincena',''');
                                      BlocProvider.of<MainBloc>(context)
                                          .desplazarTiempoController()
                                          .lista
                                          .modificarCtd(
                                            ano: widget.ano,
                                            id: widget.fem.id,
                                            value: value,
                                            campo: '$mes$quincena',
                                          );
                                    },
                                  ),
                                ),
                            ],
                          );
                        }),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
