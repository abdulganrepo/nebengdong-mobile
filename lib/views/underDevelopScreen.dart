import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UnderDevelopScreen extends StatefulWidget {
  final String role;
  const UnderDevelopScreen({super.key, required this.role});

  @override
  State<UnderDevelopScreen> createState() => _UnderDevelopScreenState();
}

class _UnderDevelopScreenState extends State<UnderDevelopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 400,
          ),
          Container(
            width: 250,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                border: Border.all(
                    color: Colors.black, width: 2, style: BorderStyle.solid)),
            child: Column(
              children: [
                Card(
                    elevation: 2,
                    child: widget.role == "Driver"
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(45)),
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
                                "Cari Penebeng",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Grostek",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ))
                        : Text("Cari Driver")),
              ],
            ),
          )
        ],
      )),
    );
  }
}
