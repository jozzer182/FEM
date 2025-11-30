import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/disponibilidad/model/disponibilidad_model.dart';
import 'package:fem_app/nuevo/model/nuevo_model.dart';

import '../../model/fem_model_single_fem.dart';

class ChangeMsg extends StatefulWidget {
  ChangeMsg({
    required this.mes,
    required this.year,
    required this.singleFEM,
    super.key,
  });

  final String mes;
  final String year;
  final SingleFEM singleFEM;

  @override
  State<ChangeMsg> createState() => _ChangeMsgState();
}

class _ChangeMsgState extends State<ChangeMsg> {
  TextEditingController q1New = TextEditingController();
  TextEditingController q2New = TextEditingController();
  int q1Old = 0;
  int q2Old = 0;
  int q1Ficha = 0;
  int q2Ficha = 0;
  bool tryChangeQ1 = false;
  bool tryChangeQ2 = false;

  @override
  void initState() {
    q1New.text = obtenerQ1(widget.singleFEM, widget.mes);
    q2New.text = obtenerQ2(widget.singleFEM, widget.mes);
    q1Old = aEntero(q1New.text);
    q2Old = aEntero(q2New.text);
    q1New
      ..addListener(() {
        setState(() {});
      });
    q2New
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  int aEntero(String valor) {
    if (valor == "") {
      return 0;
    } else {
      return int.parse(valor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        //traer los qFicha
        q1Ficha = aEntero(obtenerQ1(widget.singleFEM, widget.mes));
        q2Ficha = aEntero(obtenerQ2(widget.singleFEM, widget.mes));

        //se verifica si el pedido esta activo
        EnableDate? enabled =
            state.fechasFEM!.enableDates(widget.year)[widget.mes];

        //Se verifica si hay disponibilidad de elemento a agregar.
        DisponibilidadSingle disponibilidadSingle = state
            .disponibilidad!.disponibilidadList
            .firstWhere((el) => el.e4e == widget.singleFEM.e4e,
                orElse: () => DisponibilidadSingle.fromInit());
        int disponible = int.parse(disponibilidadSingle.total);
        //Se suma el valor de las actuales quincenas abiertas
        if (disponible > 0) {
          if (enabled!.pedidoActivoq1) disponible += q1Old;
          if (enabled.pedidoActivoq2) disponible += q2Old;
        }

        //Debemos traer el total para versiones cerradas...
        int planificado = 0;
        planificado = state.fem!.ctdTotal[widget.singleFEM.e4e]!;

        //y el total de lo actualmente pedido..
        int actual = 0;
        Map dataMap = widget.singleFEM.toMapInt();
        for (var quin in state.fechasFEM!.closedVersions()) {
          actual += dataMap[quin] as int;
        }
        int newValue = aEntero(q1New.text) + aEntero(q2New.text);

        //definimos el color del borde
        int disponibleCerrado = planificado - actual;
        // if (disponibleCerrado <= 0) disponibleCerrado = 0;
        bool esVersionCerrada = !(enabled?.versionActivaq2 ?? false);
        bool hayDisponiblePlanificado = disponible > planificado;
        bool sePideMasQueLoDisponible = newValue > disponible;
        bool sePideMasQueLoCerrado = newValue > disponibleCerrado;
        Color borde = Colors.black;
        bool q1Changed = aEntero(q1New.text) != q1Ficha;
        bool q2Changed = aEntero(q2New.text) != q2Ficha;
        bool q1ChangedUpper = aEntero(q1New.text) > q1Ficha;
        bool q2ChangedUpper = aEntero(q2New.text) > q2Ficha;
        if (esVersionCerrada && (q1ChangedUpper || q2ChangedUpper)) {
          if (hayDisponiblePlanificado) {
            borde = sePideMasQueLoDisponible ? Colors.red : Colors.black;
          } else {
            borde = sePideMasQueLoCerrado ? Colors.red : Colors.black;
          }
        }
        //Detectamos si hay cambio y los ejecutamos en el singleFEM
        bool isValid = borde == Colors.black;
        if (isValid && q1Changed) {
          tryChangeQ1 = false;
          setQ1(context);
        } else if (!isValid && q1Changed && !tryChangeQ1) {
          tryChangeQ1 = true;
          setQ1Init(context);
        }
        if (isValid && q2Changed) {
          tryChangeQ2 = false;
          setQ2(context);
        } else if (!isValid && q2Changed && !tryChangeQ2) {
          tryChangeQ2 = true;
          setQ2Init(context);
        }

        return AlertDialog(
          title: Text('MES: ${widget.mes} - ${widget.year}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.singleFEM.e4e),
              Text(widget.singleFEM.descripcion),
              const SizedBox(height: 10),
              SizedBox(
                width: 100,
                child: TextField(
                  enabled: enabled?.pedidoActivoq1,
                  controller: q1New,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Q1',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borde,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borde,
                        width: 2,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 100,
                child: TextField(
                  enabled: enabled?.pedidoActivoq2,
                  controller: q2New,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Q2',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borde,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borde,
                        width: 2,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(height: 10),
              enabled!.versionActivaq2
                  ? const SizedBox()
                  : SizedBox(
                      child: Column(
                        children: [
                          if (hayDisponiblePlanificado)
                            Text('Disponible:  $disponible')
                          else
                            Text(
                                'Disponible:  $disponibleCerrado($disponible)'),
                          Text('Planificado:  $planificado'),
                          Text('Actual:  $actual'),
//                           const Text(
//                             '''*Para cambio de mensualización en versiones
// cerradas sin material disponible,
// se debe dejar en cero primero, aceptar,
// para después incluir nuevamente las cantidades''',
//                             style: TextStyle(fontSize: 9.0),
//                           ),
                        ],
                      ),
                    )
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () {
                if (borde != Colors.red) {
                  context.read<MainBloc>().add(
                        ModFemList(
                          year: widget.year,
                          singleFEM: widget.singleFEM,
                          field: 'ctd',
                          mes: widget.mes,
                          q: '1',
                          value: q1New.text,
                        ),
                      );
                  context.read<MainBloc>().add(
                        ModFemList(
                          year: widget.year,
                          singleFEM: widget.singleFEM,
                          field: 'ctd',
                          mes: widget.mes,
                          q: '2',
                          value: q2New.text,
                        ),
                      );
                  Navigator.of(context).pop();
                }
              },
            ),
            ElevatedButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setQ2(BuildContext context) {
    context.read<MainBloc>().add(
          ModFemList(
            year: widget.year,
            singleFEM: widget.singleFEM,
            field: 'ctd',
            mes: widget.mes,
            q: '2',
            value: q2New.text,
          ),
        );
  }

  void setQ1(BuildContext context) {
    context.read<MainBloc>().add(
          ModFemList(
            year: widget.year,
            singleFEM: widget.singleFEM,
            field: 'ctd',
            mes: widget.mes,
            q: '1',
            value: q1New.text,
          ),
        );
  }

  void setQ2Init(BuildContext context) {
    context.read<MainBloc>().add(
          ModFemList(
            year: widget.year,
            singleFEM: widget.singleFEM,
            field: 'ctd',
            mes: widget.mes,
            q: '2',
            value: q2Old.toString(),
          ),
        );
  }

  void setQ1Init(BuildContext context) {
    context.read<MainBloc>().add(
          ModFemList(
            year: widget.year,
            singleFEM: widget.singleFEM,
            field: 'ctd',
            mes: widget.mes,
            q: '1',
            value: q1Old.toString(),
          ),
        );
  }
}

String obtenerQ1(SingleFEM singleFEM, String mes) {
  switch (mes) {
    case '01':
      return singleFEM.m01q1;
    case '02':
      return singleFEM.m02q1;
    case '03':
      return singleFEM.m03q1;
    case '04':
      return singleFEM.m04q1;
    case '05':
      return singleFEM.m05q1;
    case '06':
      return singleFEM.m06q1;
    case '07':
      return singleFEM.m07q1;
    case '08':
      return singleFEM.m08q1;
    case '09':
      return singleFEM.m09q1;
    case '10':
      return singleFEM.m10q1;
    case '11':
      return singleFEM.m11q1;
    case '12':
      return singleFEM.m12q1;
    default:
      return '0';
  }
}

String obtenerQ2(SingleFEM singleFEM, String mes) {
  switch (mes) {
    case '01':
      return singleFEM.m01q2;
    case '02':
      return singleFEM.m02q2;
    case '03':
      return singleFEM.m03q2;
    case '04':
      return singleFEM.m04q2;
    case '05':
      return singleFEM.m05q2;
    case '06':
      return singleFEM.m06q2;
    case '07':
      return singleFEM.m07q2;
    case '08':
      return singleFEM.m08q2;
    case '09':
      return singleFEM.m09q2;
    case '10':
      return singleFEM.m10q2;
    case '11':
      return singleFEM.m11q2;
    case '12':
      return singleFEM.m12q2;
    default:
      return '0';
  }
}
