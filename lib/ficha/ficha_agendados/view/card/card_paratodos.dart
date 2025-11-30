import 'package:fem_app/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../fem/model/fem_model_single_fem_enum.dart';
import '../../../../nuevo/model/nuevo_model.dart';
import '../../../../pdis/model/pdis_model.dart';
import '../../../../resources/field_pre/field_pre_texto.dart';
import '../dialogos/pdis_seleccionar.dart';

class PedidosCardParaTodos extends StatefulWidget {
  final List<String> items;
  const PedidosCardParaTodos({
    super.key,
    required this.items,
  });

  @override
  State<PedidosCardParaTodos> createState() => _PedidosCardParaTodosState();
}

class _PedidosCardParaTodosState extends State<PedidosCardParaTodos> {
  String cto = '';
  String pdi = '';
  String causar = '';
  String comentario = '';
  String tipo = '';
  bool m01b1 = false;
  bool m01b2 = false;
  bool m02b1 = false;
  bool m02b2 = false;
  bool m03b1 = false;
  bool m03b2 = false;
  bool m04b1 = false;
  bool m04b2 = false;
  bool m05b1 = false;
  bool m05b2 = false;
  bool m06b1 = false;
  bool m06b2 = false;
  bool m07b1 = false;
  bool m07b2 = false;
  bool m08b1 = false;
  bool m08b2 = false;
  bool m09b1 = false;
  bool m09b2 = false;
  bool m10b1 = false;
  bool m10b2 = false;
  bool m11b1 = false;
  bool m11b2 = false;
  bool m12b1 = false;
  bool m12b2 = false;

