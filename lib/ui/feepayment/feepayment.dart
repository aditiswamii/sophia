import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/model/feesdetail.dart';
import 'package:sophia/ui/feepayment/feepaycontract.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:sophia/ui/login/login.dart';
import 'package:sophia/ui/notification/notification.dart';
import 'package:sophia/utils/string.dart';

import '../drawer/drawer.dart';
import '../feedue/feedue.dart';
import '../paymenthistory/paymenthistory.dart';
import 'feepaypresenter.dart';

class FeePayment extends StatefulWidget {
  const FeePayment({Key? key}) : super(key: key);

  @override
  FeePaymentState createState() => FeePaymentState();
}

class FeePaymentState extends State<FeePayment> implements FeePayContract{

  late FeePayPresenter _presenter;

  FeesDetail _contacts = FeesDetail( name: "", standard: "",year:"",feesdue: 0,q1:0,q1paystatus:"",q2:0,q2paystatus: "",q3:0,q3paystatus: "",q4:0,q4paystatus: "");

  late bool _isLoading;

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  int select = 1;
  bool visible = true;

  FeePaymentState() {
    _presenter = FeePayPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    _isLoading = true;
    _presenter.getfeesdetail();
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
            //  child: FeeDue(),
              child: Container(
                  color: ColorConstant.bggrey,
                  margin: const EdgeInsets.all(10),
                  child:ListView(
                    children: [
                      SizedBox(

                        width: MediaQuery.of(context).size.width-20,
                        child: Card(
                          color: ColorConstant.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:  [
                                    SizedBox(
                                        width: 100,
                                        child: Text("Name",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                    SizedBox(width: 20,),
                                    Expanded(child: Text(_contacts.name,
                                      style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                  ],
                                ),
                                const Divider(color: ColorConstant.grey,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    SizedBox(width: 100,
                                        child: Text("Class",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                    SizedBox(width: 20,),
                                    Expanded(child: Text("3A",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    SizedBox(width: 100,
                                        child: Text("Due fees",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                    SizedBox(width: 20,),
                                    Expanded(child: Text("100/-",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16)
                                      ,textAlign: TextAlign.end,)),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    SizedBox(width: 100,
                                        child: Text("Fee details",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                    SizedBox(width: 20,),
                                    Expanded(child: Text("2021-22",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                  ],
                                ),
                                const Divider(color: ColorConstant.grey,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,),
                                        const SizedBox(width: 10,),
                                        const Text("Q1",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),),
                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    const Expanded(child: Text("100/-",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
                                    const SizedBox(width: 20,),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorConstant.lightgreen,
                                        onPrimary: Colors.white,
                                        elevation: 3,
                                        alignment: Alignment.center,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)),
                                        fixedSize: const Size(80, 30),
                                        //////// HERE
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (BuildContext context) => const FeePayment()));
                                      },
                                      child: const Text(
                                        "Paid",
                                        style:
                                        TextStyle( fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,),
                                        const SizedBox(width: 10,),
                                        const Text("Q2",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    const Expanded(child: Text("100/-",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
                                    const SizedBox(width: 20,),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorConstant.lightgreen,
                                        onPrimary: Colors.white,
                                        elevation: 3,
                                        alignment: Alignment.center,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)),
                                        fixedSize: const Size(80, 30),
                                        //////// HERE
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (BuildContext context) => const FeePayment()));
                                      },
                                      child: const Text(
                                        "Paid",
                                        style:
                                        TextStyle( fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/images/greenbtn.png",height: 20,width: 20),
                                        const SizedBox(width: 10,),
                                        const Text("Q3",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    const Expanded(child: Text("100/-",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
                                    const SizedBox(width: 20,),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorConstant.redbtn,
                                        onPrimary: Colors.white,
                                        elevation: 3,
                                        alignment: Alignment.center,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)),
                                        fixedSize: const Size(80, 30),
                                        //////// HERE
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (BuildContext context) => const FeePayment()));
                                      },
                                      child: const Text(
                                        "Unpaid",
                                        style:
                                        TextStyle( fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/images/greenbtn.png",height: 20,width: 20),
                                        const SizedBox(width: 10,),
                                        const Text("Q4",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(width: 20,),
                                    const Expanded(child: Text("100/-",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
                                    const SizedBox(width: 20,),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorConstant.redbtn,
                                        onPrimary: Colors.white,
                                        elevation: 3,
                                        alignment: Alignment.center,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)),
                                        fixedSize: const Size(80, 30),
                                        //////// HERE
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            builder: (BuildContext context) => const FeePayment()));
                                      },
                                      child: const Text(
                                        "Unpaid",
                                        style:
                                        TextStyle( fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorConstant.darkgreen,
                              onPrimary: Colors.white,
                              elevation: 3,
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              fixedSize: const Size(178, 35),
                              //////// HERE
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) => const FeePayment()));
                            },
                            child: const Text(
                              "Pay Now",
                              style:
                              TextStyle( fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              )
            ),
          ),
        ],
      ),
    );
  }

  @override
  void showError() {

  }

  @override
  void showFeesDetail(FeesDetail detail) {
    setState(() {
      _contacts = detail;
      _isLoading = false;
    });
  }
}
