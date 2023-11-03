import 'package:flutter/material.dart';

import '../models/estudiante_model.dart';
import 'db.dart';

class EstudianteProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String createOrUpdate = 'create';
  int? id;
  String nombre = '';
  String apellido = '';
  int edad = 0;

  bool _isLoading = false;
  List<Estudiante> estudiante = [];

  bool get isLoading => _isLoading;

  set isLoading(bool opc) {
    _isLoading = opc;
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    return formKey.currentState?.validate() ?? false;
  }

  addEstudiante() async {
    final Estudiante estudiante =
        Estudiante(nombre: nombre, apellido: apellido, edad: edad);

    final id = await DBProvider.db.newEstudiante(estudiante);

    estudiante.id = id;

    this.estudiante.add(estudiante);

    notifyListeners();
  }

  loadEstudiante() async {
    final List<Estudiante> estudiante = await DBProvider.db.getAllEstudiantes();
    //operador Spreed
    this.estudiante = [...estudiante];
    notifyListeners();
  }

  updateEstudiante() async {
    final estudiante =
        Estudiante(id: id, nombre: nombre, apellido: apellido, edad: edad);
    final res = await DBProvider.db.updateEstudiante(estudiante);
    print("Id actualizado: $res");
    loadEstudiante();
  }

  deleteEstudianteById(int id) async {
    final res = await DBProvider.db.deleteEstudiante(id);
    loadEstudiante();
  }

  assignDataWithEstudiante(Estudiante estudiante) {
    id = estudiante.id;
    nombre = estudiante.nombre;
    apellido = estudiante.apellido;
    edad = estudiante.edad;
  }

  resetEstudianteData() {
    id = null;
    nombre = '';
    apellido = '';
    edad = 0;
    createOrUpdate = 'create';
  }
}
