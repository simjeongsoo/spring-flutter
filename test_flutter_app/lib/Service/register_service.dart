import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_flutter_app/Screens/login.dart';
import 'package:test_flutter_app/Service/token_service.dart';
import 'package:http/http.dart' as http;

Future<void> registerUser(BuildContext context, String username, String password, String nickname) async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8081/api/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'nickname': nickname,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      final token = responseJson['token'];

      // JWT 토큰 내부 저장소 저장
      TokenService().storeToken(token);

      // 로그인 화면으로 이동
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));

    } else {
      // 에러 메시지 출력
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Network error'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print(e);

    // 에러 메시지 출력
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('회원가입 실패'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
