import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nebengdong/core/bloc/passengerBloc/bloc.dart';
import 'package:nebengdong/core/bloc/passengerBloc/event.dart';
import 'package:nebengdong/core/bloc/passengerBloc/state.dart';
import 'package:nebengdong/core/bloc/userBloc/bloc.dart';
import 'package:nebengdong/core/services/userService.dart';
import 'package:nebengdong/views/profile/profileScreen.dart';

class PassengerScreen extends StatefulWidget {
  const PassengerScreen({super.key});

  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  late Timer timer;
  late PassengerBloc _passengerBloc;
  String? _currentAddress;
  Position? _currentPosition;
  int statusDriver = 0;
  double? distance = 0;
  int? totalAmount = 0;
  String? driverName;
  String? manufacture;
  String? licensePlate;

  @override
  void initState() {
    _passengerBloc = BlocProvider.of<PassengerBloc>(context);
    _getCurrentPosition();
    super.initState();
  }

  void statusOrder() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      print("this every 10 second");
      _passengerBloc.add(ActiveShareRidePassengerEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PassengerBloc, PassengerState>(
        listener: (context, state) {
          if (state is FindDriverSuccessState) {
            if (state.value.code == 200) {
              statusOrder();
            } else if (state.value.code == 409) {
              statusOrder();
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.value.message!)));
              setState(() {
                statusDriver = 0;
                timer.cancel();
              });
            }
          }

          if (state is ActiveShareDrivePassengerSuccess) {
            if (state.value.code == 200) {
              var data = state.value.data!.passengers?[0];
              if (data!.status! != 1) {
                setState(() {
                  statusDriver = data.status!;
                  distance = data.distance;
                  totalAmount = data.payment![0].totalAmount!;
                  driverName = state.value.data!.driver!.name;
                  manufacture = state.value.data!.driver!.vehicle!.manufacture;
                  licensePlate =
                      state.value.data!.driver!.vehicle!.licensePlate;
                });
              }
            }
          }
        },
        child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 110,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                blurRadius: 4,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Icon(FontAwesomeIcons.house),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            UserBloc(UserService()),
                                        child: ProfileScreen(),
                                      )),
                            );
                          },
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                statusDriver == 0
                    ? Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 4,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$distance Km",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Grostek",
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Rp $totalAmount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Grostek",
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              width: 280,
                              height: 54,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    statusDriver = 1;
                                  });
                                  _passengerBloc.add(FindDriverEvent(
                                      _currentPosition!.latitude,
                                      _currentPosition!.longitude,
                                      distance!,
                                      totalAmount!));
                                },
                                child: Text(
                                  "Cari Tebengan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Grostek",
                                      fontSize: 16,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : statusDriver == 1
                        ? Container(
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "$distance Km",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Grostek",
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Rp $totalAmount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Grostek",
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 7,
                                    backgroundColor: Colors.grey,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Sedang mencarikanmu driver malaikat",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Grostek",
                                      fontSize: 12,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  width: 280,
                                  height: 54,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        statusDriver = 0;
                                      });
                                    },
                                    child: Text(
                                      "Batal",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Grostek",
                                          fontSize: 16,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : (statusDriver == 2 || statusDriver == 3)
                            ? Container(
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "$distance Km",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Grostek",
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Rp $totalAmount",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Grostek",
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Icon(
                                              Icons.person,
                                              size: 40,
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              driverName!,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${manufacture}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${licensePlate}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins",
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.solidMessage,
                                          size: 35,
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      FontAwesomeIcons.motorcycle,
                                      size: 35,
                                    ),
                                    Text(
                                        statusDriver == 2
                                            ? "Driver OTW ke titik penjemputan"
                                            : statusDriver == 3
                                                ? "Kamu sedang perjalanan ke kampus"
                                                : "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Grostek",
                                            fontSize: 12,
                                            color: Colors.black))
                                  ],
                                ),
                              )
                            : statusDriver == 4
                                ? Container(
                                    padding: EdgeInsets.all(20),
                                    width: double.infinity,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "$distance Km",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Grostek",
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Rp $totalAmount",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Grostek",
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 40,
                                                  color: Colors.white,
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  driverName!,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${manufacture}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Poppins",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${licensePlate}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Poppins",
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.solidMessage,
                                              size: 35,
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          width: 280,
                                          height: 54,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                statusDriver = 0;
                                              });
                                            },
                                            child: Text(
                                              "Selesai",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Grostek",
                                                  fontSize: 16,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox()
              ],
            )),
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    print(
        "Current Possition : ${_currentPosition!.latitude} ${_currentPosition!.longitude} ");
    distance = calculateDistance(_currentPosition!.latitude,
        _currentPosition!.longitude, -7.194657813082612, 107.88121117319012);
    totalAmount = distance!.toInt() * 10000;
    print("---- distance = ${distance} ----");
    print(totalAmount);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
      print(_currentAddress);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    var coor = double.parse((12742 * asin(sqrt(a))).toStringAsFixed(1));
    print((12742 * asin(sqrt(a))).toStringAsFixed(1));
    return coor;
  }
}
