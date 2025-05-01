import 'package:bamtol_market_app/user/model/user_model.dart';
import 'package:bamtol_market_app/user/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final UserRepository _userRepository;
  final String uid;
  SignupController(this._userRepository, this.uid);

  RxString userNickName = ''.obs;
  RxBool isPossibleUserName = false.obs;

  @override
  void onInit() {
    super.onInit();
    /*
    debounce는 입력값이 변경될 때, 500ms 동안 변화가 없을 경우에만 콜백을 실행합니다.
    예: 사용자가 닉네임을 타이핑할 때, 매 글자마다 API 호출하지 않고 입력이 멈췄을 때만 호출하게 하려는 목적.
    callback 함수에는 실제 닉네임 검사 API 호출이나 검증 로직이 들어갈 수 있습니다
     */
    debounce(
      userNickName,
      checkDuplicationNickName, // callback
      time: const Duration(milliseconds: 500) // 0.5초 미입력시 callback 수행
    );
  }

  changeNickName(String nickName) {
    userNickName(nickName);
  }

  checkDuplicationNickName(String value) async {
    // 이미 있는 닉네임인지 여부 조사해서 없으면 가능하다고 외부에 알림
    var isPossibleUse = await _userRepository.checkDuplicationNickName(value);
    isPossibleUserName(isPossibleUse);
  }

  signup() async {
    var newUser = UserModel.create(userNickName.value, uid);
    var result = await _userRepository.signup(newUser);
    return result;
  }
}