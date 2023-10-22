import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nebengdong/config/urls.dart';
import 'package:nebengdong/core/models/userModel.dart';
import 'package:nebengdong/utils/shared_prefferences_helper.dart';

class UserService {
  final Dio dio = Dio();

  UserService() {
    dio.options.baseUrl = UriApi.BASE_API_URL;
  }

  Future getUserProfile() async {
    var token = await SharedPrefs.getToken();
    try {
      final response = await dio.get(
        UriApi.userProfileApi,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
        ),
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print("Get User Success");
        return compute(userProfileModelFromJson, json.encode(response.data));
      }
    } on DioError catch (e) {
      print("Error Add User : Status Code = ${e.response!.data}");
      print(e.response!.data);
      if (e.response!.statusCode == 409) {
        // return compute(registerModelFromJson, json.encode(e.response!.data));
      }
    }
  }
}
