import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:sophia/ui/login/login.dart';
import 'package:sophia/ui/notification/notification.dart';
import 'package:sophia/utils/string.dart';

import '../drawer/drawer.dart';
import '../feedue/feedue.dart';
import '../paymenthistory/paymenthistory.dart';

class FeePayment extends StatefulWidget {
  const FeePayment({Key? key}) : super(key: key);

  @override
  FeePaymentState createState() => FeePaymentState();
}

class FeePaymentState extends State<FeePayment> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  int select = 1;
  bool visible = true;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    // Create TabController for getting the index of current tab
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstant.bggrey,
      drawer: LeftDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
          backgroundColor: ColorConstant.bggrey,
          elevation: 0.0,
          toolbarHeight: 80,
          leading: Container(
            padding: EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Image.asset('assets/images/sidemenu.png',
                  width: 37, color: ColorConstant.heading, height: 30),
            ),
          ),
          title: Text(
            FeesPayment,
            style: TextStyle(color: ColorConstant.heading, fontSize: 20),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Notifications()));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                alignment: Alignment.topRight,
                height: 23,
                width: 25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/notification.png'))),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 15,width: 15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorConstant.red,
                            shape: BoxShape.circle
                          ),
                      child: Center(child: Text("99",style: TextStyle(color: ColorConstant.white,fontSize: 10),)),
                      ),
                ),
              ),
            ),
          ]),
      body: Stack(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: visible == true
                        ? ColorConstant.darkgreen
                        : ColorConstant.bggrey,
                    onPrimary: Colors.white,
                    elevation: 0,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: ColorConstant.darkgreen, width: 2)),
                    fixedSize: const Size(165, 50),
                    //////// HERE
                  ),
                  onPressed: () {
                    setState(() {
                      visible = true;
                    });
                  },
                  child: Text(
                    Feeduesbtn,
                    style: TextStyle(
                        color: visible == true
                            ? ColorConstant.white
                            : ColorConstant.bluetext,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: visible == false
                        ? ColorConstant.darkgreen
                        : ColorConstant.bggrey,
                    onPrimary: Colors.white,
                    elevation: 0,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: ColorConstant.darkgreen, width: 2)),
                    fixedSize: const Size(165, 50),
                    //////// HERE
                  ),
                  onPressed: () {
                    setState(() {
                      visible = false;
                    });
                  },
                  child: Text(
                    Paymenthistorybtn,
                    style: TextStyle(
                        color: visible == false
                            ? ColorConstant.white
                            : ColorConstant.bluetext,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child: Visibility(
              visible: visible,
              replacement: PaymentHistory(),
              child: FeeDue(),
            ),
          ),
        ],
      ),
    );
  }
}
