import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nebengdong/config/urls.dart';
import 'package:nebengdong/core/models/registerModel.dart';

class RegisterService {
  final Dio dio = Dio();

  RegisterService() {
    dio.options.baseUrl = UriApi.BASE_API_URL;
  }

  Future addNewUser(RegisterPost data) async {
    String cred = "difa:12345";
    String credEnc = utf8.fuse(base64).encode(cred);
    print(credEnc);

    try {
      final response = await dio.post(
        UriApi.registerApi,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Basic $credEnc"
          },
        ),
        data: {
          "name": data.name,
          "email": data.email,
          "password": data.password,
          "phoneNumber": data.phoneNumber,
          "isDriver": data.isDriver,
          "vehicleLicensePlate": data.vehicleLicensePlate,
          "vehicleModel": data.vehicleModel,
          "vehicleManufature": data.vehicleManufature
        },
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 201) {
        // ignore: avoid_print
        print("Add User Success");
        return compute(registerModelFromJson, json.encode(response.data));
      }
    } on DioError catch (e) {
      print("Error Add User : Status Code = ${e.response!.data}");
      print(e.response!.data);
      if (e.response!.statusCode == 409) {
        return compute(registerModelFromJson, json.encode(e.response!.data));
      }
    }
  }
}

class RegisterPost {
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isDriver;
  String? vehicleLicensePlate;
  String? vehicleModel;
  String? vehicleManufature;

  RegisterPost(
      {this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.isDriver,
      this.vehicleLicensePlate,
      this.vehicleModel,
      this.vehicleManufature});
}
