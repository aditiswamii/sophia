

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/feepayment/feepayment.dart';

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
        builder: (BuildContext context) =>  const FeePayment()));
    // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.bggrey,
      body: Container(
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
                        children: const [
                          SizedBox(
                            width: 100,
                              child: Text("Name",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                          SizedBox(width: 20,),
                          Expanded(child: Text("Gaurav soni",
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
    );
  }
}
