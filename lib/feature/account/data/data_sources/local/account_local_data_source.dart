import 'package:test_flutter/core/storage/database/identity_database.dart';
import 'package:test_flutter/feature/account/data/models/local/my_identity_model.dart';

class AccountLocalDataSource {
  final IdentityDatabase _identityDatabase = IdentityDatabase();
  Future<MyIdentity?> getMyIdentity() async {
    return await _identityDatabase.getMyIdentity();
  }

  Future<bool> saveMyIdentity(MyIdentity identity) async {
    return await _identityDatabase.saveMyIdentity(identity);
  }

  Future<bool> deleteMyIdentity() async {
    return await _identityDatabase.deleteMyIdentity();
  }
}
