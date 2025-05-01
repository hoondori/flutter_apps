import 'package:bamtol_market_app/user/model/user_model.dart';
import 'package:bamtol_market_app/user/repository/authentication_repository.dart';
import 'package:bamtol_market_app/user/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:bamtol_market_app/common/enum/authentication_status.dart';

class AuthenticationController extends GetxController {
  AuthenticationController(this._authenticationRepository, this._userRepository);

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  Rx<AuthenticationStatus> status = AuthenticationStatus.init.obs;
  Rx<UserModel> userModel = const UserModel().obs;

  void authCheck() async {
    _authenticationRepository.user.listen((user) {
      _userStateChangedEvent(user);
    });
  }

  void _userStateChangedEvent(UserModel? user) async {
    if (user == null) {
      // unknown:  비로그인 상태
      status(AuthenticationStatus.unknown);
    } else {
      // user가 db에 등록되어 있는지 확인해서
      var result = await _userRepository.findUserOne(user.uid!);
      if (result == null) { // 등록되지 않았다면 회원 가입으로 유도
        status(AuthenticationStatus.unauthenticated);
      } else { // 등록되어 있다면 Home으로 이동
        status(AuthenticationStatus.authentication);
      }
    }
  }

  void logout() async {
    _authenticationRepository.logout();
  }
}