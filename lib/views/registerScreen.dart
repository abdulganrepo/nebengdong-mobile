import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/loginBloc/bloc.dart';
import 'package:nebengdong/core/bloc/registerBloc/bloc.dart';
import 'package:nebengdong/core/bloc/registerBloc/event.dart';
import 'package:nebengdong/core/bloc/registerBloc/state.dart';
import 'package:nebengdong/core/services/loginService.dart';
import 'package:nebengdong/core/services/registerService.dart';
import 'package:nebengdong/utils/colorHex.dart';
import 'package:nebengdong/utils/loader.dart';
import 'package:nebengdong/views/loginScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var isDriver = false;
  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;
  var fullNameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var confirmPasswordCtrl = TextEditingController();
  var manufactureCtrl = TextEditingController();
  var modelCtrl = TextEditingController();
  var licensePlateCtrl = TextEditingController();

  void _toggle() {
    setState(() {
      _passwordObscureText = !_passwordObscureText;
    });
  }

  void _toggleConfirm() {
    setState(() {
      _confirmPasswordObscureText = !_confirmPasswordObscureText;
    });
  }

  void addNewUSer(RegisterPost data) async {
    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    registerBloc.add(AddNewUserEvent(data));
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            onLoading(context, "Mohon Tunggu ...");
          }
          if (state is RegisterDisposeLoading) {
            Navigator.pop(context);
          }
          if (state is RegisterSuccess) {
            if (state.value.code == 201) {
              Alert(
                  context: context,
                  type: AlertType.success,
                  title: 'Register Berhasil',
                  desc: "Terima kasih telah pendaftaran !",
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
            }
            if (state.value.code == 409 &&
                state.value.status == 'DUPLICATED_EMAIL') {
              Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Email Telah Terdaftar',
                  desc: "Mohon masuk menggunakan akun yang sudah terdaftar !",
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
            if (state.value.code == 409 &&
                state.value.status == 'DUPLICATED_PHONE_NUMBER') {
              Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Nomor Anda Telah Terdaftar',
                  desc: "Mohon masuk menggunakan akun yang sudah terdaftar !",
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
            if (state.value.code == 409 &&
                state.value.status == 'DUPLICATED_LICENSE_PLATE') {
              Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Plat Nomor Anda Telah Terdaftar',
                  desc: "Mohon masuk menggunakan akun yang sudah terdaftar !",
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
          }
          if (state is RegisterFailed) {
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Register Gagal',
                desc: "Mohon cek kembali koneksi Anda !",
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
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              const SizedBox(height: 25),
              const Center(
                child: Text("Daftar",
                    style: TextStyle(
                        fontSize: 70,
                        fontFamily: "Grostek",
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 45),
              const Text(
                "Nama Lengkap",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Grostek",
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              textForm(controller: fullNameCtrl),
              const Text(
                "Email Kampus (Pribadi)",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Grostek",
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              textForm(controller: emailCtrl),
              const Text(
                "No. Handphone",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Grostek",
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              textForm(
                  controller: phoneCtrl, textInputType: TextInputType.number),
              const Text(
                "Password",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Grostek",
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              textForm(
                controller: passwordCtrl,
                obscuretext: _passwordObscureText,
                suffixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: GestureDetector(
                    onTap: _toggle,
                    child: Icon(
                      _passwordObscureText
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const Text(
                "Confirm Password",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Grostek",
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              textForm(
                controller: confirmPasswordCtrl,
                obscuretext: _confirmPasswordObscureText,
                suffixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: GestureDetector(
                    onTap: _toggleConfirm,
                    child: Icon(
                      _confirmPasswordObscureText
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: 24,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isDriver = !isDriver;
                      });
                    },
                    icon: isDriver == false
                        ? const Icon(Icons.check_box_outlined)
                        : const Icon(Icons.check_box_sharp),
                  ),
                  const Text(
                    "Daftar Sebagai Driver",
                    style: TextStyle(fontSize: 15, fontFamily: "Grostek"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              isDriver == false
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Manufaktur",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Grostek",
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        textForm(controller: manufactureCtrl),
                        const Text(
                          "Model Kendaraan",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Grostek",
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        textForm(controller: modelCtrl),
                        const Text(
                          "Plat Nomor Kendaraan",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Grostek",
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        textForm(controller: licensePlateCtrl)
                      ],
                    ),
              const SizedBox(height: 25),
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
                      if (fullNameCtrl.text.isEmpty) {
                        final snackBar = SnackBar(
                          content: const Text('Nama wajib diisi !'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (emailCtrl.text.isEmpty) {
                        final snackBar = SnackBar(
                          content: const Text('Email wajib diisi !'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (phoneCtrl.text.isEmpty) {
                        final snackBar = SnackBar(
                          content: const Text('Nomor Handphone wajib diisi !'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordCtrl.text.isEmpty) {
                        final snackBar = SnackBar(
                          content: const Text('Password wajib diisi !'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (confirmPasswordCtrl.text.isEmpty) {
                        final snackBar = SnackBar(
                          content: const Text('Confirm Password wajib diisi !'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordCtrl.text !=
                          confirmPasswordCtrl.text) {
                        final snackBar = SnackBar(
                          content:
                              const Text('Confirm password tidak sesuai !'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (isDriver == true) {
                        if (manufactureCtrl.text.isEmpty) {
                          final snackBar = SnackBar(
                            content: const Text('Manufaktur wajib diisi !'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (modelCtrl.text.isEmpty) {
                          final snackBar = SnackBar(
                            content:
                                const Text('Model Kendaraan wajib diisi !'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (licensePlateCtrl.text.isEmpty) {
                          final snackBar = SnackBar(
                            content: const Text(
                                'Plat Nomor Kendaraan wajib diisi !'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          print("Driver");
                          addNewUSer(RegisterPost(
                              name: fullNameCtrl.text,
                              email: emailCtrl.text,
                              phoneNumber: phoneCtrl.text,
                              password: passwordCtrl.text,
                              isDriver: isDriver,
                              vehicleManufature: manufactureCtrl.text,
                              vehicleModel: modelCtrl.text,
                              vehicleLicensePlate: licensePlateCtrl.text));
                        }
                      } else {
                        print("Passenger");
                        addNewUSer(RegisterPost(
                            name: fullNameCtrl.text,
                            email: emailCtrl.text,
                            phoneNumber: phoneCtrl.text,
                            password: passwordCtrl.text,
                            isDriver: isDriver,
                            vehicleManufature: manufactureCtrl.text,
                            vehicleModel: modelCtrl.text,
                            vehicleLicensePlate: licensePlateCtrl.text));
                      }
                    },
                    child: const Text(
                      "Daftar",
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
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Kembali ke Login",
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
      // width: 270,
      height: 46,
      child: Form(
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
          // controller: _loginBloc.userCtrl,
        ),
      ),
    );
  }
}
