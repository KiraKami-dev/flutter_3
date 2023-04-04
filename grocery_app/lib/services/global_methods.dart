// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalMethod {
  static navigateTo({
    required BuildContext ctx,
    required String routeName,
  }) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    String? imgadd,
    required Function ftc,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                imgadd!,
                height: 24,
                width: 24,
                alignment: AlignmentDirectional.center,
              ),
              Text(title),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(subtitle),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                ftc();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        );
      },
    );
  }
}
