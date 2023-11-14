import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/event.dart';
import 'package:nebengdong/core/bloc/userBloc/state.dart';
import 'package:nebengdong/core/services/userService.dart';
import 'package:nebengdong/utils/colorHex.dart';
import 'package:nebengdong/utils/loader.dart';
import 'package:nebengdong/views/profile/changePasswordScreen.dart';
import 'package:nebengdong/views/profile/changePhoneNumberScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDriver = false;
  late UserBloc _userBloc;
  String? email;
  String? phoneNumber;
  String? userName;
  String? motor;
  String? koin;

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(GetUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoading) {
              onLoading(context, "Mohon Tunggu ...");
            }
            if (state is UserDisposeLoading) {
              Navigator.pop(context);
            }
            if (state is GetUserProfileSuccess) {
              isDriver = state.value.data!.isDriver!;
              if (isDriver) {
                motor =
                    "${state.value.data!.vehicles![0].model!} - ${state.value.data!.vehicles![0].licensePlate!}";
              }
              setState(() {
                email = state.value.data!.email!;
                phoneNumber = state.value.data!.phoneNumber!;
                userName = state.value.data!.name!;
                koin = state.value.data!.coin.toString();
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 4,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName ?? "",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Saldo Kamu : ",
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: "Rp ${koin ?? "-"}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))
                              ]))
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(25),
                  height: 420,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 4,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        email ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Username",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                userName ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 30,
                            color: Colors.black,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No. Handphone",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                phoneNumber ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            UserBloc(UserService()),
                                        child: ChangePhoneNumberScreen(),
                                      )),
                            ),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              size: 30,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "********",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) =>
                                              UserBloc(UserService()),
                                          child: ChangePasswordScreen(),
                                        )),
                              );
                            },
                            child: Icon(
                              Icons.chevron_right_rounded,
                              size: 30,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      isDriver
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Motor",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      motor ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 30,
                                  color: Colors.black,
                                )
                              ],
                            )
                          : SizedBox(),
                      isDriver
                          ? SizedBox(
                              height: 5,
                            )
                          : SizedBox(),
                      isDriver
                          ? Divider(
                              color: Colors.black,
                              thickness: 1,
                            )
                          : SizedBox(),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        width: double.infinity,
                        height: 54,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
