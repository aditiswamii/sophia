

import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/main.dart';
import 'package:sophia/model/success.dart';
import 'package:sophia/ui/drawer/drawercontract.dart';
import 'package:sophia/ui/feepayment/feepayment.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:sophia/ui/login/login.dart';
import 'package:sophia/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/prefernce.dart';
import '../../utils/string.dart';
import '../changepassword/changepassword.dart';
import '../feedue/feedue.dart';
import '../paymenthistory/paymenthistory.dart';
import 'drawerpresenter.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  LeftDrawerState createState() => LeftDrawerState();
}

class LeftDrawerState extends State<LeftDrawer> implements DrawerContract{

  late DrawerPresenter _presenter;
  LeftDrawerState() {
    _presenter =DrawerPresenter(this);
  }
  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      SnackBar(
        content: Text("Unable to call $phoneNumber"),
      );

    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Drawer(

     child: Container(
       margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
       child: Stack(
         children: [
           Container(
             color: ColorConstant.darkgreen,
             height: 202,
             width: 347,
             child: Container(
               alignment: Alignment.center,
               child: ListTile(
                 leading: Container(
                   alignment: Alignment.center,
                   height: 69,width: 69,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: ColorConstant.white
                   ),
                   child: Text("L",style: TextStyle(fontSize: 36,color: ColorConstant.heading),),
                 ),
                 title: Text("Lorem Ipsum",style: TextStyle(fontSize: 20,color: ColorConstant.white),),
                 subtitle: Text("Lorem Ipsum",style: TextStyle(fontSize: 12,color: ColorConstant.white),),
               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(top: 202),
             child: Column(
               children: [
                 ListTile(
                   visualDensity: VisualDensity(horizontal: 0, vertical: 0),
                   leading: SvgPicture.asset("assets/images/3671910_wallet_icon.svg",
                     alignment: Alignment.center, color: ColorConstant.heading,
                     height: 22,
                     width: 22,
                   ),
                   title: const Text(
                     'Fees',
                     style:
                     TextStyle(fontSize: 16, color:ColorConstant.heading,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                     textAlign: TextAlign.start,
                   ),
                   onTap: () {
                     // Navigator.pushReplacement(context,
                     //     MaterialPageRoute(builder: (context) => Teaching()));

                     Navigator.pop(context);
                   },
                 ),

             ListTile(
               visualDensity: VisualDensity(horizontal: 0, vertical: 0),
               leading: SvgPicture.asset("assets/images/changepass.svg",
                 alignment: Alignment.center, color: ColorConstant.heading,
                 height: 22,
                 width: 22,
               ),
               title: const Text(
                 'Change Password',
                 style:
                 TextStyle(fontSize: 16, color:ColorConstant.heading,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                 textAlign: TextAlign.start,
               ),
               onTap: () {
                 // Navigator.pushReplacement(context,
                 //     MaterialPageRoute(builder: (context) => ChangePassword()));
                 Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
                     builder: (context) => ChangePassword(), maintainState: false));
                // Navigator.pop(context);
               },
             ),
             ListTile(
               visualDensity: VisualDensity(horizontal: 0, vertical: 0),
               leading: SvgPicture.asset("assets/images/contactus.svg",
                 alignment: Alignment.center, color: ColorConstant.heading,
                 height: 22,
                 width: 22,
               ),
               title: const Text(
                 'Contact Us',
                 style:
                 TextStyle(fontSize: 16, color:ColorConstant.heading,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                 textAlign: TextAlign.start,
               ),
               onTap: () {
                dialNumber(phoneNumber: Number, context: context);
               },
             ),
             ListTile(
               visualDensity: VisualDensity(horizontal: 0, vertical: 0),
               leading:  SvgPicture.asset("assets/images/privacy.svg",
                 alignment: Alignment.center, color: ColorConstant.heading,
                 height: 22,
                 width: 22,
               ),
               title: const Text(
                 'Privacy Policy',
                 style:
                 TextStyle(fontSize: 16, color:ColorConstant.heading,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                 textAlign: TextAlign.start,
               ),
               onTap: () {
                 // Navigator.pushReplacement(context,
                 //     MaterialPageRoute(builder: (context) => Teaching()));

                 Navigator.pop(context);
               },
             ),
             ListTile(
               visualDensity: VisualDensity(horizontal: 0, vertical: 0),
               leading: Image.asset(
                 "assets/images/logout1.png",
                 color: ColorConstant.heading,
                 height: 24,
                 width: 24,
               ),
               title: const Text(
                 'Logout',
                 style:
                 TextStyle(fontSize: 16, color:ColorConstant.heading,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                 textAlign: TextAlign.start,
               ),
               onTap: () async {
                 final String? deviceid = await AppPreferences().getDeviceid();
                 opendialog(context);
                _presenter.logout("1", deviceid!);
                 AppPreferences().setLogin(false);
                 // Navigator.pop(context);
               },
             ),
               ],
             ),
           ),
           Center(
             child: Container(
               alignment: Alignment.bottomCenter,
               child: ListTile(
                 visualDensity: VisualDensity(horizontal: 0, vertical: 0),
                 leading: Text("Version 1.0.0",style:
                     TextStyle(fontSize: 12, color:ColorConstant.heading,fontFamily: 'Montserrat'),
                 textAlign: TextAlign.start,),
                 title: const Text(
                   'Designed and Developed by Neologicx',
                   style:
                   TextStyle(fontSize: 12, color:ColorConstant.heading,fontFamily: 'Montserrat'),
                   textAlign: TextAlign.start,
                 ),
                 onTap: () {
                   // Navigator.pushReplacement(context,
                   //     MaterialPageRoute(builder: (context) => Teaching()));

                   Navigator.pop(context);
                 },
               ),
             ),
           ),
         ],
       ),
     ),
    );

  }

  @override
  void showError() {
    // TODO: implement showError
  }

  @override
  void success(Success succ) {
    hideOpenDialog(context);
   AppPreferences().clear();
   Navigator.of(navigatorKey.currentState!.context).pushReplacement(MaterialPageRoute(
       builder: (BuildContext context) => LoginScreen()));
  }
}
//Designed and Developed by Neologicx