import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nebengdong/config/urls.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';
import 'package:nebengdong/utils/dio_interceptor.dart';
import 'package:nebengdong/utils/shared_prefferences_helper.dart';

class PassengerService {
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

  PassengerService() {
    dio.options.baseUrl = UriApi.BASE_API_URL;
    dio.interceptors.add(DioLogingIntercepotrs());
  }

  Future findDriver() async {
    var token = await SharedPrefs.getToken();
    try {
      var data = {
        "destinationCoordinate": {"lat": 80.0, "long": -80.00},
        "distance": 10.1,
        "costPerKm": 1000
      };

      final response = await dio.post(
        UriApi.findDriverApi,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
        ),
        data: data,
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print("Get Driver Success");
        return compute(responseNoDataModelFromJson, json.encode(response.data));
      }
    } on DioError catch (e) {
      print("Error Get Driver : Status Code = ${e.response!.data}");
    }
  }
}
