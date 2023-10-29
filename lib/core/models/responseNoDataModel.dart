import 'dart:convert';

ResponseNoDataModel responseNoDataModelFromJson(String str) =>
    ResponseNoDataModel.fromJson(json.decode(str));

String responseNoDataModelToJson(ResponseNoDataModel data) =>
    json.encode(data.toJson());

class ResponseNoDataModel {
  int? code;
  String? status;
  Null? data;
  String? message;

  ResponseNoDataModel({this.code, this.status, this.data, this.message});

  ResponseNoDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
