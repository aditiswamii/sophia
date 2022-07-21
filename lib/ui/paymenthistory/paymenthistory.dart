import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/feepayment/feepayment.dart';

import '../../utils/string.dart';

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
        MaterialPageRoute(builder: (BuildContext context) => const FeePayment()));
    // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.bggrey,
        body: Container(
            margin: const EdgeInsets.all(10),
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                   itemCount: 10,
                    itemBuilder: (context, index) {
                  return Container(
                    margin:  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    width: MediaQuery.of(context).size.width - 40,
                    child: Card(
                      color: ColorConstant.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        color: ColorConstant.bluetext,
                                        fontSize: 16),
                                  ),
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
                                  textAlign: TextAlign.start,
                                )),
                              ],
                            ),
                            const Divider(
                              color: ColorConstant.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                SizedBox(width: 120,
                                  child: Text(
                                    "Class",
                                    style: TextStyle(
                                        color: ColorConstant.bluetext,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "3A",
                                    style: TextStyle(
                                        color: ColorConstant.bluetext,
                                        fontSize: 16),textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                SizedBox(width: 120,
                                  child: Text(
                                    "Due fees",
                                    style: TextStyle(
                                        color: ColorConstant.bluetext,
                                        fontSize: 16),
                                  ),
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
                                  textAlign: TextAlign.start,
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                SizedBox(width: 120,
                                  child: Text(
                                    "Fee details",
                                    style: TextStyle(
                                        color: ColorConstant.bluetext,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "April-May",
                                    style: TextStyle(
                                        color: ColorConstant.bluetext,
                                        fontSize: 16),textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    "Payment Date",
                                    style: TextStyle(
                                        color: ColorConstant.bluetext,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: Text(
                                    "30 March 2022",
                                    style: TextStyle(
                                        color: ColorConstant.bluetext,
                                        fontSize: 16),textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    fixedSize: const Size(214, 35),
                                    //////// HERE
                                  ),
                                  onPressed: () async {
                                    final taskId = await FlutterDownloader.enqueue(
  url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
  savedDir: 'the path of directory where you want to save downloaded files',
  showNotification: true, // show download progress in status bar (for Android)
  openFileFromNotification: true, // click on notification to open downloaded file (for Android)
);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const FeePayment()));
                                  },
                                  child:  const Text(
                                    DownloadReceiptbtn,
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            )
        )
    );
  }
}
