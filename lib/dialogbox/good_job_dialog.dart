import 'package:alemeno_sarthak/constants.dart';
import 'package:alemeno_sarthak/methods.dart';
import 'package:flutter/material.dart';

class GoodjobDialog extends StatefulWidget {
  const GoodjobDialog({Key? key}) : super(key: key);

  @override
  _GoodjobDialogState createState() => _GoodjobDialogState();
}

class _GoodjobDialogState extends State<GoodjobDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "GOOD JOB",
          style: TextStyle(
            fontSize: 40,
            color: Constants().mainGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
