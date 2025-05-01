import 'package:bamtol_market_app/common/components/app_font.dart';
import 'package:bamtol_market_app/common/components/btn.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
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
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: '닉네임',
                hintStyle: TextStyle(color: Color(0xff6D7179)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff6D7179))
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6D7179))
                ),
              ),
              onChanged: (value) {}
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20 + MediaQuery.of(context).padding.bottom),
        child: Btn(
          onTap: () async {},
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




