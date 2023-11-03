import 'package:flutter/material.dart';

import 'package:notes_crud_local_app/screens/create_estudiante.dart';
import 'package:notes_crud_local_app/screens/list_estudiantes.dart';
import 'package:provider/provider.dart';

import '../providers/estudiante.dart';
import '../providers/actual_option.dart';
import '../widgets/custom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Estudiantes")),
          backgroundColor: Colors.greenAccent,
        ),
        body: _HomeScreenBody(),
        bottomNavigationBar: const CustomNavigatorBar());
  }
}

class _HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);

    int selectedOption = actualOptionProvider.selectedOption;

    switch (selectedOption) {
      case 0:
        return const ListEstudianteScreen();
      case 1:
        return const CreateEstudianteScreen();
      default:
        return const ListEstudianteScreen();
    }
  }
}
