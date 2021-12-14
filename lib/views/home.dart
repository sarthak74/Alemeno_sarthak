import 'package:alemeno_sarthak/constants.dart';
import 'package:alemeno_sarthak/methods.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Constants().mainGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              ),
              onPressed: () async {
                Navigator.of(context).pushNamed('/click_pic');
              },
              child: Text(
                "Share Your meal",
                style: textStyle(18, Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
