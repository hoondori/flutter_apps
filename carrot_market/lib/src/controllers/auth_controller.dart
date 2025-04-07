import 'dart:async';

import 'package:carrot_market/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  // 인증 제공자
  final authProvider = Get.put(AuthProvider());

  // 휴대폰 인증 폼 활성화 여부 (인증 코드 발송 후 활성화된다)
  final RxBool showVerifyForm = false.obs;

  // TODO
  final RxString buttonText = "인증 문자 받기".obs;

  // 휴대폰 인증 번호 요청 버튼 상태
  final RxBool isButtonEnabled = false.obs;

  // 인증받은 휴대폰 번호
  String? phoneNumber;

  // TODO
  Timer? countdownTimer;

  // 휴대폰 인증 코드 요청
  Future<void> requestVerificationCode(String phone) async {
    Map body = await authProvider.requestPhoneCode(phone) {
      if (body['result'] == 'ok') {
        phoneNumber = phone; // 인증받은 번호 기억

        // 인증 코드의 유효기간 정보를 가지고 count down timer 활성화
        DateTime expiryTime = DateTime.parse(body['expired']);
        _startCountDown(expiryTime);
      }
    }
  }

  // 회원 가입
  Future<bool> register(String password, String name, int? profile) async {
    Map body = await authProvider.register(phoneNumber, password, name, profile);
    if (body['result'] == 'ok') {
      return true;
    }
    // 실패시
    Get.snackbar('회원 가입 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  void _startCountDown(DateTime expiryTime) {
    // 유효 기간 내에는 다시 인증 요청을 할 수 없게 해야 한다.
    isButtonEnabled.value = false;

    // 유효 기간 동안 인증 코드 입력을 할 수 있다.
    showVerifyForm.value = true;

    // 기존 타이머가 있으면 취소
    countdownTimer?.cancel();

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Duration timeDiff = expiryTime.difference(DateTime.now());

      // 유효 기간 동안 1초 간격으로 잔여 시간을 UI에 갱신한다.
      if (!timeDiff.isNegative) {
        String minutes = timeDiff.inMinutes.toString().padLeft(2, '0');
        String seconds = (timeDiff.inSeconds % 60).toString().padLeft(2, '0');
        buttonText.value = "인증 문자 다시 받기 $minutes:$seconds";
      } else {
        // 시간이 만료되면 인증 코드 요청 버튼을 다시 활성화시킨다.
        buttonText.value = "인증 문자 다시 받기";
        isButtonEnabled.value = true;
        countdownTimer?.cancel();
      }
    });
  }

  // phone 입력을 확인/변경하고 조건에 맞으면 휴대폰 인증 번호 요청 버튼을 enable로 바꾼다.
  // 회원 가입시와 로그인시 모두 활용된다.
  void updateButtonState(TextEditingController phoneController) {
    String rawText = phoneController.text;

    // 하이픈 제거
    String text = rawText.replaceAll("-", "");

    // 사용자가 모든 내용을 삭제하려 할때 010만 남김니다.
    if (text.length <= 3 && !rawText.startsWith("010")) {
      text = '010';
    } else { // 혹은 입력된 텍스트가 010으로 시작하지 않으면 010을 자동으로 추가합니다.
      text = '010$text';
    }

    // 최대 길이를 11자로 제한
    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    String formattedText = _formatPhoneNumber(text);

    // 커서 위치 조정
    int cursorPosition = phoneController.selection.baseOffset +
        (formattedText.length - rawText.length);

    phoneController.value = TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: cursorPosition >= formattedText.length ? formattedText.length : cursorPosition,
      ),
    );

    // 버튼 상태 변경 (길이만 맞으면 submit 가능)
    isButtonEnabled.value = text.length == 11;
  }

  String _formatPhoneNumber(String text) {

    // 하이픈 자동 삽입 : 1111111 => 111-1111,   0101111111 => 010-111-1111
    if (text.length > 3 && text.length <= 7) {
      return '${text.substring(0, 3)}-${text.substring(3)}';
    } else if(text.length >7 ){
      return '${text.substring(0, 3)}-${text.substring(3, 7)}-${text.substring(7)}';
    }

    return text;
  }

}