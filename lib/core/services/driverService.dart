import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nebengdong/config/urls.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';
import 'package:nebengdong/utils/dio_interceptor.dart';
import 'package:nebengdong/utils/shared_prefferences_helper.dart';

class DriverService {
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

  DriverService() {
    dio.options.baseUrl = UriApi.BASE_API_URL;
    dio.interceptors.add(DioLogingIntercepotrs());
  }

  Future findPassengerApi() async {
    var token = await SharedPrefs.getToken();
    try {
      final response = await dio.put(
        UriApi.findPassengerApi,
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
        print("Get Passenger Success");
        return compute(responseNoDataModelFromJson, json.encode(response.data));
      }
    } on DioError catch (e) {
      print("Error Get Passenger : Status Code = ${e.response!.data}");
    }
  }
}
