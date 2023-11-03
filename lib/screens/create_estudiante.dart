import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option.dart';
import '../providers/estudiante.dart';

class CreateEstudianteScreen extends StatelessWidget {
  const CreateEstudianteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CreateForm();
  }
}

class _CreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EstudianteProvider estudianteProvider =
        Provider.of<EstudianteProvider>(context);

    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);

    return Form(
      key: estudianteProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: "Ingrese el nombre"),
            onSaved: (value) {
              estudianteProvider.nombre = value!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'El campo no puede estar vacío';
              }
            },
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: "Ingrese el apellido"),
            onSaved: (newValue) {
              estudianteProvider.apellido = newValue!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'El campo no puede estar vacío';
              }
            },
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Ingrese su edad"),
            onSaved: (newValue) {
              if (newValue != null) {
                estudianteProvider.edad = int.tryParse(newValue)!;
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'El campo no puede estar vacío';
              }
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.greenAccent,
            onPressed: estudianteProvider.isLoading
                ? null
                : () {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!estudianteProvider.isValidForm()) return;

                    if (estudianteProvider.createOrUpdate == 'create') {
                      estudianteProvider.addEstudiante();
                      estudianteProvider.loadEstudiante();
                    } else {
                      estudianteProvider.updateEstudiante();
                    }
                    estudianteProvider.resetEstudianteData();
                    estudianteProvider.isLoading = false;
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  estudianteProvider.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
