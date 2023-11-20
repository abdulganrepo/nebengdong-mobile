import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebengdong/core/bloc/driverBloc/bloc.dart';
import 'package:nebengdong/core/bloc/driverBloc/event.dart';
import 'package:nebengdong/core/bloc/driverBloc/state.dart';
import 'package:nebengdong/core/bloc/userBloc/bloc.dart';
import 'package:nebengdong/core/services/userService.dart';
import 'package:nebengdong/views/profile/profileScreen.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  late Timer timer;
  late DriverBloc _driverBloc;
  int driverStatus = 0;
  String? passengerName;
  double? distance = 0;
  int? totalAmount = 0;
  int? shareRideId;
  int? passengerId;

  @override
  void initState() {
    _driverBloc = BlocProvider.of<DriverBloc>(context);
    _driverBloc.add(FindPassengerEvent());
    super.initState();
  }

  void cariPenebeng() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      print("this every 10 second");
      _driverBloc.add(GetPassengerEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DriverBloc, DriverState>(
        listener: (context, state) {
          if (state is FindPassengerSuccessState) {
            print("sukses active");
          }

          if (state is GetPassengerSuccessState) {
            print("Get passenger sukses");
            if (state.value.code == 200) {
              if (state.value.data!.isFull == false &&
                  state.value.data!.passengers!.isNotEmpty) {
                setState(() {
                  passengerName = state.value.data!.passengers![0].user!.name;
                  distance = state.value.data!.passengers![0].distance;
                  totalAmount =
                      state.value.data!.passengers![0].payment![0].totalAmount;
                  driverStatus = 2;
                  shareRideId = state.value.data!.id;
                  passengerId = state.value.data!.passengers![0].id;
                  timer.cancel();
                });
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.value.message!)));
              setState(() {
                driverStatus = 0;
              });
            }
          }

          if (state is UpdatePassengerStatusSuccessState) {
            print("sukses atuh lah");
            if (state.value.code == 200) {
              if (driverStatus == 2) {
                driverStatus = 3;
              } else if (driverStatus == 3) {
                driverStatus = 4;
              } else if (driverStatus == 4) {
                driverStatus = 5;
              } else if (driverStatus == 5) {
                driverStatus = 6;
              }
              setState(() {});
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.value.message!)));
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
                driverStatus == 0
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
                                  "- Km",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Grostek",
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Rp -",
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
                                    driverStatus = 1;
                                  });
                                  cariPenebeng();
                                },
                                child: Text(
                                  "Cari Penebeng",
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
                    : driverStatus == 1
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
                                  "Sedang mencari yang butuh nebeng",
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
                                        driverStatus = 0;
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
                        : driverStatus == 2
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
                                          "${distance} Km",
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
                                        Text(
                                          passengerName!,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins",
                                          ),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          width: 110,
                                          height: 54,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                driverStatus = 1;
                                                distance = 0;
                                                totalAmount = 0;
                                              });
                                              cariPenebeng();
                                            },
                                            child: Text(
                                              "Skip",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Grostek",
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          width: 160,
                                          height: 54,
                                          child: InkWell(
                                            onTap: () {
                                              _driverBloc.add(
                                                  UpdatePassengerStatusEvent(
                                                      shareRideId!,
                                                      passengerId!,
                                                      2));
                                            },
                                            child: Text(
                                              "Ambil",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Grostek",
                                                  fontSize: 16,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : (driverStatus == 3 ||
                                    driverStatus == 4 ||
                                    driverStatus == 5)
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
                                              "${distance} Km",
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
                                            Text(
                                              passengerName!,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                            Spacer(),
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
                                              if (driverStatus == 3) {
                                                _driverBloc.add(
                                                    UpdatePassengerStatusEvent(
                                                        shareRideId!,
                                                        passengerId!,
                                                        3));
                                              } else if (driverStatus == 4) {
                                                _driverBloc.add(
                                                    UpdatePassengerStatusEvent(
                                                        shareRideId!,
                                                        passengerId!,
                                                        4));
                                              } else {
                                                _driverBloc.add(
                                                    UpdatePassengerStatusEvent(
                                                        shareRideId!,
                                                        passengerId!,
                                                        5));
                                              }
                                            },
                                            child: Text(
                                              driverStatus == 3
                                                  ? "Driver Di Lokasi Penebeng"
                                                  : driverStatus == 4
                                                      ? "Penebeng Sudah Naik"
                                                      : "Sudah Sampai Tujuan",
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
                                : driverStatus == 6
                                    ? Container(
                                        padding: EdgeInsets.all(20),
                                        width: double.infinity,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Yeay! Reward tebenganmu adalah",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Grostek",
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Rp ${totalAmount}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Grostek",
                                                  fontSize: 32,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "Terima kasih telah menjadi malaikat driver",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Grostek",
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "bagi orang yang membutuhkan tebengan!",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Grostek",
                                                  fontSize: 12,
                                                  color: Colors.black),
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
                                                    driverStatus = 0;
                                                  });
                                                },
                                                child: Text(
                                                  "Selesai",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
}
