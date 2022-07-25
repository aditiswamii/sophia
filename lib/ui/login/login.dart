import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/main.dart';
import 'package:sophia/model/login.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:sophia/ui/login/logincontract.dart';
import 'package:sophia/utils/prefernce.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../../utils/string.dart';
import '../dialog/loading.dart';
import 'loginpresenter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> implements LoginContract {
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool _passwordVisible = true;
  bool value = false;
  bool visibility = false;
  bool? _isLoading;

  late LoginPresenter _presenter;

  LoginScreenState() {
    _presenter = LoginPresenter(this);
  }
  validatePass(String value) {
    if (value.length > 5)
      return true;
    else
      return false;
  }
  validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length == 10) {
      return true;
    }
    else {
      return false;
    }
  }
  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showInSnackBar("Unable to call $phoneNumber");
    }

    return;
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(

              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/backg.jpg",
                  ),
                  fit: BoxFit.cover,

              ),
            ),
            child: ListView(children: [
              Container(
                height: MediaQuery.of(context).size.height* 65/100,
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                       margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        )),
                    Container(
                         height: 80,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Center(
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          //cursorHeight: 50,
                          controller: mobilecontroller,
                          maxLength: 10,

                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.all(10),
                            hintText: HintMobileNo,
                            hintStyle: TextStyle(color: ColorConstant.grey),
                            fillColor: Colors.white,

                            border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none
                            ),

                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Center(
                        child: TextFormField(
                          controller: passcontroller,
                          maxLength: 100,
                          obscureText: _passwordVisible,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.all(10),
                            hintText: HintPassword,
                            hintStyle: TextStyle(color: ColorConstant.grey),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,color: ColorConstant.darkgreen,),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                }),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*Password needed";
                            }
                          },
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                        ),
                      ),
                    ),
                   Container(
                     width: MediaQuery.of(context).size.width,
                     margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                     child:  ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         primary: ColorConstant.darkgreen,
                         onPrimary: Colors.white,
                         elevation: 3,
                         alignment: Alignment.center,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10.0)),
                         fixedSize: const Size(150, 48),
                         //////// HERE
                       ),
                       onPressed: () {
                         if(mobilecontroller.text.isNotEmpty){
                           if(passcontroller.text.isNotEmpty){
                             if(validateMobile(mobilecontroller.text.toString())) {
                               if(validatePass(passcontroller.text.toString())) {
                                 opendialog(context,"Please wait …");
                                 _presenter.getlogindetail(
                                     mobilecontroller.text.toString(),
                                     passcontroller.text.toString());
                               }else{
                                 showInSnackBar(
                                       'Password Must be more than 5 character');

                               }
                               }else{
                               showInSnackBar(
                                       'Mobile number must be of 10 digits');
                               }
                           } else {
                             showInSnackBar(
                                 'Please enter password');
                           }
                         } else {
                           showInSnackBar(
                               'Please enter mobile number');
                         }
                       },
                       child: const Text(
                         Loginbtn,
                         style:
                         TextStyle( fontSize: 16),
                         textAlign: TextAlign.center,
                       ),
                     ),
                   ),
                    Visibility(
                      visible: true,
                        child: Container(
                          width: MediaQuery.of(context).size.width-10,
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("*Having issues while logging, Kindly contact",
                                style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                              SizedBox(width:5,),
                              GestureDetector(
                                onTap: (){
                                  dialNumber(phoneNumber:Number, context: context);
                                },
                                child: Text(Number,
                                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ),
                      replacement: SizedBox.shrink(),
                    )

                  ],
                ),

              ),

            ])));
  }

  @override
  void showError() {
    // TODO: implement showError
  }

  @override
  void showLoginDetail(LoginDetails detail) {
    hideOpenDialog(navigatorKey.currentContext!,"Please wait …");
    //showInSnackBar("Login Successfully");
    setState((){
      AppPreferences().setAuthToken(detail.token);
      AppPreferences().setParentName(detail.parent_name);
      AppPreferences().setuserId(detail.parent_id);
      AppPreferences().setLogin(true);
    });

    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => HomeScreen(), maintainState: false));
  }
}
