import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/feepayment/feepayment.dart';
import 'package:sophia/ui/login/login.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  PaymentHistoryState createState() => PaymentHistoryState();
}

class PaymentHistoryState extends State<PaymentHistory> {
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => FeePayment()));
    // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.bggrey,
        body: Container(
            margin: EdgeInsets.all(10),
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                   itemCount: 10,
                    itemBuilder: (context, index) {
                  return Container(
                    margin:  EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: MediaQuery.of(context).size.width - 40,
                    child: Card(
                      color: ColorConstant.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "Gaurav soni",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                  textAlign: TextAlign.end,
                                )),
                              ],
                            ),
                            Divider(
                              color: ColorConstant.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Class",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "3A",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Due fees",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                  "100/-",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                  textAlign: TextAlign.end,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fee details",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                ),
                                Text(
                                  "2021-22",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Details",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                ),
                                Text(
                                  "30 March 2022",
                                  style: TextStyle(
                                      color: ColorConstant.bluetext,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      fixedSize: const Size(214, 35),
                                      //////// HERE
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  FeePayment()));
                                    },
                                    child: const Text(
                                      "Download Receipt",
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            )));
  }
}
