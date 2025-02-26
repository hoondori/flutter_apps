import 'package:firebase_database/firebase_database.dart';

class Memo {
  String? key;
  String? title;
  String? content;
  String? createTime;

  Memo(this.title, this.content, this.createTime);

  Memo.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key;

    // snapshot.value가 Map인지 확인 후 안전하게 캐스팅
    if (snapshot.value is Map) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      title = data['title'] ?? 'No Title';
      content = data['content'] ?? 'No Content';
      createTime = data['createTime'] ?? 'Unknown Time';
    } else {
      // 예외 처리: 데이터가 올바르지 않은 경우 기본값 할당
      title = 'No Title';
      content = 'No Content';
      createTime = 'Unknown Time';
    }
  }

  toJson() {
    return {
      'title': title,
      'content': content,
      'createTime': createTime,
    };
  }
}