  @override
  Widget build(BuildContext context) {
    List<PdisSingle> pdisList = context.watch<MainBloc>().state.pdis!.pdisList;
    String year = context.read<MainBloc>().state.year!.substring(2, 4);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          const Text(
            'Aplicar a todos',
            style: TextStyle(fontSize: 11),
          ),
          Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: SizedBox(
                height: 38,
                child: BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) {
                    Map<String, EnableDate> dates = state
                        .ficha!.fichaPedidos.fechasFEM
                        .enableDates(state.year!);
                    EnableDate m01 = dates['01']!;
                    EnableDate m02 = dates['02']!;
                    EnableDate m03 = dates['03']!;
                    EnableDate m04 = dates['04']!;
                    EnableDate m05 = dates['05']!;
                    EnableDate m06 = dates['06']!;
                    EnableDate m07 = dates['07']!;
                    EnableDate m08 = dates['08']!;
                    EnableDate m09 = dates['09']!;
                    EnableDate m10 = dates['10']!;
                    EnableDate m11 = dates['11']!;
                    EnableDate m12 = dates['12']!;

                    return Row(
                      children: [
                        const Text(
                          '00',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FieldTexto(
                                flex: null,
                                label: 'cto',
                                size: 14,
                                edit: true,
                                initialValue: cto,
                                asignarValor: (value) {
                                  setState(() {
                                    cto = value.toUpperCase();
                                    context
                                        .read<MainBloc>()
                                        .fichaPedidosController()
                                        .paraTodos(
                                          items: widget.items,
                                          tipo: TipoFem.circuito,
                                          value: value.toUpperCase(),
                                        );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(4),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  FieldTexto(
                                    flex: 1,
                                    label: 'Pdi',
                                    size: 14,
                                    edit: true,
                                    opciones: pdisList
                                        .map((e) => '${e.lote} - ${e.almacen}'),
                                    initialValue: pdi,
                                    asignarValor: (value) {
                                      if (pdisList
                                          .map(
                                              (e) => '${e.lote} - ${e.almacen}')
                                          .contains(value)) {
                                        setState(() {
                                          pdi = value;
                                          context
                                              .read<MainBloc>()
                                              .fichaPedidosController()
                                              .paraTodos(
                                                items: widget.items,
                                                tipo: TipoFem.pdi,
                                                value: value,
                                              );
                                        });
                                      } else {
                                        pdi = '';
                                        context
                                            .read<MainBloc>()
                                            .fichaPedidosController()
                                            .paraTodos(
                                              items: widget.items,
                                              tipo: TipoFem.pdi,
                                              value: '',
                                            );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 14, // Ancho deseado
                                    height: 14, // Alto deseado
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return PdisDescripcionAgendadosDialog(
                                              items: widget.items,
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        fixedSize: const Size(14, 14),
                                      ),
                                      child: const Icon(
                                        Icons.search,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              FieldTexto(
                                flex: null,
                                label: 'Causar',
                                size: 14,
                                edit: true,
                                opciones: const ['SI', 'NO'],
                                initialValue: causar,
                                asignarValor: (value) {
                                  setState(() {
                                    causar = value;
                                    context
                                        .read<MainBloc>()
                                        .fichaPedidosController()
                                        .paraTodos(
                                          items: widget.items,
                                          tipo: TipoFem.proyectowbe,
                                          value: value,
                                        );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(4),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FieldTexto(
                                flex: null,
                                label: 'Comentario',
                                edit: true,
                                size: 14,
                                initialValue: comentario,
                                asignarValor: (value) {
                                  setState(() {
                                    comentario = value;
                                    context
                                        .read<MainBloc>()
                                        .fichaPedidosController()
                                        .paraTodos(
                                          items: widget.items,
                                          tipo: TipoFem.comentario2,
                                          value: value,
                                        );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(2),
                        SizedBox(
                          width: 25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FieldTexto(
                                flex: null,
                                label: 'Tipo',
                                edit: true,
                                size: 14,
                                opciones: const ["PDI", "PLATAFORMA"],
                                initialValue: tipo,
                                asignarValor: (value) {
                                  if (["PDI", "PLATAFORMA"].contains(value)) {
                                    setState(() {
                                      tipo = value;
                                    });
                                    context
                                        .read<MainBloc>()
                                        .fichaPedidosController()
                                        .paraTodos(
                                          items: widget.items,
                                          tipo: TipoFem.tipo,
                                          value: value,
                                        );
                                  } else {
                                    setState(() {
                                      tipo = '';
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(2),
                        const SizedBox(
                          width: 18,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('q1', style: TextStyle(fontSize: 10)),
                              Text('q2', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                        const Gap(1),
                        // for (int i = 0; i < 12; i++)
                        Expanded(
                          flex: 1,
                          child: m01.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m01.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m01b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m01b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value
                                                                .toString(),
                                                            pedido:
                                                                '01|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m01.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m01b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m01b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value
                                                                .toString(),
                                                            pedido:
                                                                '01|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m02.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m02.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m02b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m02b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value
                                                                .toString(),
                                                            pedido:
                                                                '02|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m02.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m02b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m02b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value
                                                                .toString(),
                                                            pedido:
                                                                '02|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m03.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m03.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m03b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m03b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value
                                                                .toString(),
                                                            pedido:
                                                                '03|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m03.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m03b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m03b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value
                                                                .toString(),
                                                            pedido:
                                                                '03|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m04.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m04.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m04b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m04b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '04|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m04.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m04b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m04b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '04|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m05.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m05.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m05b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m05b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '05|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m05.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m05b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m05b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '05|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m06.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m06.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m06b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m06b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '06|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m06.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m06b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m06b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '06|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m07.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m07.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m07b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m07b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '07|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m07.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m07b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m07b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '07|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m08.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m08.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m08b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m08b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '08|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m08.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m08b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m08b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '08|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m09.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m09.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m09b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m09b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '09|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m09.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m09b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m09b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '09|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m10.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m10.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m10b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m10b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '10|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m10.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m10b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m10b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '10|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m11.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m11.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m11b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m11b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '11|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m11.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m11b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m11b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '11|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        Expanded(
                          flex: 1,
                          child: m12.versionActivaq2
                              ? const SizedBox.shrink()
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m12.pedidoActivoq1)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m12b1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m12b1 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '12|${year}-1');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        if (m12.pedidoActivoq2)
                                          Tooltip(
                                            message:
                                                "Solo se aplica si se cumplen las condiciones",
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: Transform.scale(
                                                scale: 0.4,
                                                child: Checkbox(
                                                  splashRadius: 22,
                                                  value: m12b2,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      m12b2 = value!;
                                                    });
                                                    context
                                                        .read<MainBloc>()
                                                        .fichaPedidosController()
                                                        .paraTodos(
                                                            items: widget.items,
                                                            tipo: TipoFem
                                                                .estdespacho,
                                                            value: value!
                                                                ? '1'
                                                                : '0',
                                                            pedido:
                                                                '12|${year}-2');
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(1),
                        const Expanded(
                          flex: 1,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
