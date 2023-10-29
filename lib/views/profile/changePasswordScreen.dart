import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/loginBloc/bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/event.dart';
import 'package:nebengdong/core/bloc/userBloc/state.dart';
import 'package:nebengdong/core/services/loginService.dart';
import 'package:nebengdong/core/services/userService.dart';
import 'package:nebengdong/utils/colorHex.dart';
import 'package:nebengdong/utils/loader.dart';
import 'package:nebengdong/views/loginScreen.dart';
import 'package:nebengdong/views/profile/profileScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late UserBloc _userBloc;
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmNewPassword = TextEditingController();
  bool oldPassObscure = true;
  bool passObscure = true;
  bool confimPassObscure = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userBloc = BlocProvider.of<UserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoading) {
            onLoading(context, "Mohon Tunggu ...");
          }
          if (state is UserDisposeLoading) {
            Navigator.pop(context);
          }
          if (state is ChangePasswordSuccess) {
            if (state.value.code == 200) {
              Alert(
                  context: context,
                  type: AlertType.success,
                  title: 'Ubah Password Berhasil',
                  desc: 'Silahkan Login Kembali',
                  style: const AlertStyle(
                    animationDuration: Duration(milliseconds: 500),
                    overlayColor: Colors.black54,
                    animationType: AnimationType.grow,
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => LoginBloc(LoginService()),
                                child: const LoginScreen(),
                              ),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      color: Colors.black,
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ]).show();
            } else if (state.value.code == 400) {
              Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Gagal',
                  desc: "Password Lama Salah !",
                  style: const AlertStyle(
                    animationDuration: Duration(milliseconds: 500),
                    overlayColor: Colors.black54,
                    animationType: AnimationType.grow,
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.black,
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ]).show();
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: 360,
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
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Masukkan Password",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Grostek",
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      textForm(
                        controller: oldPassword,
                        textInputType: TextInputType.text,
                        obscuretext: oldPassObscure,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: InkWell(
                            onTap: () => setState(() {
                              oldPassObscure = !oldPassObscure;
                            }),
                            child: Icon(
                              oldPassObscure
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Masukkan Password Baru",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Grostek",
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      newPasswordForm(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Masukkan Ulang Password Baru",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Grostek",
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      confirmNewPasswordForm()
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: double.infinity,
                height: 54,
                child: InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      _userBloc.add(ChangePasswordEvent(
                          oldPassword.text, confirmNewPassword.text));
                    }
                  },
                  child: Text(
                    "Ubah Password",
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
        ),
      ),
    );
  }

  Widget textForm({
    String? hintext,
    TextInputType? textInputType,
    VoidCallback? onTap,
    bool? readOnly,
    TextEditingController? controller,
    Widget? suffixIcon,
    bool? obscuretext,
  }) {
    return SizedBox(
      child: TextFormField(
        obscureText: obscuretext == true ? true : false,
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
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
            ),
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
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
            ),
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
            return "Password tidak boleh kosong !";
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
        // controller: _loginBloc.userCtrl,
      ),
    );
  }

  Widget newPasswordForm() {
    return SizedBox(
      child: TextFormField(
        obscureText: passObscure,
        controller: newPassword,
        onTap: () {},
        keyboardType: TextInputType.visiblePassword,
        enableInteractiveSelection: false,
        readOnly: false,
        maxLines: 1,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Colors.black,
        ),
        decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: InkWell(
                onTap: () => setState(() {
                  passObscure = !passObscure;
                }),
                child: Icon(
                  passObscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 24,
                ),
              ),
            ),
            isDense: true,
            filled: true,
            // fillColor: HexColor(themeLightOrange),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
            ),
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
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
            ),
            hintText: '',
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
            return "Password tidak boleh kosong !";
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
        // controller: _loginBloc.userCtrl,
      ),
    );
  }

  Widget confirmNewPasswordForm() {
    return SizedBox(
      child: TextFormField(
        obscureText: confimPassObscure,
        controller: confirmNewPassword,
        onTap: () {},
        keyboardType: TextInputType.visiblePassword,
        enableInteractiveSelection: false,
        readOnly: false,
        maxLines: 1,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Colors.black,
        ),
        decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: InkWell(
                onTap: () => setState(() {
                  confimPassObscure = !confimPassObscure;
                }),
                child: Icon(
                  confimPassObscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 24,
                ),
              ),
            ),
            isDense: true,
            filled: true,
            // fillColor: HexColor(themeLightOrange),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
            ),
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
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: HexColor('CBD5E1'), width: 1),
            ),
            hintText: '',
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
            return "Password tidak boleh kosong !";
          } else if (value.isNotEmpty) {
            if (value != newPassword.text) {
              return "Password tidak sama !";
            }
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
        // controller: _loginBloc.userCtrl,
      ),
    );
  }
}
