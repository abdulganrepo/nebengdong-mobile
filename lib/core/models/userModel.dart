import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  int? code;
  String? status;
  Data? data;
  String? message;

  UserProfileModel({this.code, this.status, this.data, this.message});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  Null? password;
  int? coin;
  Null? coordinate;
  bool? isEmailVerified;
  Null? emailVerifiedAt;
  bool? isDriver;
  List<Vehicles>? vehicles;
  String? createdAt;
  Null? updatedAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.password,
      this.coin,
      this.coordinate,
      this.isEmailVerified,
      this.emailVerifiedAt,
      this.isDriver,
      this.vehicles,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    coin = json['coin'];
    coordinate = json['coordinate'];
    isEmailVerified = json['isEmailVerified'];
    emailVerifiedAt = json['emailVerifiedAt'];
    isDriver = json['isDriver'];
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicles.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['coin'] = this.coin;
    data['coordinate'] = this.coordinate;
    data['isEmailVerified'] = this.isEmailVerified;
    data['emailVerifiedAt'] = this.emailVerifiedAt;
    data['isDriver'] = this.isDriver;
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Vehicles {
  int? id;
  String? type;
  String? model;
  String? licensePlate;
  String? manufacture;
  String? createdAt;

  Vehicles(
      {this.id,
      this.type,
      this.model,
      this.licensePlate,
      this.manufacture,
      this.createdAt});

  Vehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    model = json['model'];
    licensePlate = json['licensePlate'];
    manufacture = json['manufacture'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['model'] = this.model;
    data['licensePlate'] = this.licensePlate;
    data['manufacture'] = this.manufacture;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
