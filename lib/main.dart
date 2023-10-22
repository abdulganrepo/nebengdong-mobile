import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/loginBloc/bloc.dart';
import 'package:nebengdong/core/services/loginService.dart';
import 'package:nebengdong/views/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: AnimatedSplashScreen(
            splash: Center(
                child: Image.asset(
              'assets/images/nebengdong.png',
            )),
            duration: 3000,
            splashIconSize: 350,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
            nextScreen: BlocProvider(
              create: (context) => LoginBloc(LoginService()),
              child: const LoginScreen(),
            )));
  }
}
