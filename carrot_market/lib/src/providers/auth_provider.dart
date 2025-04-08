import 'package:get/get.dart';
import 'provider.dart';

class AuthProvider extends Provider {

  // 휴대폰 인증 코드 요청
  Future<Map> requestPhoneCode(String phone) async {
    final Response response = await post('/auth/phone', {'phone': phone});
    return response.body;
  }

  // 휴대폰 인증 요청
  Future<Map> verifyPhoneNumber(String code) async {
    final Response response = await post('/auth/phone', {'code': code});
    return response.body;
  }

  // 회원 가입
  Future<Map> register(String phone, String password, String name, [int? profile]) async {
    final Response response = await post('/api/register',
        {
          'phone': phone,
          'password': password,
          'name': name,
          'profile': profile
        }
    );
    return response.body;
  }
}