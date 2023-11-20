import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nebengdong/config/urls.dart';
import 'package:nebengdong/core/models/getActiveShareRideByDriverModel.dart';
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
      if (statusCode == 400 ||
          statusCode == 403 ||
          statusCode == 404 ||
          statusCode == 409) {
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

  Future findPassenger() async {
    var token = await SharedPrefs.getToken();
    try {
      final response = await dio.post(
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
      print("Find Passenger Success");
      return compute(responseNoDataModelFromJson, json.encode(response.data));
    } on DioError catch (e) {
      print("Error Find Passenger : Status Code = ${e.response!.data}");
    }
  }

  Future getPassenger() async {
    var token = await SharedPrefs.getToken();
    try {
      final response = await dio.get(
        UriApi.driverActiveShareRideApi,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
        ),
      );
      print(response.statusCode);
      print(response.data);
      print("Get Passenger Success");
      return compute(
          getActiveShareRideByDriverModelFromJson, json.encode(response.data));
    } on DioError catch (e) {
      print("Error Get Passenger : Status Code = ${e.response!.data}");
    }
  }

  Future updateShareRide(int shareRideId, int passengerId, int status) async {
    var token = await SharedPrefs.getToken();
    var data = {"code": status};
    try {
      final response = await dio.put(
          "${UriApi.updateShareRideAPi}$shareRideId/passenger/$passengerId/status",
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              "Authorization": "Bearer $token"
            },
          ),
          data: data);
      print(response.statusCode);
      print(response.data);
      print("Update Passenger Success");
      return compute(responseNoDataModelFromJson, json.encode(response.data));
    } on DioError catch (e, stackTrace) {
      print("Stackt ${stackTrace.toString()}");
      print("Error Update Passenger : Status Code = ${e.toString()}");
    }
  }
}
