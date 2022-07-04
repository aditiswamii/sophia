import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/login/login.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp( MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: "Montserrat"),
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -0.55),
            end: Alignment(0.0, 1.0),
            colors: [const  Color(0xFF2FBCB9), const Color(0xFF86DFD2)],
            stops: [0.0, 1.0],
          ),
          image: DecorationImage(image: AssetImage(   "assets/images/backg.jpg",),
              fit: BoxFit.cover,
              // filterQuality: FilterQuality.low
              // ,colorFilter: ColorFilter.mode(Color(0xFF2FBCB9), BlendMode.color,)
          ),

        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height* 65/100,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/schoollogo.png",height: 200,width: 200,),
                  SizedBox(height: 10,),
                  Text("Sophia Senior\nSecondary School",style: TextStyle(color: ColorConstant.red,fontSize: 22,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                 SizedBox(height: 10,),
                  Text("Bikaner Rajasthan",style: TextStyle(color: ColorConstant.red,fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

                ],
              ),
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height/2,
            //   color: Colors.white.withAlpha(5),
            // )
          ],
        ),
      ),
    );
  }
}

