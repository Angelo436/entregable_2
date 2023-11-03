import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option.dart';
import 'package:provider/provider.dart';

import '../providers/estudiante.dart';
import '../models/estudiante_model.dart';

class ListEstudianteScreen extends StatelessWidget {
  const ListEstudianteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ListEstudiante();
  }
}

class _ListEstudiante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EstudianteProvider estudianteProvider =
        Provider.of<EstudianteProvider>(context);

    final columns = ['ID', 'Nombre', 'Apellido', 'Edad'];

    final estudiante = estudianteProvider.estudiante;

    return DataTable(
      columns: getColumns(columns),
      rows: getRows(estudianteProvider),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(EstudianteProvider estudiantes) =>
      estudiantes.estudiante.map((Estudiante estudiante) {
        final cells = [
          estudiante.id,
          estudiante.nombre,
          estudiante.apellido,
          estudiante.edad
        ];
        return DataRow(
          cells: getCells(cells),
          onLongPress: () {
            estudiantes.deleteEstudianteById(estudiante.id!);
          },
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) => DataCell(
            Text('$data'),
          ))
      .toList();

  void displayDialog(
      BuildContext context, EstudianteProvider estudianteProvider, int id) {
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
                    estudianteProvider.deleteEstudianteById(id);
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }
}
