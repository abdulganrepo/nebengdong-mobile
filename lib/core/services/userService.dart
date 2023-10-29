import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nebengdong/config/urls.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';
import 'package:nebengdong/core/models/userModel.dart';
import 'package:nebengdong/utils/dio_interceptor.dart';
import 'package:nebengdong/utils/shared_prefferences_helper.dart';

class UserService {
  final Dio dio = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    validateStatus: (statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 400) {
        // your http status code
        return true;
      } else {
        return statusCode >= 200 && statusCode < 300;
      }
    },
  ));

  UserService() {
    dio.options.baseUrl = UriApi.BASE_API_URL;
    dio.interceptors.add(DioLogingIntercepotrs());
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

  Future changePhoneNumber(String phoneNumber) async {
    var token = await SharedPrefs.getToken();
    try {
      final response = await dio.put(
        UriApi.userChangeNumber,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
        ),
        data: {"new": phoneNumber},
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print("Change Phone Number Success");
        return compute(responseNoDataModelFromJson, json.encode(response.data));
      }
    } on DioError catch (e, stackTrace) {
      print("Error Change Phone Number : Status Code = ${e.response!.data}");
      print("Error Change Phone StackTrace = ${stackTrace.toString()}");
      print(e.response!.data);
      if (e.response!.statusCode == 409) {
        return compute(
            responseNoDataModelFromJson, json.encode(e.response!.data));
      }
    }
  }

  Future changePassword(String oldPass, String newPass) async {
    var token = await SharedPrefs.getToken();
    try {
      final response = await dio.put(
        UriApi.userChangePassword,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
        ),
        data: {"old": oldPass, "new": newPass},
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 400) {
        // ignore: avoid_print
        print("Change Password Success");
        return compute(responseNoDataModelFromJson, json.encode(response.data));
      }
    } on DioError catch (e, stackTrace) {
      print("Error Change Password : Status Code = ${e.response!.data}");
      print("Error Change Password StackTrace = ${stackTrace.toString()}");
      print(e.response!.data);
      if (e.response!.statusCode == 409) {
        return compute(
            responseNoDataModelFromJson, json.encode(e.response!.data));
      }
    }
  }
}
