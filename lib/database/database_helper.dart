import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Clase encargada de crear/abrir la base de datos y exponer funciones básicas
class DatabaseHelper {
  // Singleton para reutilizar una sola instancia en toda la app
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  // Nombre de la base de datos (requisito de la actividad)
  static const String _dbName = 'usuarios.db';

  // Versión de la base de datos (si cambias estructura, subes versión)
  static const int _dbVersion = 1;

  // Nombre de la tabla (requisito de la actividad)
  static const String tableUsuarios = 'usuarios';

  // Instancia interna de la BD (se inicializa una sola vez)
  Database? _database;

  // Getter público: devuelve la BD lista para usar
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa y/o crea la base de datos en el dispositivo
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  // Crea la tabla usuarios la primera vez que se crea la BD
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUsuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        correo TEXT NOT NULL,
        telefono TEXT NOT NULL
      )
    ''');
  }
    // Inserta un usuario en la tabla usuarios
  Future<int> insertUser({
    required String nombre,
    required String correo,
    required String telefono,
  }) async {
    final db = await database;

    return db.insert(
      tableUsuarios,
      {
        'nombre': nombre,
        'correo': correo,
        'telefono': telefono,
      },
    );
  }

  // Obtiene el último usuario registrado (ORDER BY id DESC LIMIT 1)
  Future<Map<String, dynamic>?> getLastUser() async {
    final db = await database;

    final result = await db.query(
      tableUsuarios,
      orderBy: 'id DESC',
      limit: 1,
    );

    if (result.isEmpty) return null;
    return result.first;
  }
}