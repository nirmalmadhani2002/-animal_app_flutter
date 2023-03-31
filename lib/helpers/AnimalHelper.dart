import 'dart:typed_data';
import '../modals/Animals.dart';
import 'image_api_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  final String dbName = "animalData.db";
  final String colId = "id";
  final String colTime = "time";
  final String colPrice = "price";
  final String colImage = "image";
  final String colName = "name";
  final String colDescription = "description";

  Database? db;

  Future<void> initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) async {});
    String query =
        "CREATE TABLE IF NOT EXISTS subscriptionPlans($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTime TEXT, $colPrice TEXT, $colImage BLOB);";
    await db?.execute(query);
    print("===================================");
    print("subscriptionPlan table Created");
    print("===================================");

    String query2 =
        "CREATE TABLE IF NOT EXISTS ${Global.animalDataTableName}Data($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT, $colImage BLOB);";
    await db?.execute(query2);
    print("===================================");
    print("${Global.animalDataTableName}Data table Created");
    print("===================================");
  }

  insertSubscriptionRecord() async {
    await initDB();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < Global.subscriptionPlans.length; i++) {
      Uint8List? image = await ImageAPIHelper.imageAPIHelper
          .getImage(name: "${i + 1}wild animal");
      String query =
          "INSERT INTO subscriptionPlans($colTime, $colPrice, $colImage) VALUES(?, ?, ?);";
      List args = [
        Global.subscriptionPlans[i].time,
        Global.subscriptionPlans[i].price,
        image,
      ];

      await db?.rawInsert(query, args);
    }
    prefs.setBool('subscriptionPlansIsEmpty', false);
  }

  updateSubscriptionRecord() async {
    await initDB();

    for (int i = 0; i < Global.subscriptionPlans.length; i++) {
      Uint8List? image = await ImageAPIHelper.imageAPIHelper
          .getImage(name: "${i + 1}wild animal");
      String query =
          "UPDATE subscriptionPlans SET $colTime=?, $colPrice=?,$colImage=? WHERE $colId=?;";
      List args = [
        Global.subscriptionPlans[i].time,
        Global.subscriptionPlans[i].price,
        image,
        i + 1,
      ];

      await db?.rawUpdate(query, args);
    }
  }

  Future<List<SubscriptionPlanDB>?> fetchAllSubscriptionPlanRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEmpty = prefs.getBool('subscriptionPlansIsEmpty') ?? true;

    (isEmpty)
        ? await insertSubscriptionRecord()
        : await updateSubscriptionRecord();

    String query = "SELECT * FROM subscriptionPlans";
    List<Map<String, dynamic>>? data = await db?.rawQuery(query);

    List<SubscriptionPlanDB>? subscriptionPlanData =
        data?.map((e) => SubscriptionPlanDB.fromData(e)).toList();

    return subscriptionPlanData;
  }

  insertAnimalRecord() async {
    await initDB();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < 5; i++) {
      Uint8List? image = await ImageAPIHelper.imageAPIHelper
          .getImage(name: Global.animalDataTableName);

      String query =
          "INSERT INTO ${Global.animalDataTableName}Data($colName, $colDescription, $colImage) VALUES(?, ?, ?);";
      List args = [
        Global.animalDataTableName,
        Global.animalDesc,
        image,
      ];

      await db?.rawInsert(query, args);
    }
    prefs.setBool('${Global.animalDataTableName}isEmpty', false);
  }

  updateAnimalDataRecord() async {
    await initDB();

    for (int i = 0; i < 5; i++) {
      Uint8List? image = await ImageAPIHelper.imageAPIHelper
          .getImage(name: Global.animalDataTableName);

      String query =
          "UPDATE ${Global.animalDataTableName}Data SET $colName=?, $colDescription=?, $colImage=? WHERE $colId = ?;";
      List args = [
        Global.animalDataTableName,
        Global.animalDesc,
        image,
        i + 1,
      ];

      await db?.rawUpdate(query, args);
    }
  }

  Future<List<AnimalDB>?> fetchAllAnimalRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isEmpty =
        prefs.getBool('${Global.animalDataTableName}isEmpty') ?? true;

    (isEmpty) ? await insertAnimalRecord() : await updateAnimalDataRecord();

    String query = "SELECT * FROM ${Global.animalDataTableName}Data;";
    List<Map<String, dynamic>>? data = await db?.rawQuery(query);

    List<AnimalDB>? animalData =
        data?.map((e) => AnimalDB.fromData(e)).toList();

    return animalData;
  }
}
