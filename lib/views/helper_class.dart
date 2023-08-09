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
}
