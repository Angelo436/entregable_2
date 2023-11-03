import "dart:io";

import "package:path_provider/path_provider.dart";
import "package:sqflite/sqflite.dart";

import "package:path/path.dart";

import '../models/estudiante_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'EstudianteDB.db');

    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) => {},
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE estudiante(
            id INTEGER PRIMERY KEY,
            nombre TEXT,
            apellido TEXT,
            edad INTEGER
          )
          ''');
      },
    );
  }

  Future<int> newEstudianteRaw(Estudiante estudiante) async {
    final int? id = estudiante.id;
    final String nombre = estudiante.nombre;
    final String apellido = estudiante.apellido;
    final int edad = estudiante.edad;

    final db = await database;

    final int res = await db.rawInsert('''

      INSERT INTO estudiante(id,nombre,apellido,edad) values ($id,$nombre,$apellido,$edad)

      ''');
    print(res);
    return res;
  }

  Future<int> newEstudiante(Estudiante estudiante) async {
    final db = await database;

    final int res = await db.insert("estudiante", estudiante.toJson());

    return res;
  }

  Future<List<Estudiante>> getAllEstudiantes() async {
    final Database? db = await database;
    final res = await db!.query('estudiante');
    //Transformamos con la funcion map instancias de nuestro modelo. Si no existen registros, devolvemos una lista vacia
    return res.isNotEmpty
        ? res.map((n) => Estudiante.fromJson(n)).toList()
        : [];
  }

  Future<int> updateEstudiante(Estudiante estudiante) async {
    final Database db = await database;

    //con updates, se usa el nombre de la tabla, seguido de los valores en formato de Mapa, seguido del where con parametros posicionales y los argumentos finales
    final res = await db.update('estudiante', estudiante.toJson(),
        where: 'id = ?', whereArgs: [estudiante.id]);

    return res;
  }

  Future<int> deleteEstudiante(int id) async {
    final Database db = await database;
    final int res =
        await db.delete('estudiante', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllEstudiantes() async {
    final Database db = await database;
    final res = await db.rawDelete('''
      DELETE FROM estudiante    
    ''');
    return res;
  }
}
