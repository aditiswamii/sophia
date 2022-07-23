

import 'dart:developer';
import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/main.dart';
import 'package:sophia/model/student.dart';
import 'package:sophia/model/success.dart';
import 'package:sophia/ui/feepayment/feepayment.dart';
import 'package:sophia/ui/login/login.dart';
import 'package:sophia/utils/prefernce.dart';

import 'package:sophia/utils/string.dart';

import '../../utils/constants.dart';
import '../dialog/loading.dart';
import 'homecontract.dart';
import 'homepresenter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> implements HomeContract {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late HomePresenter _presenter;

  late List<Student> _contacts = <Student>[];

  late bool _isLoading;


  HomeScreenState() {
    _presenter = HomePresenter(this);
  }



  @override
  void initState() {
    super.initState();
   // BackButtonInterceptor.add(myInterceptor);
     loadapi();

     updatetoken();

    }
    void loadapi() async {
     setState((){
      _isLoading = true;
     });
       final int? parentid = await  AppPreferences().getuserId();
       log(parentid.toString());
       opendialog(navigatorKey.currentContext!);
      _presenter.loadContacts(parentid.toString());
     }

  void updatetoken() async {
    log("tap");
    final String? token = await AppPreferences().getFCMToken();
    final String? deviceId = await getDeviceId();
    AppPreferences().setDeviceid(deviceId!);
    final bool? registered = await AppPreferences().getIsRegistered();
    if(registered==false) {
      _presenter.insertoken("1", token!, deviceId, Platform.isAndroid?"android":"ios");
    }
  }
  // @override
  // void dispose() {
  //   BackButtonInterceptor.remove(myInterceptor);
  //   super.dispose();
  // }
  //
  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (BuildContext context) =>  LoginScreen()));
  //   // Do some stuff.
  //   return true;
  // }
   getDeviceId() async {
    if (Platform.isIOS) {
      var iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }else{
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
     key: _scaffoldKey,
       body: Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         decoration: const BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment(0, -0.55),
             end: Alignment(0.0, 1.0),
             colors: [Color(0xFF2FBCB9), Color(0xFF86DFD2)],
             stops: [0.0, 1.0],
           ),
           image: DecorationImage(
               image: AssetImage(
                 "assets/images/backg.jpg",
               ),
               fit: BoxFit.cover,
               filterQuality: FilterQuality.low,
               colorFilter: ColorFilter.mode(
                 Color(0xFF2FBCB9),
                 BlendMode.color,
               )),
         ),
         child: ListView(
           physics: const NeverScrollableScrollPhysics(),
           children: [
             Container(
               margin: const EdgeInsets.fromLTRB(10, 50, 10, 0),
               height: 200,
               width: MediaQuery.of(context).size.width-20,
               alignment: Alignment.center,
               child: const Text(Welcome+" "+"Parent",
                 style: TextStyle(color: Colors.white,fontSize: 32,fontStyle: FontStyle.normal,
                     fontFamily: "Montserrat"),textAlign: TextAlign.center,),
             ),
             Container(
               height: MediaQuery.of(context).size.height-250,
               decoration: const BoxDecoration(
                 color: ColorConstant.bggrey,
               //  border: Border.symmetric(),
                 borderRadius:BorderRadius.vertical(top: Radius.circular(30))
               ),
               child: Container(

                 margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                 alignment: Alignment.topLeft,
                 child: SingleChildScrollView(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Container(
                         alignment: Alignment.centerLeft,
                         child: const Text(Childdetails,style: TextStyle(color: ColorConstant.bluetext,fontSize: 22),
                           textAlign: TextAlign.start,),
                       ),
                       Container(
                         margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                         child: ListView.builder(
                           shrinkWrap: true,
                             physics: const BouncingScrollPhysics(),
                             itemCount: _contacts.length,
                             itemBuilder: (context, index) {
                               hideOpenDialog(_scaffoldKey.currentContext!);
                           return Container(
                             margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                             child: Card(
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(20)
                               ),
                               child: Container(
                                 width: MediaQuery.of(context).size.width-40,

                               //  height: 200,
                                 padding: const EdgeInsets.all(20),
                                 child: Column(
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                       children: [
                                         SizedBox(
                                           width: (MediaQuery.of(context).size.width-40)/2 -20,
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               SizedBox(
                                                   width: (MediaQuery.of(context).size.width-40)/2 -20,
                                                   child: Text(_contacts[index].name,style: const TextStyle(color: ColorConstant.bluetext,fontSize: 18))),
                                               const SizedBox(height: 10,),
                                               SizedBox(  width: (MediaQuery.of(context).size.width-40)/2 -20,
                                                   child: Text(_contacts[index].standard,style: const TextStyle(color: ColorConstant.bluetext,fontSize: 18))),

                                             ],
                                           ),
                                         ),
                                         Container(
                                             width: (MediaQuery.of(context).size.width-40)/2 -28,
                                           alignment: Alignment.centerRight,
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.end,
                                             children: [
                                               SizedBox(
                                                   width: (MediaQuery.of(context).size.width-40)/2 -28,
                                                   child: const Text("Fee Due",style: TextStyle(color: ColorConstant.bluetext,
                                                       fontSize: 18),textAlign: TextAlign.end,)),
                                               const SizedBox(height: 10,),
                                               SizedBox(  width: (MediaQuery.of(context).size.width-40)/2 -28,
                                                   child: Text(_contacts[index].feesdue.toString(),style: const TextStyle(color: ColorConstant.bluetext,
                                                       fontSize: 18),textAlign: TextAlign.end,)),

                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                     const SizedBox(height:30 ,),
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
                                         // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                         //     builder: (BuildContext context) => FeePayment()));
                                         Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
                                             builder: (context) => const FeePayment(), maintainState: false));
                                       },
                                       child: const Text(
                                         View,
                                         style:
                                         TextStyle( fontSize: 16),
                                         textAlign: TextAlign.center,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           );
                         }),
                       )

                     ],
                   ),
                 ),
               ),
             )
           ],
         ),
       ),
    );
  }

  @override
  void showError() {

  }

  @override
  void showStudentList(List<Student> items) {
    setState(() {
      _contacts = items;
      _isLoading = false;

    });

  }

  @override
  void success(Success succ) {
    AppPreferences().setIsRegistered(true);
    log(succ.message);
  }
}
