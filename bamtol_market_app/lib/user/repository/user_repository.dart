import 'package:bamtol_market_app/user/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserRepository extends GetxService {
  FirebaseFirestore db;
  UserRepository(this.db);

  Future<UserModel?> findUserOne(String uid) async {
    try {
      var doc = await db.collection("users").where("uid", isEqualTo: uid).get();
      if (doc.docs.isEmpty) {
        return null;
      } else {
        return UserModel.fromJson(doc.docs.first.data());
      }
    } catch(e) {
      return null;
    }
  }
}