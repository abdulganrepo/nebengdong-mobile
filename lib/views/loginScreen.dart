import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/loginBloc/bloc.dart';
import 'package:nebengdong/core/bloc/loginBloc/event.dart';
import 'package:nebengdong/core/bloc/loginBloc/state.dart';
import 'package:nebengdong/core/bloc/registerBloc/bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/bloc.dart';
import 'package:nebengdong/core/services/registerService.dart';
import 'package:nebengdong/core/services/userService.dart';
import 'package:nebengdong/utils/colorHex.dart';
import 'package:nebengdong/utils/loader.dart';
import 'package:nebengdong/views/homeScreen.dart';
import 'package:nebengdong/views/registerScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void loginUSer(String email, String password) async {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc.add(LoginUserEvent(email, password));
    print(email);
    print(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            onLoading(context, "Mohon Tunggu ...");
          }
          if (state is LoginDisposeLoading) {
            Navigator.pop(context);
          }
          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => UserBloc(UserService()),
                          child: HomeScreen(),
                        )),
                ModalRoute.withName('/'));
          }
          if (state is LoginFailed) {
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Login Gagal !',
                desc: "Email atau Password Salah !",
                style: const AlertStyle(
                  animationDuration: Duration(milliseconds: 500),
                  overlayColor: Colors.black54,
                  animationType: AnimationType.grow,
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.black,
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ]).show();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 75),
              const Center(
                child: Text("Login",
                    style: TextStyle(
                        fontSize: 70,
                        fontFamily: "Grostek",
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 75),
              const Text(
                "Email",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Grostek",
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              textEmail(controller: emailCtrl),
              const SizedBox(height: 20),
              const Text(
                "Password",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Grostek",
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              textPassword(controller: passwordCtrl),
              const SizedBox(height: 100),
              const Text(
                "        Lupa Password? Klik Text Ini!",
                style: TextStyle(fontSize: 12, fontFamily: "Grostek"),
              ),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(45)),
                      border: Border.all(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid)),
                  width: double.infinity,
                  height: 54,
                  child: InkWell(
                    onTap: () {
                      if (emailCtrl.text.isEmpty) {
                        final snackBar = SnackBar(
                          content: const Text('Email belum diisi !'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordCtrl.text.isEmpty) {
                        final snackBar = SnackBar(
                          content: const Text('Login belum diisi !'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        loginUSer(emailCtrl.text, passwordCtrl.text);
                      }
                    },
                    child: const Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Grostek",
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  )),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(45)),
                      border: Border.all(
                          color: Colors.white,
                          width: 2,
                          style: BorderStyle.solid)),
                  width: double.infinity,
                  height: 54,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  RegisterBloc(RegisterService()),
                              child: const RegisterScreen(),
                            ),
                          ));
                    },
                    child: const Text(
                      "Register",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Grostek",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget textEmail(
      {String? hintext,
      TextInputType? textInputType,
      VoidCallback? onTap,
      bool? readOnly,
      TextEditingController? controller,
      Widget? suffixIcon}) {
    return SizedBox(
      // width: 270,
      height: 46,
      child: Form(
        child: TextFormField(
          controller: controller,
          onTap: onTap,
          keyboardType: textInputType,
          enableInteractiveSelection: false,
          readOnly: readOnly == true ? true : false,
          maxLines: 1,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              isDense: true,
              filled: true,
              // fillColor: HexColor(themeLightOrange),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
              ),
              labelStyle: const TextStyle(color: Colors.black),
              errorBorder: InputBorder.none,
              hintText: hintext,
              hintStyle: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
          validator: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
          onChanged: (value) {
            // if (value.isNotEmpty) {s
            //   setState(() {
            //     buttonIsi = true;
            //   });
            // } else {
            //   setState(() {
            //     buttonIsi = false;
            //   });
            // }
          },
        ),
      ),
    );
  }

  Widget textPassword(
      {String? hintext,
      TextInputType? textInputType,
      VoidCallback? onTap,
      bool? readOnly,
      TextEditingController? controller}) {
    return SizedBox(
      // width: 270,
      height: 46,
      child: Form(
        child: TextFormField(
          obscureText: _showPassword == false ? true : false,
          controller: controller,
          onTap: onTap,
          keyboardType: textInputType,
          enableInteractiveSelection: false,
          readOnly: readOnly == true ? true : false,
          maxLines: 1,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              isDense: true,
              filled: true,
              // fillColor: HexColor(themeLightOrange),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
              ),
              labelStyle: const TextStyle(color: Colors.black),
              errorBorder: InputBorder.none,
              hintText: hintext,
              hintStyle: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _togglevisibility();
                },
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
          validator: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
          onChanged: (value) {
            // if (value.isNotEmpty) {s
            //   setState(() {
            //     buttonIsi = true;
            //   });
            // } else {
            //   setState(() {
            //     buttonIsi = false;
            //   });
            // }
          },
        ),
      ),
    );
  }
}
