import 'package:carrot_market/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final authController = Get.put(AuthController());
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  _submit() async {
    bool result = await authController.register(
      _passwordController.text,
      _nameController.text,
      null,
    );

    if (result) { // 회원 가입 성공시 Home 이동
      Get.off(() => Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원 가입')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // 프로필 이미지
            const CircleAvatar(radius: 40, backgroundColor: Colors.grey,
              child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
            ),

            // 비밀번호
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

            // 비밀번호 확인
            const SizedBox(height: 16,),
            Text('비밀번호 확인', style: Theme.of(context).textTheme.labelLarge,),
            const SizedBox(height: 8,),
            TextField(
              obscureText: true,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: '비밀번호를 한번 더 입력해주세요',
              ),
            ),


            // 닉네임
            const SizedBox(height: 16,),
            Text('닉네임', style: Theme.of(context).textTheme.labelLarge,),
            const SizedBox(height: 8,),
            TextField(
              controller: _nameController,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: '닉네임을 입력해 주세요',
              ),
            ),

            // 가입 버튼
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('회원 가입'),
            ),
          ],
        ),
      ),
    )
  }
}
