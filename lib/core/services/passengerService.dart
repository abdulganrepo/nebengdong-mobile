import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nebengdong/config/urls.dart';
import 'package:nebengdong/core/models/getShareRideByPassengerModel.dart';
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
      if (statusCode == 400 || statusCode == 404 || statusCode == 409) {
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

  Future findDriver(
      double lat, double long, double distance, int totalAmount) async {
    var token = await SharedPrefs.getToken();
    try {
      var data = {
        "destinationCoordinate": {"lat": lat, "long": long},
        "distance": distance,
        "costPerKm": 10000
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
      print("Get Driver Success");
      return compute(responseNoDataModelFromJson, json.encode(response.data));
    } on DioError catch (e) {
      print("Error Get Driver : Status Code = ${e.response!.data}");
    }
  }

  Future getStatusShareDrive() async {
    var token = await SharedPrefs.getToken();
    try {
      final response = await dio.get(
        UriApi.passangerShareRideApi,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
        ),
      );
      print(response.statusCode);
      print(response.data);
      print("Get Status Driver Success");
      return compute(
          getShareRideByPassengerModelFromJson, json.encode(response.data));
    } on DioError catch (e) {
      print("Error Get Status Driver : Status Code = ${e.response!.data}");
    }
  }
}
