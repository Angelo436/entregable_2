import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option.dart';
import 'package:notes_crud_local_app/providers/db.dart';
import 'package:notes_crud_local_app/providers/estudiante.dart';
import 'package:notes_crud_local_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DBProvider.db.database;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ActualOptionProvider()),
          ChangeNotifierProvider(create: (_) => EstudianteProvider())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: "main",
            routes: {'main': (_) => const HomeScreen()}));
  }
}
