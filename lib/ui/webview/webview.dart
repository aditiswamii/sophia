import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';

import '../../colors/colors.dart';
import '../../utils/string.dart';
import '../drawer/drawer.dart';

// Filename of the PDF you'll download and save.
// const fileName = '/pspdfkit-flutter-quickstart-guide.pdf';
//
// // URL of the PDF file you'll download.
// const Serverpath = 'https://pspdfkit.com/downloads' + fileName;


class Receipt extends StatefulWidget {
  String url;
  String filename;
  Receipt({Key? key, required this.url,required this.filename}) : super(key: key);



  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // Track the progress of a downloaded file here.
  double progress = 0;

  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;

  // Show the progress status to the user.
  String progressString = 'File has not been downloaded yet.';

  // This method uses Dio to download a file from the given URL
  // and saves the file to the provided `savePath`.
  Future download(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: updateProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) { return status! < 500; }
        ),
      );
      var file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(response.data);
      await file.close();

      // Here, you're catching an error and printing it. For production
      // apps, you should display the warning to the user and give them a
      // way to restart the download.
    } catch (e) {
      print(e);
    }
  }

  // You can update the download progress here so that the user is
  // aware of the long-running task.
  void updateProgress(done, total) {
    progress = done / total;
    setState(() {
      if (progress >= 1) {
        progressString = '✅ File has finished downloading. Try opening the file.';
        didDownloadPDF = true;
      } else {
        progressString = 'Download progress: ' + (progress * 100).toStringAsFixed(0) + '% done.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: ColorConstant.bggrey,
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: const LeftDrawer(),
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
              backgroundColor: ColorConstant.bggrey,
              elevation: 0.0,
              toolbarHeight: 80,
              leading: Container(
                padding: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Image.asset('assets/images/sidemenu.png',
                      width: 37, color: ColorConstant.heading, height: 30),
                ),
              ),
              title:  Text(
                Receipthead,
                style: TextStyle(color: ColorConstant.heading, fontSize: 20),
              ),

          ),

    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'First, download a PDF file. Then open it.',
            ),
            TextButton(
              // Here, you download and store the PDF file in the temporary
              // directory.
              onPressed: didDownloadPDF ? null : () async {
                var tempDir = await getExternalStorageDirectory();
                download(Dio(), widget.url, tempDir!.path + widget.filename);
              },
              child: Text('Download a PDF file'),
            ),
            Text(
              progressString,
            ),
            TextButton(
              // Disable the button if no PDF is downloaded yet. Once the
              // PDF file is downloaded, you can then open it using PSPDFKit.
              onPressed: !didDownloadPDF ? null : () async {
                var tempDir = await getTemporaryDirectory();
                await Pspdfkit.present(tempDir.path + widget.filename);
              },
              child: Text('Open the downloaded file using PSPDFKit'),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:back_button_interceptor/back_button_interceptor.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter/services.dart';
// import 'package:sophia/ui/feepayment/feepayment.dart';
//
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../colors/colors.dart';
// import '../../utils/string.dart';
// import '../drawer/drawer.dart';
// import '../home/home.dart';
// import '../notification/notification.dart';
//
// class Receipt extends StatefulWidget {
//   String url;
//   Receipt({Key? key, required this.url}) : super(key: key);
//
//   @override
//   ReceiptState createState() => ReceiptState();
// }
//
// class ReceiptState extends State<Receipt> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//   //  BackButtonInterceptor.add(myInterceptor);
//   }
//
//   @override
//   void dispose() {
//    // BackButtonInterceptor.remove(myInterceptor);
//     super.dispose();
//   }
//
//   // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
//   //   Navigator.of(context).pushReplacement(MaterialPageRoute(
//   //       builder: (BuildContext context) =>  FeePayment()));
//   //   // Do some stuff.
//   //   return true;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//     return Container(
//       color: ColorConstant.bggrey,
//       child: Scaffold(
//           key: _scaffoldKey,
//           resizeToAvoidBottomInset: false,
//           drawer: const LeftDrawer(),
//           drawerEnableOpenDragGesture: false,
//           appBar: AppBar(
//               backgroundColor: ColorConstant.bggrey,
//               elevation: 0.0,
//               toolbarHeight: 80,
//               leading: Container(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 alignment: Alignment.centerLeft,
//                 child: GestureDetector(
//                   onTap: () {
//                     _scaffoldKey.currentState!.openDrawer();
//                   },
//                   child: Image.asset('assets/images/sidemenu.png',
//                       width: 37, color: ColorConstant.heading, height: 30),
//                 ),
//               ),
//               title:  Text(
//                 Receipthead,
//                 style: TextStyle(color: ColorConstant.heading, fontSize: 20),
//               ),
//
//           ),
//           body: Container(
//             color: ColorConstant.bggrey,
//             child: Container(
//               margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//               child: Center(
//                 child:
//                 WebView(
//                   zoomEnabled: true,
//                   javascriptMode: JavascriptMode.unrestricted,
//                   initialUrl: widget.url,
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
