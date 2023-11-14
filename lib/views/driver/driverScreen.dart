import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebengdong/core/bloc/userBloc/bloc.dart';
import 'package:nebengdong/core/services/userService.dart';
import 'package:nebengdong/views/profile/profileScreen.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              Container(
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
                      offset: Offset(0, 2), // changes position of shadow
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
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => BlocProvider(
                    //                 create: (context) =>
                    //                     UserBloc(UserService()),
                    //                 child: ProfileScreen(),
                    //               )),
                    //     );
                    //   },
                    //   child: Text("Profile"),
                    // ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: 280,
                      height: 54,
                      child: InkWell(
                        onTap: () {
                          // if (formKey.currentState!.validate()) {
                          //   _userBloc.add(ChangePasswordEvent(
                          //       oldPassword.text, confirmNewPassword.text));
                          // }
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
            ],
          )),
    );
  }
}
