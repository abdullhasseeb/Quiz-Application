
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz/model/questions_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;


class DatabaseHelper {

  static const dbName = 'questions.db';
  static const dbVersion = 1;
  static const dbTableName = 'questions';
  static const dbQuizTypeTable = 'quiz_type';
  static const columnId = 'id';
  static const columnQuestion = 'question';
  static const columnOptions = 'options';
  static const columnCorrectOption = 'correct_option';
  static const columnQuizType = 'quiz_type';

  static final DatabaseHelper instance = DatabaseHelper();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    //get path to store file from assets to path
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);

    // ready to open database file from assets
    if (io.FileSystemEntity.typeSync(path) == io.FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load('assets/database/$dbName');
      List<int> bytes = data.buffer.asUint8List();
      await io.File(path).writeAsBytes(bytes, flush: true);
    }
    // finally open database
    return await openDatabase(path, version: dbVersion);
  }

  /// this method is used to create and open database
  // Future<Database> _initDatabase() async {
  //   io.Directory directory = await getApplicationDocumentsDirectory();
  //   String path = join(directory.path, '$dbName');
  //   return openDatabase(path, version: dbVersion, onCreate: _onCreate );
  // }

  /// Create Database
  // Future<void> _onCreate(Database db, int version) async {
  //   // Define your table creation SQL statement here
  //   await db.execute('''
  //     CREATE TABLE $dbTableName (
  //       $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
  //       $columnQuestion TEXT,
  //       $columnOptions TEXT,
  //       $columnCorrectOption INTEGER,
  //       $columnQuizType TEXT
  //     )
  //   ''');
  //   await db.execute('''
  //   CREATE TABLE $dbQuizTypeTable (
  //   $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
  //   $columnQuizType TEXT
  //   )
  //   ''');
  // }

  // Insert questions into questions table
  // it is only used for insert questions into database
  insertInitialData(QuestionsModel questionsModel) async {
    Database? db = await database;
    // Insert your initial data into the questions table
      await db!.insert(
          dbTableName,
          questionsModel.toMap()
      );
  }

  /// Used to store quiz types in quiz_type table
  // insertIntoQuizType(String quizType)async{
  //   Database? db = await database;
  //   await db!.insert(dbQuizTypeTable, {'$columnQuizType' : quizType});
  // }

  // fetch Questions from database file
  Future<List<QuestionsModel>> getQuestions() async {
    Database? db = await database;
    List<Map<String, Object?>> list = await db!.query(dbTableName);
    return list.map((e) => QuestionsModel.fromMap(e)).toList();
  }

  // fetch quiz type from database
  Future<List<Map<String, dynamic>>> getQuizName ()async{
    Database? db = await database;
    List<Map<String, Object?>> list = await db!.query(dbQuizTypeTable);
    return list;
  }

  //get database path where database stored
  // this database path is already existed by flutter
  //get external storage path to backup our database file (questions.db)
  //this method is used only know and get the path and paste into below methods
  getDBPath() async{
    String databasePath = await getDatabasesPath();
   // print('=========databasePath: $databasePath');
    io.Directory? externalStoragePath = await getExternalStorageDirectory();
    //print('=========externalStoragePath: $externalStoragePath');
  }

  //backup questions.db file into mobile storage which we can see
  backupDB()async{
    var status = await Permission.manageExternalStorage.status;
    if(!status.isGranted){
      await Permission.manageExternalStorage.request();
    }
    var status1 = await Permission.storage.status;
    if(!status1.isGranted){
      await Permission.storage.request();
    }
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);

    try{
      io.File ourDBFile = io.File(
        path
      );
      io.Directory? folderPathForDBFile = io.Directory('/storage/emulated/0/EmployeesDatabase/');
      await folderPathForDBFile.create();
      await ourDBFile.copy('/storage/emulated/0/EmployeesDatabase/$dbName');
    }catch(e){
    //  print('=====================${e.toString()}');
    }
  }

  // it is used to restore db file at database path which already flutter gives
  restoreDB()async{
    var status  = await Permission.manageExternalStorage.status;
    if(!status.isGranted){
      await Permission.manageExternalStorage.request();
    }
    var status1 = await Permission.storage.status;
    if(!status1.isGranted){
      await Permission.storage.request();
    }

    try{
      io.File savedDBFile = io.File('/storage/emulated/0/EmployeesDatabase/$dbName');
      await savedDBFile.copy('/data/user/0/com.example.quiz/databases/$dbName');
    }catch(e){
      //print('============${e.toString()}');
    }
  }
}
