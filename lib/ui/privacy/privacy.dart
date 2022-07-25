import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:sophia/ui/feepayment/feepayment.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../colors/colors.dart';
import '../../utils/string.dart';
import '../drawer/drawer.dart';
import '../home/home.dart';
import '../notification/notification.dart';

class PrivacyPolicy extends StatefulWidget {
  String url;
  PrivacyPolicy({Key? key, required this.url}) : super(key: key);

  @override
  PrivacyPolicyState createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
   // BackButtonInterceptor.add(myInterceptor);
  }

  // @override
  // void dispose() {
  //   BackButtonInterceptor.remove(myInterceptor);
  //   super.dispose();
  // }
  //
  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (BuildContext context) =>  FeePayment()));
  //   // Do some stuff.
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Container(
      color: ColorConstant.bggrey,
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: const LeftDrawer(),
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
              backgroundColor: ColorConstant.bggrey,
              elevation: 0.0,
              toolbarHeight: 80,
              leading: Container(
                padding: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Image.asset('assets/images/sidemenu.png',
                      width: 37, color: ColorConstant.heading, height: 30),
                ),
              ),
              title: const Text(
                Privacyhead,
                style: TextStyle(color: ColorConstant.heading, fontSize: 20),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Notifications()));
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    alignment: Alignment.topRight,
                    height: 23,
                    width: 25,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/notification.png'))),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 15,
                        width: 15,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: ColorConstant.red, shape: BoxShape.circle),
                        child: const Center(
                            child: Text(
                          "99",
                          style: TextStyle(
                              color: ColorConstant.white, fontSize: 10),
                        )),
                      ),
                    ),
                  ),
                ),
              ]),
          body: Container(
            color: ColorConstant.bggrey,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Center(
                child: WebView(
                  zoomEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.url,
                ),
              ),
            ),
          )),
    );
  }
}
