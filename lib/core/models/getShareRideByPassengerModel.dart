// To parse this JSON data, do
//
//     final getShareRideByPassengerModel = getShareRideByPassengerModelFromJson(jsonString);

import 'dart:convert';

GetShareRideByPassengerModel getShareRideByPassengerModelFromJson(String str) =>
    GetShareRideByPassengerModel.fromJson(json.decode(str));

String getShareRideByPassengerModelToJson(GetShareRideByPassengerModel data) =>
    json.encode(data.toJson());

class GetShareRideByPassengerModel {
  int? code;
  String? status;
  Data? data;
  String? message;

  GetShareRideByPassengerModel({
    this.code,
    this.status,
    this.data,
    this.message,
  });

  factory GetShareRideByPassengerModel.fromJson(Map<String, dynamic> json) =>
      GetShareRideByPassengerModel(
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  int? driverId;
  bool? isFull;
  int? driverStatus;
  DateTime? createdAt;
  dynamic finishedAt;
  List<Passenger>? passengers;
  Driver? driver;

  Data({
    this.id,
    this.driverId,
    this.isFull,
    this.driverStatus,
    this.createdAt,
    this.finishedAt,
    this.passengers,
    this.driver,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        driverId: json["driverId"],
        isFull: json["isFull"],
        driverStatus: json["driverStatus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        finishedAt: json["finishedAt"],
        passengers: json["passengers"] == null
            ? []
            : List<Passenger>.from(
                json["passengers"]!.map((x) => Passenger.fromJson(x))),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driverId": driverId,
        "isFull": isFull,
        "driverStatus": driverStatus,
        "createdAt": createdAt?.toIso8601String(),
        "finishedAt": finishedAt,
        "passengers": passengers == null
            ? []
            : List<dynamic>.from(passengers!.map((x) => x.toJson())),
        "driver": driver?.toJson(),
      };
}

class Driver {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;

  Driver({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}

class Passenger {
  int? id;
  int? status;
  DestinationCoordinate? destinationCoordinate;
  double? distance;
  DateTime? createdAt;
  dynamic droppedAt;
  List<Payment>? payment;
  Driver? user;

  Passenger({
    this.id,
    this.status,
    this.destinationCoordinate,
    this.distance,
    this.createdAt,
    this.droppedAt,
    this.payment,
    this.user,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        id: json["id"],
        status: json["status"],
        destinationCoordinate: json["destinationCoordinate"] == null
            ? null
            : DestinationCoordinate.fromJson(json["destinationCoordinate"]),
        distance: json["distance"]?.toDouble(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        droppedAt: json["droppedAt"],
        payment: json["payment"] == null
            ? []
            : List<Payment>.from(
                json["payment"]!.map((x) => Payment.fromJson(x))),
        user: json["user"] == null ? null : Driver.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "destinationCoordinate": destinationCoordinate?.toJson(),
        "distance": distance,
        "createdAt": createdAt?.toIso8601String(),
        "droppedAt": droppedAt,
        "payment": payment == null
            ? []
            : List<dynamic>.from(payment!.map((x) => x.toJson())),
        "user": user?.toJson(),
      };
}

class DestinationCoordinate {
  int? latitude;
  int? longitude;

  DestinationCoordinate({
    this.latitude,
    this.longitude,
  });

  factory DestinationCoordinate.fromJson(Map<String, dynamic> json) =>
      DestinationCoordinate(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Payment {
  int? id;
  String? status;
  int? totalAmount;
  DateTime? createdAt;
  List<PaymentDetail>? paymentDetails;

  Payment({
    this.id,
    this.status,
    this.totalAmount,
    this.createdAt,
    this.paymentDetails,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        status: json["status"],
        totalAmount: json["totalAmount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        paymentDetails: json["paymentDetails"] == null
            ? []
            : List<PaymentDetail>.from(
                json["paymentDetails"]!.map((x) => PaymentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "totalAmount": totalAmount,
        "createdAt": createdAt?.toIso8601String(),
        "paymentDetails": paymentDetails == null
            ? []
            : List<dynamic>.from(paymentDetails!.map((x) => x.toJson())),
      };
}

class PaymentDetail {
  int? id;
  String? paymentMethod;
  int? amount;

  PaymentDetail({
    this.id,
    this.paymentMethod,
    this.amount,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
        id: json["id"],
        paymentMethod: json["paymentMethod"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentMethod": paymentMethod,
        "amount": amount,
      };
}
