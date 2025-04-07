import 'package:carrot_market/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // 휴대폰 번호 입력의 변화를 감지하고 처리합니다.
  // Obx.isButtonEnabled 상태에 따라 인증 받기 버튼을 활성화합니다.

  final authController = Get.put(AuthController());
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener( () {
      authController.updateButtonState(_phoneController);
    });
  }

  @override
  void dispose() {
    _phoneController.removeListener(() {
      authController.updateButtonState(_phoneController);
    });
    super.dispose();
  }

  // 휴대폰 인증 코드 요청
  _submit() {
    authController.requestVerificationCode(_phoneController.text);
  }

  // 휴대폰 인증 요청
  _confirm() async {
    bool result = await authController.verifyPhoneNumber(_codeController.text);
    if (result) { // 인증 성공시 회원 가입 폼으로
      Get.to(() => const RegisterForm());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Text('휴대폰 번호를 인증해 주세요.', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8,),
            const Text('홍당무는 휴대폰 번호로 가입합니다.\n휴대폰 번호의 형태를 기입해 주세요.'),
            const SizedBox(height: 8,),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: '휴대폰 번호를 입력해 주세요',
              ),
            ),
            const SizedBox(height: 20,),
            Obx(
                () => ElevatedButton(
                  onPressed: authController.isButtonEnabled.value ? _submit : null,
                  child: const Text('인증 문자 받기'),
              )
            ),
            Visibility(
              visible: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20,),
                  TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: '인증 번호를 입력해 주세요',
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: null, child: const Text('인증 번호 확인')),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}


class Register1 extends StatelessWidget {
  const Register1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 가입'),
      ),
      body: const Center(
        child: Text('회원 가입 하시겠습니까?')
      ),
    );
  }
}
