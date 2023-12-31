import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option.dart';
import 'package:notes_crud_local_app/providers/estudiante.dart';
import 'package:provider/provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);
    final EstudianteProvider notesProvider =
        Provider.of(context, listen: false);
    final currentIndex = actualOptionProvider.selectedOption;

    return BottomNavigationBar(
      //Current Index, para determinar el botón que debe marcarse
      currentIndex: currentIndex,
      onTap: (int i) {
        if (i == 1) {
          notesProvider.resetEstudianteData();
        }
        actualOptionProvider.selectedOption = i;
      },
      //Items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.groups), label: "Lista estudiantes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_add), label: "Agregar estudiante"),
      ],
    );
  }
}
