import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/main.dart';
import 'package:sophia/model/feesdetail.dart';
import 'package:sophia/model/history.dart';
import 'package:sophia/model/success.dart';
import 'package:sophia/ui/feepayment/feepaycontract.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:sophia/ui/login/login.dart';
import 'package:sophia/ui/notification/notification.dart';
import 'package:sophia/utils/string.dart';

import '../../utils/constants.dart';
import '../drawer/drawer.dart';
import '../feedue/feedue.dart';
import '../paymenthistory/paymenthistory.dart';
import '../webview/webview.dart';
import 'feepaypresenter.dart';

class FeePayment extends StatefulWidget {
  const FeePayment({Key? key}) : super(key: key);

  @override
  FeePaymentState createState() => FeePaymentState();
}

class FeePaymentState extends State<FeePayment> implements FeePayContract{

  late FeePayPresenter _presenter;

  FeesDetail _contacts = const FeesDetail( name: "", standard: "",year:"",feesdue: 0,q1:0,q1paystatus:"",q2:0,q2paystatus: "",q3:0,q3paystatus: "",q4:0,q4paystatus: "");
  late List<History> _history = <History>[];
  late bool _isLoading;
   bool rd1=false;
  bool rd2=false;
  bool rd3=false;
  bool rd4=false;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  int select = 1;
  bool visible = true;
  final ReceivePort _port = ReceivePort();
  FeePaymentState() {
    _presenter = FeePayPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    _isLoading = true;
    // opendialog(navigatorKey.currentState!.context);
    _presenter.getfeesdetail();
    _presenter.gethistory();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    // log("$id+$status+$progrss");
    send.send([id, status, progress]);
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()));
    // Do some stuff.
    return true;
  }

  // void download() async {
  //   final Directory? extDir = await getExternalStorageDirectory();
  //   final String dirPath = '${extDir!.path}/sophia/receipt';
  //   await Directory(dirPath).create(recursive: true);
  //
  //   final taskId = await FlutterDownloader.enqueue(
  //    // url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
  //     url: 'https://cache.careers360.mobi/media/schools/social-media/media-gallery/15099/2021/1/12/A%20Rally%20on%20Education.png',
  //      saveInPublicStorage: true,
  //     savedDir: dirPath,
  //     showNotification: false, // show download progress in status bar (for Android)
  //     openFileFromNotification: true, // click on notification to open downloaded file (for Android)
  //   );
  //
  //
  //
  // }
  // Track the progress of a downloaded file here.
  double progress = 0;

  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;

  // Show the progress status to the user.
  String progressString = DownloadReceiptbtn;

  // This method uses Dio to download a file from the given URL
  // and saves the file to the provided `savePath`.
  Future download(Dio dio, String url, String savePath,BuildContext context) async {

    try {
      Response response = await dio.get(
        url,
        onReceiveProgress:(done,total){
          updateProgress(done,total,context);

        },
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
  void updateProgress(done, total,context) {
    progress = done / total;
    setState(() {
      if (progress >= 1) {
        progressString = 'Downloaded';
        didDownloadPDF = true;

      } else {
        progressString = 'Downloadinf' + (progress * 100).toStringAsFixed(0) + '%';

      }
    });
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 7), child: Text(progressString)),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  List<int>? radiobt=[].cast<int>().toList(growable: true);

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
      // didDownloadPDF=false ? showLoaderDialog(context):Navigator.of(context).pop();


    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstant.bggrey,
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
          title: const Text(
            FeesPayment,
            style: TextStyle(color: ColorConstant.heading, fontSize: 20),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Notifications()));
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                alignment: Alignment.topRight,
                height: 23,
                width: 25,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/notification.png'))),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 15,width: 15,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: ColorConstant.red,
                            shape: BoxShape.circle
                          ),
                      child: const Center(child: Text("99",style: TextStyle(color: ColorConstant.white,fontSize: 10),)),
                      ),
                ),
              ),
            ),
          ]),
      body: Stack(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: visible == true
                        ? ColorConstant.darkgreen
                        : ColorConstant.bggrey,
                    onPrimary: Colors.white,
                    elevation: 0,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                            color: ColorConstant.darkgreen, width: 2)),
                    fixedSize: const Size(165, 50),
                    //////// HERE
                  ),
                  onPressed: () {
                    setState(() {
                      visible = true;
                    });
                  },
                  child: Text(
                    Feeduesbtn,
                    style: TextStyle(
                        color: visible == true
                            ? ColorConstant.white
                            : ColorConstant.bluetext,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: visible == false
                        ? ColorConstant.darkgreen
                        : ColorConstant.bggrey,
                    onPrimary: Colors.white,
                    elevation: 0,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                            color: ColorConstant.darkgreen, width: 2)),
                    fixedSize: const Size(165, 50),
                    //////// HERE
                  ),
                  onPressed: () {
                    setState(() {
                      visible = false;
                    });
                  },
                  child: Text(
                    Paymenthistorybtn,
                    style: TextStyle(
                        color: visible == false
                            ? ColorConstant.white
                            : ColorConstant.bluetext,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child: Visibility(
              visible: visible,
              replacement: //PaymentHistory(),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    children: [

                      ListView(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _history.length,
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
                                            children:  [
                                              const SizedBox(
                                                width: 120,
                                                child: Text(
                                                  "Name",
                                                  style: TextStyle(
                                                      color: ColorConstant.bluetext,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                    _history[index].name,
                                                    style: const TextStyle(
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
                                            children:  [
                                              const SizedBox(width: 120,
                                                child: Text(
                                                  "Class",
                                                  style: TextStyle(
                                                      color: ColorConstant.bluetext,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  _history[index].standard,
                                                  style: const TextStyle(
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
                                            children:  [
                                              const SizedBox(width: 120,
                                                child: Text(
                                                  "Due fees",
                                                  style: TextStyle(
                                                      color: ColorConstant.bluetext,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                    _history[index].feesdue.toString(),
                                                    style: const TextStyle(
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
                                            children:  [
                                              const SizedBox(width: 120,
                                                child: Text(
                                                  "Fee details",
                                                  style: TextStyle(
                                                      color: ColorConstant.bluetext,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  _history[index].feesdetail,
                                                  style: const TextStyle(
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
                                            children:  [
                                              const SizedBox(
                                                width: 120,
                                                child: Text(
                                                  "Payment Date",
                                                  style: TextStyle(
                                                      color: ColorConstant.bluetext,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              const SizedBox(width: 20,),
                                              Expanded(
                                                child: Text(
                                                  _history[index].paymentdate,
                                                  style: const TextStyle(
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
                                                onPressed: didDownloadPDF ? null : () async {
                                               var tempDir = await getExternalStorageDirectory();
                                               download(Dio(),'https://www.clickdimensions.com/links/TestPDFfile.pdf',
                                               tempDir!.path +'TestPDFfile.pdf',context);
                                               },
                                                child:   Text(
                                                  didDownloadPDF==true ? DownloadReceiptbtn:progressString,
                                                  style: const TextStyle(fontSize: 16),
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
                      ),
                      if(_history.isEmpty)
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.transparent,
                            height: 100,width: 100,
                            child: const Center(child: CircularProgressIndicator())),
                      ),
                    ],
                  )
              ),
            //  child: FeeDue(),
              child: Container(
                  color: ColorConstant.bggrey,
                  margin: const EdgeInsets.all(10),
                  child:Stack(
                    children: [
                      ListView(
                        children: [
                          SizedBox(

                            width: MediaQuery.of(context).size.width-20,
                            child: Card(
                              color: ColorConstant.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:  [
                                        const SizedBox(
                                            width: 100,
                                            child: Text("Name",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.name,
                                          style: const TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const Divider(color: ColorConstant.grey,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        const SizedBox(width: 100,
                                            child: Text("Class",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.standard,style: const TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        const SizedBox(width: 100,
                                            child: Text("Due fees",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.feesdue.toString(),style: const TextStyle(color: ColorConstant.bluetext,fontSize: 16)
                                          ,textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        const SizedBox(width: 100,
                                            child: Text("Fee details",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.year,style: const TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const Divider(color: ColorConstant.grey,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState((){
                                              rd1=!rd1;
                                            });

                                          },
                                          child: Row(
                                            children: [
                                              rd1 == false ?
                                              Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,):
                                              Image.asset("assets/images/greenbtn.png",height: 20,width: 20,color: ColorConstant.darkgreen,),
                                              const SizedBox(width: 10,),
                                              const Text("Q1",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.q1.toString(),style: const TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
                                        const SizedBox(width: 20,),
                                        _contacts.q1paystatus == "Unpaid" ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: ColorConstant.redbtn,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              alignment: Alignment.center,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0)),
                                              fixedSize: const Size(80, 30),
                                              //////// HERE
                                            ),
                                            onPressed: () {
                                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              //     builder: (BuildContext context) => const FeePayment()));
                                            },
                                            child: Text(
                                              _contacts.q1paystatus,
                                              style:
                                              const TextStyle( fontSize: 12),
                                              textAlign: TextAlign.center,
                                            )
                                        ) : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: ColorConstant.lightgreen,
                                            onPrimary: Colors.white,
                                            elevation: 3,
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0)),
                                            fixedSize: const Size(80, 30),
                                            //////// HERE
                                          ),
                                          onPressed: () {
                                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            //     builder: (BuildContext context) => const FeePayment()));
                                          },
                                          child: Text(
                                            _contacts.q1paystatus,
                                            style:
                                            const TextStyle( fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState((){
                                              rd2=!rd2;
                                            });

                                          },
                                          child: Row(
                                            children: [
                                              rd2 == false ?
                                              Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,):
                                              Image.asset("assets/images/greenbtn.png",height: 20,width: 20,color: ColorConstant.darkgreen,),
                                              const SizedBox(width: 10,),
                                              const Text("Q2",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.q2.toString(),style: const TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
                                        const SizedBox(width: 20,),
                                        _contacts.q2paystatus == "Unpaid" ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: ColorConstant.redbtn,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              alignment: Alignment.center,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0)),
                                              fixedSize: const Size(80, 30),
                                              //////// HERE
                                            ),
                                            onPressed: () {
                                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              //     builder: (BuildContext context) => const FeePayment()));
                                            },
                                            child: Text(
                                              _contacts.q2paystatus,
                                              style:
                                              const TextStyle( fontSize: 12),
                                              textAlign: TextAlign.center,
                                            )
                                        ) : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: ColorConstant.lightgreen,
                                            onPrimary: Colors.white,
                                            elevation: 3,
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0)),
                                            fixedSize: const Size(80, 30),
                                            //////// HERE
                                          ),
                                          onPressed: () {
                                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            //     builder: (BuildContext context) => const FeePayment()));
                                          },
                                          child: Text(
                                            _contacts.q2paystatus,
                                            style:
                                            const TextStyle( fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState((){
                                              rd3=!rd3;
                                            });

                                          },
                                          child: Row(
                                            children: [
                                              rd3 == false ?
                                              Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,):
                                              Image.asset("assets/images/greenbtn.png",height: 20,width: 20,color: ColorConstant.darkgreen,),
                                              const SizedBox(width: 10,),
                                              const Text("Q3",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.q3.toString(),style: const TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
                                        const SizedBox(width: 20,),
                                        _contacts.q3paystatus == "Unpaid" ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: ColorConstant.redbtn,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              alignment: Alignment.center,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0)),
                                              fixedSize: const Size(80, 30),
                                              //////// HERE
                                            ),
                                            onPressed: () {
                                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              //     builder: (BuildContext context) => const FeePayment()));
                                            },
                                            child: Text(
                                              _contacts.q3paystatus,
                                              style:
                                              const TextStyle( fontSize: 12),
                                              textAlign: TextAlign.center,
                                            )
                                        ) : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: ColorConstant.lightgreen,
                                            onPrimary: Colors.white,
                                            elevation: 3,
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0)),
                                            fixedSize: const Size(80, 30),
                                            //////// HERE
                                          ),
                                          onPressed: () {
                                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            //     builder: (BuildContext context) => const FeePayment()));
                                          },
                                          child: Text(
                                            _contacts.q3paystatus,
                                            style:
                                            const TextStyle( fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState((){
                                              rd4=!rd4;
                                            });

                                          },
                                          child: Row(
                                            children: [
                                              rd4 == false ?
                                              Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,):
                                              Image.asset("assets/images/greenbtn.png",height: 20,width: 20,color: ColorConstant.darkgreen,),
                                              const SizedBox(width: 10,),
                                              const Text("Q4",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.q4.toString(),style: const TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
                                        const SizedBox(width: 20,),
                                        _contacts.q4paystatus == "Unpaid" ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: ColorConstant.redbtn,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              alignment: Alignment.center,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0)),
                                              fixedSize: const Size(80, 30),
                                              //////// HERE
                                            ),
                                            onPressed: () {
                                              // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              //     builder: (BuildContext context) => const FeePayment()));
                                            },
                                            child: Text(
                                              _contacts.q4paystatus,
                                              style:
                                              const TextStyle( fontSize: 12),
                                              textAlign: TextAlign.center,
                                            )
                                        ) : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: ColorConstant.lightgreen,
                                            onPrimary: Colors.white,
                                            elevation: 3,
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0)),
                                            fixedSize: const Size(80, 30),
                                            //////// HERE
                                          ),
                                          onPressed: () {
                                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                            //     builder: (BuildContext context) => const FeePayment()));
                                          },
                                          child: Text(
                                            _contacts.q4paystatus,
                                            style:
                                            const TextStyle( fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40,),
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
                                      borderRadius: BorderRadius.circular(30.0)),
                                  fixedSize: const Size(178, 35),
                                  //////// HERE
                                ),
                                onPressed: () {

                                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  //     builder: (BuildContext context) => const FeePayment()));
                                },
                                child: const Text(
                                  "Pay Now",
                                  style:
                                  TextStyle( fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if(_contacts.name.isEmpty)
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white.withAlpha(10),
                            child: Container(
                                color: Colors.transparent,
                                height: 100,width: 100,
                                child: const Center(child: CircularProgressIndicator())),
                          ),
                        ),
                    ],
                  )
              )
            ),
          ),
        ],
      ),
    );
  }

  @override
  void showError() {

  }

  @override
  void showFeesDetail(FeesDetail detail) {
    setState(() {
      _contacts = detail;
      _isLoading = false;

    });
  }

  @override
  void showHistory(List<History> items) {
    setState(() {
      _history = items;

    });
  }

  @override
  void success(Success succ) {
    // TODO: implement success
  }
}
