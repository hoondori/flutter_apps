import 'package:firebase_database/firebase_database.dart';

class User {
  late String id;
  late String pw;
  late String createTime;

  User(this.id, this.pw, this.createTime);

  User.fromsnapshot(DataSnapshot snapshot) {
    // snapshot.value가 Map인지 확인 후 안전하게 캐스팅
    if (snapshot.value is Map) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      id = data['id'] ?? 'No id';
      pw = data['pw'] ?? 'No pw';
      createTime = data['createTime'] ?? 'Unknown Time';
    } else {
      // 예외 처리: 데이터가 올바르지 않은 경우 기본값 할당
      id = 'No id';
      pw = 'No pw';
      createTime = 'Unknown Time';
    }
  }

  toJson() {
    return {
      'id': id,
      'pw': pw,
      'createTime': createTime,
    };
  }

}