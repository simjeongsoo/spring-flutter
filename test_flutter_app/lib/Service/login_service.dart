import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:test_flutter_app/Service/token_service.dart';
import 'package:test_flutter_app/Screens/employeeDrawer.dart';

Future<void> loginUser(BuildContext context, String username, String password) async {
  try {
    // 사용자 자격증명(아이디,비밀번호) 로 토큰 발급
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8081/api/authenticate'),
      // Uri.parse('http://localhost:8081/api/authenticate'),
      // headers: headers,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      final token = responseJson['token']; // 'jwtToken'
      print('로그인 할때 발급받은 토큰 : ${token.toString()}');

      // JWT 토큰 내부 저장소 저장
      TokenService().storeToken(token);

      // employeeDrawer() 로 이동
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => employeeDrawer(),
          ));
    } else if(response.statusCode == 401){
      // 에러 메시지 출력
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('토큰이 유효하지 않습니다.'),
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
          content: Text('로그인 실패'),
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
