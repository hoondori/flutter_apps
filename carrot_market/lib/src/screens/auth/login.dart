import 'package:carrot_market/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carrot_market/src/controllers/feed_controller.dart';
import 'package:carrot_market/src/screens/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final authController = Get.put(AuthController());
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

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

  _submit() async {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Text('휴대폰 번호', style: Theme.of(context).textTheme.labelLarge,),
            const SizedBox(height: 8,),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: '휴대폰 번호를 입력해 주세요',
              ),
            ),
            const SizedBox(height: 16,),
            Text('비밀번호', style: Theme.of(context).textTheme.labelLarge,),
            const SizedBox(height: 8,),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: '비밀번호를 입력해 주세요',
              ),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('로그인')
            )
          ],
        ),
      ),
    );
  }
}

