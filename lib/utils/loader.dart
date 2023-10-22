import 'package:flutter/material.dart';
import 'package:nebengdong/utils/colorHex.dart';

void onLoading(BuildContext context, String message) {
  WidgetsBinding.instance?.addPostFrameCallback((_) async {
    await showGeneralDialog(
        barrierColor: Colors.white.withOpacity(0.3),
        context: context,
        barrierLabel: 'test',
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 500),
        transitionBuilder: (context, a1, a2, widget) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
        pageBuilder: (context, animation1, animation2) {
          return SizedBox();
        });
  });
}
