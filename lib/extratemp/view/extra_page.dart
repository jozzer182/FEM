
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fem_app/bloc/main_bloc.dart';
import 'package:fem_app/extratemp/view/extra_u_header.dart';
import 'package:fem_app/extratemp/view/extra_u_list.dart';
import 'package:fem_app/version.dart';
import 'package:intl/intl.dart';

class ExtraPage extends StatefulWidget {
  const ExtraPage({super.key});

  @override
  State<ExtraPage> createState() => _ExtraPageState();
}

class _ExtraPageState extends State<ExtraPage> {
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
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028"
  ];
  String typeYearSelected = "2022";
  List<Map<String, dynamic>> listaTitulo = [];
  bool order = false;
  String type = "";
  String proyectoSeleccionado = '';

  @override
  void initState() {

    super.initState();
  }


  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // var stringToEncode = DateTime.now().day.toString() + DateTime.now().month.toString() + DateTime.now().year.toString() + FirebaseAuth.instance.currentUser!.email.toString().substring(0, 3);
    // var bytesInLatin1 = latin1.encode(stringToEncode);
    // var base64encoded = base64Encode(bytesInLatin1);
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        // if (state.isLoading) return Center(child: CircularProgressIndicator());
        return Scaffold(
          appBar: AppBar(
            title: const Text('EXTRATEMPORAL'),
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
                          tabla: 'extraSave',
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
                  HeaderExtra(),
                  ListExtra(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
