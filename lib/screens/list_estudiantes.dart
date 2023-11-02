import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option.dart';
import 'package:provider/provider.dart';

import '../providers/estudiante.dart';

class ListNotesScreen extends StatelessWidget {
  const ListNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ListNotes();
  }
}

class _ListNotes extends StatelessWidget {
  void displayDialog(
      BuildContext context, EstudianteProvider notesProvider, int id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Alerta!'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿Quiere eliminar definitivamente el registro?'),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    notesProvider.deleteEstudianteById(id);
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    EstudianteProvider notesProvider = Provider.of<EstudianteProvider>(context);

    final notes = notesProvider.estudiante;

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.note),
        title: Text(notes[index].nombre),
        subtitle: Text(notes[index].id.toString()),
        trailing: PopupMenuButton(
          // icon: Icon(Icons.fire_extinguisher),
          onSelected: (int i) {
            if (i == 0) {
              notesProvider.createOrUpdate = "update";
              notesProvider.assignDataWithEstudiante(notes[index]);
              Provider.of<ActualOptionProvider>(context, listen: false)
                  .selectedOption = 1;
              return;
            }

            displayDialog(context, notesProvider, notes[index].id!);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 0, child: Text('Actualizar')),
            const PopupMenuItem(value: 1, child: Text('Eliminar'))
          ],
        ),
      ),
    );
  }
}
