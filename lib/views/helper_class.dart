import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/budeget_models.dart';

class DB_Helper {
  DB_Helper._();

  static final DB_Helper db_helper = DB_Helper._();
  static Database? db;

  Future initdB() async {
    String dbpath = await getDatabasesPath();
    String path = await join(dbpath, "budget.db");
    print("------------");
    print("Created.....");
    print("------------");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE budget(category_name TEXT,category_image TEXT)");
      },
    );
  }

  Future<int?> addCategory({required BudgetModel dbModel}) async {
    await initdB();
    String query =
        "INSERT INTO budget(category_name,category_image) VALUES(?,?):";
    List arg = [dbModel.category_name, dbModel.category_image];
    int? res = await db?.rawInsert(query, arg);
    return res;
  }

  Future<List<BudgetModel>> fetchAllData() async {
    await initdB();
    String query = "SELECT * FROM budget;";
    List<Map<String, dynamic>>? responce = await db?.rawQuery(query);

    List<BudgetModel> allData =
        responce!.map((e) => BudgetModel.fromSQL(data: e)).toList();
    return allData;
  }

  Future<int?> DeleteData({required int id}) async {
    await initdB();
    String Query = "DELETE FROM budget WHERE id = ?";
    List args = [id];

    int? res = await db?.rawDelete(Query, args);
    return res;
  }
}
