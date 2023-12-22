import 'package:sqflite/sqlite_api.dart';
import 'package:test_flutter/core/storage/database/database.dart';
import 'package:test_flutter/feature/account/data/models/local/my_identity_model.dart';

class IdentityDatabase {
  static final IdentityDatabase _instance = IdentityDatabase.internal();

  factory IdentityDatabase() => _instance;

  IdentityDatabase.internal();

  final TestDatabase _testDatabase = TestDatabase();

  Future<MyIdentity?> getMyIdentity() async {
    Database db = await _testDatabase.initDB();
    var res = await db.rawQuery(
      'SELECT * '
      'From ${TestDatabase.kIdentity} ',
    );
    return res.isNotEmpty
        ? res.map((user) => MyIdentity.fromMap(user)).first
        : null;
  }

  deleteMyIdentity() async {
    Database db = await _testDatabase.initDB();
    final res = await db.delete(TestDatabase.kIdentity);
    return res != 0;
  }

  Future<bool> saveMyIdentity(MyIdentity identity) async {
    Database db = await _testDatabase.initDB();
    final getIdentityRes = await getMyIdentity();
    int res = 0;
    if (getIdentityRes != null) {
      res = await db.update(TestDatabase.kIdentity, identity.toMap());
    } else {
      res = await db.insert(TestDatabase.kIdentity, identity.toMap());
    }
    print(res);
    print("Asdgadsgd");
    if (res != 0) return true;
    return false;
  }
}
