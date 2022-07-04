

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/feepayment/feepayment.dart';
import 'package:sophia/ui/login/login.dart';

class FeeDue extends StatefulWidget {
  const FeeDue({Key? key}) : super(key: key);

  @override
  FeeDueState createState() => FeeDueState();
}

class FeeDueState extends State<FeeDue> {
  @override
  void initState() {

    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>  FeePayment()));
    // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bggrey,
      body: Container(
        margin: EdgeInsets.all(10),
        child:ListView(
          children: [
            Container(

              width: MediaQuery.of(context).size.width-20,
              child: Card(
                color: ColorConstant.white,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20)
               ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Name",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),),
                          SizedBox(width: 20,),
                          Expanded(child: Text("Gaurav soni",
                            style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                        ],
                      ),
                      Divider(color: ColorConstant.grey,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Class",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),),
                          SizedBox(width: 20,),
                          Text("3A",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Due fees",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),),
                          SizedBox(width: 20,),
                          Expanded(child: Text("100/-",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fee details",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),),
                          Text("2021-22",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),),
                        ],
                      ),
                      Divider(color: ColorConstant.grey,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Row(
                             children: [
                               Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,),
                               SizedBox(width: 10,),
                               Text("Q1"),
                             ],
                           ),

                           Text("100/-"),
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
                                   builder: (BuildContext context) => FeePayment()));
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
                              SizedBox(width: 10,),
                              Text("Q2"),
                            ],
                          ),

                          Text("100/-"),
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
                                  builder: (BuildContext context) => FeePayment()));
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
                              SizedBox(width: 10,),
                              Text("Q3"),
                            ],
                          ),

                          Text("100/-"),
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
                                  builder: (BuildContext context) => FeePayment()));
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
                              SizedBox(width: 10,),
                              Text("Q4"),
                            ],
                          ),

                          Text("100/-"),
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
                                  builder: (BuildContext context) => FeePayment()));
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
            SizedBox(height: 40,),
            Container(
              child: Row(
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
                          builder: (BuildContext context) => FeePayment()));
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
            ),
          ],
        )
      )
    );
  }
}
