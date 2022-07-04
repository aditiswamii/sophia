

import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:sophia/ui/login/login.dart';

import '../feedue/feedue.dart';
import '../paymenthistory/paymenthistory.dart';

class FeePayment extends StatefulWidget {
  const FeePayment({Key? key}) : super(key: key);

  @override
  FeePaymentState createState() => FeePaymentState();
}

class FeePaymentState extends State<FeePayment> {
  int select=1;
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
        builder: (BuildContext context) =>  HomeScreen()));
    // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:ColorConstant.bggrey,
        appBar: AppBar(
          backgroundColor:ColorConstant.bggrey,
          elevation: 0.0,

          toolbarHeight: 80,
          leading: Container(
            padding: EdgeInsets.only(left:10.0),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Notifications()));
              },
              child: Image.asset('assets/images/sidemenu.png',width:32,
                  color: ColorConstant.heading,height:32),
            ),
          ),
          title: Text("Fees Payment",style: TextStyle(color: ColorConstant.heading),),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Profile()));
                  },
                  child: Image.asset('assets/images/notification.png',color:ColorConstant.heading,width:32,height:32)
              ),
            )
          ],



          bottom:  TabBar(
            isScrollable: false,
            physics: NeverScrollableScrollPhysics(),
            indicatorSize: TabBarIndicatorSize.tab,

            // indicatorColor: Colors.transparent,
            indicatorWeight: 2,
            unselectedLabelColor: ColorConstant.bluetext,
            labelColor: ColorConstant.white,
            padding: EdgeInsets.all(8),
              indicator: BoxDecoration(
                color: ColorConstant.darkgreen,
                borderRadius: BorderRadius.circular(40),
              ),
              splashBorderRadius: BorderRadius.circular(40),
             onTap: (value){
              log(value.toString());
             },

            tabs: [
              Tab(
                // iconMargin: EdgeInsets.only(left: 10,bottom: 10,right: 10),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                        select=1;
                    });
                  },
                  child: Container(
                      height: 50,
                      width: 170,
                      padding: EdgeInsets.all(10),
                    // decoration:
                    // select==1? BoxDecoration(
                    //     color: ColorConstant.darkgreen,
                    //     borderRadius: BorderRadius.circular(30)):
                    // BoxDecoration(
                    //     border: Border.all(color: ColorConstant.darkgreen),
                    //     borderRadius: BorderRadius.circular(30)),
                      child: Center(child: Text("Fee dues"
                         ,style:TextStyle(fontSize: 14)
                      ))),
                ),

              ),

              Tab(
                // iconMargin: EdgeInsets.only(left: 10,bottom: 10,right: 10),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      select=2;
                    });
                  },
                  child: Container(
                   // height: 50,
                    //  width: 170,
                     padding: EdgeInsets.all(10),
                     // decoration:
                     // select==2? BoxDecoration(
                     //      color: ColorConstant.darkgreen,
                     //      borderRadius: BorderRadius.circular(20)):
                     // BoxDecoration(
                     //     border: Border.all(color: ColorConstant.darkgreen),
                     //     borderRadius: BorderRadius.circular(20)),
                      child: Center(child: Text("Payment history",
                          style:TextStyle(fontSize: 14)
                      ))),
                ),
              ),

            ],
          ),
        ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -0.55),
              end: Alignment(0.0, 1.0),
              colors: [const Color(0xFF2FBCB9), const Color(0xFF86DFD2)],
              stops: [0.0, 1.0],
            ),
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/bg.png",
                ),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                colorFilter: ColorFilter.mode(
                  Color(0xFF2FBCB9),
                  BlendMode.color,
                )),
          ),
          child: Container(


             child: TabBarView(

             children: [

               FeeDue(),
               PaymentHistory(),

             ],
           ),


          ),
        ),
          ),
    );

  }
}
