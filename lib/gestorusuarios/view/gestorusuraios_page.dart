import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GestorUsuariosPage extends StatefulWidget {
  const GestorUsuariosPage({super.key});

  @override
  State<GestorUsuariosPage> createState() => _GestorUsuariosPageState();
}

class _GestorUsuariosPageState extends State<GestorUsuariosPage> {
  DatabaseReference perfilesStream = FirebaseDatabase.instance.ref('perfiles');
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de Usuarios')),
      body: Center(
        child: SizedBox(
          width: 600,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(20),
                TextField(
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
                const Gap(20),
                StreamBuilder<DatabaseEvent>(
                    stream: perfilesStream.onValue,
                    builder: (context, snapshot) {
                      bool seRecibioUnMap =
                          snapshot.data?.snapshot.value is Map<String, dynamic>;
                      if (!seRecibioUnMap) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      Map<String, dynamic> listaDePerfiles =
                          snapshot.data?.snapshot.value as Map<String, dynamic>;
                      if (filter.isNotEmpty) {
                        listaDePerfiles.removeWhere((key, value) {
                          return !value['nombre']
                                  .toString()
                                  .toLowerCase()
                                  .contains(filter.toLowerCase()) &&
                              !value['email']
                                  .toString()
                                  .toLowerCase()
                                  .contains(filter.toLowerCase());
                        });
                      }
                      return SelectableRegion(
                        focusNode: FocusNode(),
                        selectionControls: emptyTextSelectionControls,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (MapEntry<String, dynamic> perfil
                                in listaDePerfiles.entries)
                              Card(
                                key: ValueKey(perfil.key),
                                elevation: 2,
                                child: ListTile(
                                  title: Text(perfil.value['nombre'] ?? ""),
                                  subtitle: Text(perfil.value['email'] ?? ""),
                                  trailing: SizedBox(
                                    width: 200,
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Perfil',
                                        border: OutlineInputBorder(),
                                      ),
                                      value: perfil.value['perfil'],
                                      onChanged: (value) {
                                        perfilesStream.update({
                                          '${perfil.key}/perfil': value,
                                        });
                                      },
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'contract',
                                          child: Text('CONTRACT'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'desactivado',
                                          child: Text('DESACTIVADO'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'funcional',
                                          child: Tooltip(
                                            message: 'Se incluye ingeniería',
                                            child: Text('FUNCIONAL'),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'pm',
                                          child: Text('PM'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'normas',
                                          child: Text('NORMAS'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'contratista',
                                          child: Text('CONTRATISTA'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
