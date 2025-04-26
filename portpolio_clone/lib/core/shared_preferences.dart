import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  // 한번만 생성됨을 보장
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._();

  factory SharedPreferencesManager() {
    return _instance; // 항상 같은 인스턴스 반환
  }

  SharedPreferencesManager._(); // 실제 생성자는 private하게 숨김

  //SharedPreferences는 비동기로 초기화돼야 하기 때문에, 앱 시작 시에 init()을 호출해서 미리 준비해두는 방식이야.
  //  보통 main() 함수에서 앱 시작 전에 이걸 초기화해줘야 해
  late SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool? getBool(String key) => prefs.getBool(key);
  Future<bool> setBool(String key, bool value) => prefs.setBool(key, value);

}

