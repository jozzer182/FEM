import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/fem/model/fem_model_single_fem.dart';
import 'package:fem_app/resources/descarga_hojas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (loading)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                List<SingleFEM> ficha = await context
                    .read<MainBloc>()
                    .historicoController()
                    .obtenerFicha("f2022");
                DescargaHojas().ahora(datos: ficha, nombre: "f2022");
                setState(() {
                  loading = false;
                });
              },
              child: const Text('2022'),
            ),
          if (loading)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                List<SingleFEM> ficha = await context
                    .read<MainBloc>()
                    .historicoController()
                    .obtenerFicha("f2023");
                DescargaHojas().ahora(datos: ficha, nombre: "f2023");
                setState(() {
                  loading = false;
                });
              },
              child: const Text('2023'),
            ),
          if (loading)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                List<SingleFEM> ficha = await context
                    .read<MainBloc>()
                    .historicoController()
                    .obtenerFicha("f2024");
                DescargaHojas().ahora(datos: ficha, nombre: "f2024");
                setState(() {
                  loading = false;
                });
              },
              child: const Text('2024'),
            ),
        ],
      )),
    );
  }
}
