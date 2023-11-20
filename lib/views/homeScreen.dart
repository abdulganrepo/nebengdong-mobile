import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/driverBloc/bloc.dart';
import 'package:nebengdong/core/bloc/passengerBloc/bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/event.dart';
import 'package:nebengdong/core/bloc/userBloc/state.dart';
import 'package:nebengdong/core/services/driverService.dart';
import 'package:nebengdong/core/services/passengerService.dart';
import 'package:nebengdong/utils/loader.dart';
import 'package:nebengdong/views/driver/driverScreen.dart';
import 'package:nebengdong/views/mainScreen.dart';
import 'package:nebengdong/views/passenger/passengerScreen.dart';
import 'package:nebengdong/views/underDevelopScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isDriver = false;

  @override
  void initState() {
    final homeBloc = BlocProvider.of<UserBloc>(context);
    homeBloc.add(GetUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          onLoading(context, "Mohon Tunggu ...");
        }
        if (state is UserDisposeLoading) {
          Navigator.pop(context);
        }
        if (state is GetUserProfileSuccess) {
          setState(() {
            isDriver = state.value.data!.isDriver!;
          });
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 75),
                  Center(
                    child: Text("Masuk\nSebagai",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 60,
                            fontFamily: "Grostek",
                            fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (isDriver == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) =>
                                              DriverBloc(DriverService()),
                                          child: DriverScreen(),
                                        )));
                          } else {
                            final snackBar = SnackBar(
                              content: const Text(
                                  'Anda tidak terdaftar sebagai Driver !'),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Container(
                          height: 300,
                          width: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Center(
                              child: Text("Driver",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: "Grostek",
                                      fontWeight: FontWeight.w700)),
                            ),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            PassengerBloc(PassengerService()),
                                        child: PassengerScreen(),
                                      )));
                        },
                        child: Container(
                          height: 300,
                          width: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Center(
                              child: Text("Nebeng",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: "Grostek",
                                      fontWeight: FontWeight.w700)),
                            ),
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}
