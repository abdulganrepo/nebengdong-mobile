import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? code;
  String? status;
  Data? data;
  String? message;

  LoginModel({this.code, this.status, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  bool? isDriver;
  Token? token;

  Data({this.name, this.email, this.isDriver, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    isDriver = json['isDriver'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['isDriver'] = this.isDriver;
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}

class Token {
  String? value;
  int? expiresIn;

  Token({this.value, this.expiresIn});

  Token.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['expiresIn'] = this.expiresIn;
    return data;
  }
}
