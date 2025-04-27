import 'package:bamtol_market_app/user/model/user_model.dart';
import 'package:bamtol_market_app/user/repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:bamtol_market_app/common/enum/authentication_status.dart';

class AuthenticationController extends GetxController {
  AuthenticationController(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;
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
      // authentication or unauthentication
    }
  }

  void logout() async {
    _authenticationRepository.logout();
  }
}