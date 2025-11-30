import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/version.dart';
import 'package:fem_app/nuevo/view/nuevo_u_header.dart';
import 'package:fem_app/nuevo/view/nuevo_u_list.dart';
import 'package:intl/intl.dart';

class NuevoPage extends StatefulWidget {
  const NuevoPage({super.key});

  @override
  State<NuevoPage> createState() => _NuevoPageState();
}

class _NuevoPageState extends State<NuevoPage> {
  // final TextEditingController _controller2 = TextEditingController();
  // final FocusNode _focusNode = FocusNode();
  // final GlobalKey _autocompleteKey = GlobalKey();
  final uSFormat = NumberFormat.currency(
    locale: "en_US",
    symbol: "\$",
    decimalDigits: 0,
  );
  int endList = 70;
  final List<String> typeView = ["Proyecto", "Circuito", "E4e", "Todos"];
  String typeViewSelected = "Proyecto";
  final List<String> typeYear = [
    // "2022",
    // "2023",
    // "2024",
    "2025",
    "2026",
    "2027",
    "2028"
  ];
  String typeYearSelected = "2025";
  List<Map<String, dynamic>> listaTitulo = [];
  bool order = false;
  String type = "";
  String proyectoSeleccionado = '';

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        // if (state.isLoading) return Center(child: CircularProgressIndicator());
        return Scaffold(
          appBar: AppBar(
            title: const Text('NUEVO'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: BlocSelector<MainBloc, MainState, bool>(
                selector: (state) => state.isLoading,
                builder: (context, state) {
                  return state ? const LinearProgressIndicator() : const SizedBox();
                },
              ),
            ),
            actions: [
              ElevatedButton(
                child: const Text('Guardar'),
                onPressed: () {
                  context.read<MainBloc>().add(
                        ModNuevo(
                          tabla: 'nuevoSave',
                          campo: '',
                          valor: '',
                        ),
                      );
                },
              ),
            ],
          ),
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Version().data,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  "Conectado como: ${FirebaseAuth.instance.currentUser!.email}, Fecha y hora: ${DateTime.now().toString()}, Página actual: nuevoPage",
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
          ],
          body: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  HeaderNuevo(),
                  ListNuevo(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
