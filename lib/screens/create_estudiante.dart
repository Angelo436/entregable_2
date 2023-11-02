import 'package:flutter/material.dart';
import 'package:entregable_2/providers/actual_option.dart';
import 'package:provider/provider.dart';

import '../providers/estudiante.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

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
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: estudianteProvider.nombre,
            decoration: const InputDecoration(
                hintText: 'Construir Apps',
                labelText: 'Titulo',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) => estudianteProvider.nombre = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            maxLines: 10,
            autocorrect: false,
            initialValue: estudianteProvider.apellido,
            // keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Aprender sobre Dart...',
              labelText: 'Descripción',
            ),
            onChanged: (value) => estudianteProvider.apellido = value,
            validator: (value) {
              return (value != null) ? null : 'El campo no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: estudianteProvider.isLoading
                ? null
                : () {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!estudianteProvider.isValidForm()) return;

                    if (estudianteProvider.createOrUpdate == 'create') {
                      estudianteProvider.addEstudiante();
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
