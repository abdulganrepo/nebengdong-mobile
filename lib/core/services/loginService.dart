import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nebengdong/config/urls.dart';
import 'package:nebengdong/core/models/loginModel.dart';

class LoginService {
  final Dio dio = Dio();

  LoginService() {
    dio.options.baseUrl = UriApi.BASE_API_URL;
  }

  Future loginUser(String email, String password) async {
    String cred = "difa:12345";
    String credEnc = utf8.fuse(base64).encode(cred);
    print(credEnc);

    try {
      final response = await dio.post(
        UriApi.loginApi,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Basic $credEnc"
          },
        ),
        data: {"email": email, "password": password},
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print("Login User Success");
        return compute(loginModelFromJson, json.encode(response.data));
      }
    } on DioError catch (e) {
      print("Error Login User : Status Code = ${e.response!.data}");
    }
  }
}
