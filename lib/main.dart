import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:sophia/ui/login/login.dart';
import 'package:sophia/utils/prefernce.dart';
import 'package:sophia/utils/string.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

String? _token;
String? get token => _token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await Firebase.initializeApp();
  gettoken();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: ColorConstant.darkgreen, // status bar color
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp( MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: "Montserrat"),
      debugShowCheckedModeBanner: false,
      home: MyApp()));
}
void gettoken() async {
  _token = await _firebaseMessaging.getToken();

  _firebaseMessaging.onTokenRefresh.listen((token) {
    _token = token;
    AppPreferences().setIsRegistered(false);
    AppPreferences().setFCMToken(_token!);
  });
  log(_token!);
  AppPreferences().setFCMToken(_token!);
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
            () {
          Autologin();
            }
    );
  }
  Autologin() async {
    final bool? loggedin = await AppPreferences().isLoggedIn();
    if(loggedin==true){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen()));
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/backg.jpg",),
              fit: BoxFit.cover,

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
                  Text(Schoolname,style: TextStyle(color: ColorConstant.red,fontSize: 22,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                 SizedBox(height: 10,),
                  Text(Schoollocation,style: TextStyle(color: ColorConstant.red,fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),

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

