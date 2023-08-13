import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepo {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> cookies = {};

  Future<List<Map<String, dynamic>>> get(String url) async {
    headers['Cookie'] = 'token=${await _initCookie()}';
    print('get() url: $url');
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      // 처리 코드 입력
    }
    return List.from(json.decode(utf8.decode(response.bodyBytes)));
  }

  Future<dynamic> post(String url, dynamic data, String token) async {
    http.Response response = await http.post(Uri.parse(url),
        body: json.encode(data), headers: headers);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      // 처리 코드 입력
    }
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<void> _saveCookie(String newCookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cookie = prefs.getString('cookie');

    if (cookie != newCookie) {
      cookie = newCookie;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('cookie', cookie);
    }
  }

  Future<void> getCookieFromHeader() async {
    final url = Uri.parse('http://192.168.155.223:3000/api/users/auth?token=0');

    final response = await http.get(url);

    if (response.headers.containsKey('set-cookie')) {
      final cookieHeader = response.headers['set-cookie'];

      _saveCookie(
        cookieHeader!.split('token=')[1].split('; Path=/')[0],
      );
    } else {}
  }

  Future<String> _initCookie() async {
    // shared preferences 얻기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookie = prefs.getString('cookie');

    return cookie!;
  }

  void _clearCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cookie');
  }
}
