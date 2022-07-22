import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/main.dart';
import 'package:sophia/model/feesdetail.dart';
import 'package:sophia/model/history.dart';
import 'package:sophia/ui/feepayment/feepaycontract.dart';
import 'package:sophia/ui/home/home.dart';
import 'package:sophia/ui/login/login.dart';
import 'package:sophia/ui/notification/notification.dart';
import 'package:sophia/utils/string.dart';

import '../../utils/constants.dart';
import '../drawer/drawer.dart';
import '../feedue/feedue.dart';
import '../paymenthistory/paymenthistory.dart';
import 'feepaypresenter.dart';

class FeePayment extends StatefulWidget {
  const FeePayment({Key? key}) : super(key: key);

  @override
  FeePaymentState createState() => FeePaymentState();
}

class FeePaymentState extends State<FeePayment> implements FeePayContract{

  late FeePayPresenter _presenter;

  FeesDetail _contacts = FeesDetail( name: "", standard: "",year:"",feesdue: 0,q1:0,q1paystatus:"",q2:0,q2paystatus: "",q3:0,q3paystatus: "",q4:0,q4paystatus: "");
  late List<History> _history = <History>[];
  late bool _isLoading;

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    // Do some stuff.
    return true;
  }

  void download() async {
    final Directory? extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir!.path}/sophia/receipt';
    await Directory(dirPath).create(recursive: true);

    final taskId = await FlutterDownloader.enqueue(
      url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      saveInPublicStorage: true,
      savedDir: dirPath,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );



  }


  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstant.bggrey,
      drawer: LeftDrawer(),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
          backgroundColor: ColorConstant.bggrey,
          elevation: 0.0,
          toolbarHeight: 80,
          leading: Container(
            padding: EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Image.asset('assets/images/sidemenu.png',
                  width: 37, color: ColorConstant.heading, height: 30),
            ),
          ),
          title: Text(
            FeesPayment,
            style: TextStyle(color: ColorConstant.heading, fontSize: 20),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Notifications()));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                alignment: Alignment.topRight,
                height: 23,
                width: 25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/notification.png'))),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 15,width: 15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorConstant.red,
                            shape: BoxShape.circle
                          ),
                      child: Center(child: Text("99",style: TextStyle(color: ColorConstant.white,fontSize: 10),)),
                      ),
                ),
              ),
            ),
          ]),
      body: Stack(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.all(8),
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
                        side: BorderSide(
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
                        side: BorderSide(
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
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
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
                                                    _history[index].name,
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
                                            children:  [
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
                                                  _history[index].standard,
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
                                            children:  [
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
                                                    _history[index].feesdue.toString(),
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
                                            children:  [
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
                                                  _history[index].feesdetail,
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
                                            children:  [
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
                                                  _history[index].paymentdate,
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
                                                onPressed: ()  {
                                                  download();
                                                  // Navigator.of(context).pushReplacement(
                                                  //     MaterialPageRoute(builder: (context) => Webview()));
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
                      ),
                      if(_history.isEmpty)
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.transparent,
                            height: 100,width: 100,
                            child: Center(child: CircularProgressIndicator())),
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
                                        SizedBox(
                                            width: 100,
                                            child: Text("Name",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                        SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.name,
                                          style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const Divider(color: ColorConstant.grey,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        SizedBox(width: 100,
                                            child: Text("Class",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                        SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.standard,style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        SizedBox(width: 100,
                                            child: Text("Due fees",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                        SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.feesdue.toString(),style: TextStyle(color: ColorConstant.bluetext,fontSize: 16)
                                          ,textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        SizedBox(width: 100,
                                            child: Text("Fee details",style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),)),
                                        SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.year,style: TextStyle(color: ColorConstant.bluetext,fontSize: 16),textAlign: TextAlign.end,)),
                                      ],
                                    ),
                                    const Divider(color: ColorConstant.grey,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            _contacts.q1paystatus == "Unpaid" ?
                                            Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,):
                                            Image.asset("assets/images/greenbtn.png",height: 20,width: 20,color: ColorConstant.grey,),
                                            const SizedBox(width: 10,),
                                            const Text("Q1",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),),
                                          ],
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.q1.toString(),style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
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
                                              TextStyle( fontSize: 12),
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
                                            TextStyle( fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            _contacts.q2paystatus == "Unpaid" ?
                                            Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,):
                                            Image.asset("assets/images/greenbtn.png",height: 20,width: 20,color: ColorConstant.grey,),
                                            const SizedBox(width: 10,),
                                            const Text("Q2",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                          ],
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.q2.toString(),style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
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
                                              TextStyle( fontSize: 12),
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
                                            TextStyle( fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            _contacts.q3paystatus == "Unpaid" ?
                                            Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,):
                                            Image.asset("assets/images/greenbtn.png",height: 20,width: 20,color: ColorConstant.grey,),
                                            const SizedBox(width: 10,),
                                            const Text("Q3",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                          ],
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.q3.toString(),style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
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
                                              TextStyle( fontSize: 12),
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
                                            TextStyle( fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            _contacts.q1paystatus == "Unpaid" ?
                                            Image.asset("assets/images/greybtn.png",height: 20,width: 20,color: ColorConstant.grey,):
                                            Image.asset("assets/images/greenbtn.png",height: 20,width: 20,color: ColorConstant.grey,),
                                            const SizedBox(width: 10,),
                                            const Text("Q4",style: TextStyle(color: ColorConstant.bluetext,fontSize: 14)),
                                          ],
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(child: Text(_contacts.q4.toString(),style: TextStyle(color: ColorConstant.bluetext,fontSize: 14),textAlign: TextAlign.center,)),
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
                                              TextStyle( fontSize: 12),
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
                                            TextStyle( fontSize: 12),
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
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (BuildContext context) => const FeePayment()));
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
                                child: Center(child: CircularProgressIndicator())),
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
}
