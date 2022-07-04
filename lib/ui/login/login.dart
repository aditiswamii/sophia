import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/home/home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool _passwordVisible = true;
  bool value = false;
  bool visibility = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  resizeToAvoidBottomInset: true,
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
                    "assets/images/backg.jpg",
                  ),
                  fit: BoxFit.cover,
                  // filterQuality: FilterQuality.low,
                  // colorFilter: ColorFilter.mode(
                  //   Color(0xFF2FBCB9),
                  //   BlendMode.color,
                  // )
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
                            hintText: "Mobile No.",
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
                            hintText: "Password",
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
                         Navigator.of(context).pushReplacement(MaterialPageRoute(
                             builder: (BuildContext context) => HomeScreen()));
                       },
                       child: const Text(
                         "Login",
                         style:
                         TextStyle( fontSize: 16),
                         textAlign: TextAlign.center,
                       ),
                     ),
                   ),
                    Visibility(
                      visible: true,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text("*Having issues while logging, Kindly contact 98765867453",
                            style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                        ),
                      replacement: SizedBox.shrink(),
                    )

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
