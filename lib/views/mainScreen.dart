import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebengdong/utils/colorHex.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int indexT = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 75,
          ),
          Center(
            child: ToggleSwitch(
              animate: true,
              borderColor: [Colors.grey],
              minWidth: 90.0,
              initialLabelIndex: 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.black,
              inactiveBgColor: Colors.black,
              inactiveFgColor: Colors.grey,
              totalSwitches: 2,
              icons: [FontAwesomeIcons.home, FontAwesomeIcons.user],
              activeBgColors: [
                [Colors.white],
                [Colors.white]
              ],
              onToggle: (index) {
                setState(() {
                  indexT == index;
                });
                print('switched to: $index');
              },
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: 125,
                width: 300,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(Icons.person, size: 75),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Cecep\nOmaygat",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "Grostek",
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              enabled: false,
                              label: Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Grostek",
                                ),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabled: false,
                              label: Text(
                                "Username",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Grostek",
                                ),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabled: false,
                              label: Text(
                                "No. Handphone",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Grostek",
                                ),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabled: false,
                              label: Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Grostek",
                                ),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabled: false,
                              label: Text(
                                "Kendaraan",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Grostek",
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            color: HexColor("D9D9D9"),
                            child: Center(
                                child: Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: "Grostek",
                                  fontWeight: FontWeight.w700),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.red,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}
