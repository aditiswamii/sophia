import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/model/success.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/string.dart';
import 'changepasswordcontract.dart';
import 'changepasswordpresenter.dart';

class ChangePassword extends StatefulWidget {

  ChangePassword({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> implements ChangePasswordContract{

  late ChangePasswordPresenter _presenter;

  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController cpasscontroller = TextEditingController();
  TextEditingController npasscontroller = TextEditingController();
  TextEditingController rnpasscontroller = TextEditingController();
  bool _cpasswordVisible = true;
  bool _npasswordVisible = true;
  bool _rnpasswordVisible = true;
  bool value = false;
  bool visibility = false;
  final _form = GlobalKey<FormState>();
  void _saveForm() {
    final isValid = _form.currentState?.validate();
    log('data: $isValid');
    if (!isValid!) {
      return;
    }
  }
  ChangePasswordState() {
    _presenter = ChangePasswordPresenter(this);
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Change Password"),
          backgroundColor: ColorConstant.darkgreen,
          centerTitle: true,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: ListView(children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Center(
                        child: TextFormField(
                          controller: cpasscontroller,
                          maxLength: 100,
                          obscureText: _cpasswordVisible,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Current Password',
                            hintStyle: TextStyle(color: ColorConstant.grey),
                            fillColor: Colors.white60,
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                )
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_cpasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,color: ColorConstant.darkgreen,),
                                onPressed: () {
                                  setState(() {
                                    _cpasswordVisible = !_cpasswordVisible;
                                  });
                                }),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Current Password needed";
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
                      height: 80,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Center(
                        child: TextFormField(
                          controller: npasscontroller,
                          maxLength: 100,
                          obscureText: _npasswordVisible,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'New Password',
                            hintStyle: TextStyle(color: ColorConstant.grey),
                            fillColor: Colors.white60,
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                )
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_npasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,color: ColorConstant.darkgreen,),
                                onPressed: () {
                                  setState(() {
                                    _npasswordVisible = !_npasswordVisible;
                                  });
                                }),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "New Password needed";
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
                      height: 80,
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Center(
                        child: TextFormField(
                          controller: rnpasscontroller,
                          maxLength: 100,
                          obscureText: _rnpasswordVisible,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Retype New Password',
                            hintStyle: TextStyle(color: ColorConstant.grey),
                            fillColor: Colors.white60,
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                )
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_rnpasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,color: ColorConstant.darkgreen,),
                                onPressed: () {
                                  setState(() {
                                    _rnpasswordVisible = !_rnpasswordVisible;
                                  });
                                }),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Retype New Password needed";
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
                            if(cpasscontroller.text.isNotEmpty){
                              if(npasscontroller.text.isNotEmpty){
                                if(npasscontroller.text.isNotEmpty == rnpasscontroller.text.isNotEmpty){
                                  _presenter.changepassword(cpasscontroller.text.toString(),
                                      npasscontroller.text.toString());
                                } else {
                                  // Scaffold.of(context)
                                  //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                                }
                              } else {
                                // Scaffold.of(context)
                                //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                              }
                            } else {
                              // Scaffold.of(context)
                              //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                            }




                        },
                        child: const Text(
                          "Submit",
                          style:
                          TextStyle( fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),


                  ],
                ),

              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 35/ 100,
              //   alignment: Alignment.centerLeft,
              //   color: Colors.pink,
              //   child: Image.asset("assets/images/bg1.png",scale:1.2,color: Colors.white,),
              // )

            ])));
  }

  @override
  void showError() {

  }

  @override
  void success(Success succ) {
    if(succ.status==200)
      Navigator.of(context).pop();
  }
}
