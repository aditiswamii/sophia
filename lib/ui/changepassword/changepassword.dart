import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/string.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool _passwordVisible = true;
  bool value = false;
  bool visibility = false;

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
                height: MediaQuery.of(context).size.height* 65/100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

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
                            fillColor: Colors.white60,
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
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) => HomeScreen()));
                        },
                        child: const Text(
                          Loginbtn,
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
}
