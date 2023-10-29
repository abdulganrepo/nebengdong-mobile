import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/event.dart';
import 'package:nebengdong/core/bloc/userBloc/state.dart';
import 'package:nebengdong/core/services/userService.dart';
import 'package:nebengdong/utils/colorHex.dart';
import 'package:nebengdong/utils/loader.dart';
import 'package:nebengdong/views/profile/profileScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  late UserBloc _userBloc;
  var phoneCtrl = TextEditingController();

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
          if (state is ChangePhoneNumberSuccess) {
            if (state.value.code == 200) {
              Alert(
                  context: context,
                  type: AlertType.success,
                  title: 'Ubah Nomor Berhasil',
                  style: const AlertStyle(
                    animationDuration: Duration(milliseconds: 500),
                    overlayColor: Colors.black54,
                    animationType: AnimationType.grow,
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => UserBloc(UserService()),
                            child: const ProfileScreen(),
                          ),
                        ));
                      },
                      color: Colors.black,
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ]).show();
            } else if (state.value.code == 409) {
              Alert(
                  context: context,
                  type: AlertType.error,
                  title: 'Nomor Sama',
                  desc: "Mohon masukan nomor yang berbeda !",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Masukkan No. Handphone Baru",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Grostek",
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    textForm(
                        controller: phoneCtrl,
                        textInputType: TextInputType.number),
                  ],
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
                    if (phoneCtrl.text.isNotEmpty) {
                      _userBloc.add(ChangePhoneNumberEvent(phoneCtrl.text));
                    }
                  },
                  child: Text(
                    "Ubah No. Handphone",
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
