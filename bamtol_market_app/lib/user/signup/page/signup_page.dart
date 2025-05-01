import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:bamtol_market_app/common/components/btn.dart';
import 'package:bamtol_market_app/user/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends GetWidget<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 99, height: 116, child: Image.asset('assets/images/logo_symbol.png'),),
            const SizedBox(height: 35,),
            Obx(
              () => TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '닉네임',
                  hintStyle: TextStyle(color: Color(0xff6D7179)),
                  errorText: controller.isPossibleUserName.value
                    ? null
                    : "이미 존재하는 닉네임입니다",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6D7179))
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff6D7179))
                  ),
                ),
                onChanged: controller.changeNickName,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20 + MediaQuery.of(context).padding.bottom),
        child: Btn(
          onTap: () async {
            if (!controller.isPossibleUserName.value) return;
            var result = controller.signup();
            if (result != null) {
              Get.offNamed('/');  // splash로 이동해서 결국 Home까지 흘러간다.
            }
          },
          child: const AppFont(
            '회원 가입',
            align: TextAlign.center,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        ),
      ),
    );
  }
}




