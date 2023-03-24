import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TokenService {
  // 내부저장소
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // 로컬 저장소에 JWT 토큰 저장
  Future<void> storeToken(String token) async {
    final prefs = await _prefs;
    prefs.setString('jwtToken', token);
  }

// 로컬 저장소에서 JWT 토큰 검색
  Future<String> getToken() async {
    final prefs = await _prefs;
    return prefs.getString('jwtToken');
  }

// 사용자 로그아웃
  Future<void> logout() async {
    // Remove the JWT token from local storage
    final prefs = await _prefs;
    prefs.remove('jwtToken');
  }

// JWT 토큰이 로컬 저장소에 저장되어 있는지 확인후 헤더에 담아 리턴
  Future<Map<String, String>> tokenCheck() async {
    final prefs = await _prefs;
    String jwtToken = prefs.getString('jwtToken');

    if (jwtToken == null) {
      // 사용자를 로그인 화면으로 리디렉션
      print('로그인 페이지로 이동');
      // return;
    }

    Map<String, String> headers = {};

    headers['Content-Type'] = 'application/json; charset=UTF-8';
    headers['Authorization'] = 'Bearer $jwtToken';

    // 헤더에 토큰을 담아 리턴
    return headers;
  }

// 사용자가 인증되었는지 확인(true, false)
  Future<bool> isAuthenticated() async {
    String jwtToken = await getToken();

    if (jwtToken != null) {
      // JWT 토큰으로 서버에 요청하기
      http.Response response = await http.get(
        Uri.parse('http://10.0.2.2:8081/api/userauthenticationcheck'),
        // Uri.parse('http://localhost:8081/api/userauthenticationcheck'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      // 토큰이 유효한지 확인
      if (response.statusCode == 200) {
        // 토큰이 유효하면 true
        return true;
      } else {
        // 토큰이 유효하지 않으면 false
        return false;
      }
    } else {
      // 로컬 저장소에서 토큰을 찾을 수 없으면 false
      return false;
    }
  }

// 사용자 인증 정보
  Future<void> userAuthenticate(String username, String password) async {
    // 사용자의 자격 증명을 사용하여 서버에 요청을 보냅니다.
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8081/api/userauthenticationcheck'),
      // Uri.parse('http://localhost:8081/api/userauthenticationcheck'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${getToken()}'
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // 자격 증명이 유효한 경우 JWT 토큰을 로컬 저장소에 저장합니다.
      String jwtToken = jsonDecode(response.body)['token'];
      storeToken(jwtToken);
    } else {
      // Display an error message if the credentials are not valid
      print('Authentication failed');
    }
  }

}
