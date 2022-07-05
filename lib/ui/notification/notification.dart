
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:sophia/colors/colors.dart';
import 'package:sophia/ui/feepayment/feepayment.dart';

import '../../utils/string.dart';
import '../drawer/drawer.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: _scaffoldKey,
      drawer: const LeftDrawer(),
      drawerEnableOpenDragGesture: false,
      backgroundColor: ColorConstant.bggrey,
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
                width: 32, color: ColorConstant.heading, height: 32),
          ),
        ),
        title: const Text(
          Notificationsheading,
          style: TextStyle(color: ColorConstant.heading),
        ),
        actions: [
          PopupMenuButton(
            offset: const Offset(20, 40),
            itemBuilder: (BuildContext context) {
              return List.generate(1, (index) {
                return PopupMenuItem(
                    onTap: () {

                    },
                    child: const Text(
                      MarkAllReadbtn,
                      style: TextStyle(color: ColorConstant.bluetext),
                    ));
              });
            },
            child: Container(
              height: 32,
              width: 32,
              margin: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Image.asset('assets/images/menu.png',
                      color: ColorConstant.heading, width: 32, height: 32),
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Card(
                  color: ColorConstant.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  child: const ListTile(
                    title: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod.",
                        style: TextStyle(
                            fontSize: 14, color: ColorConstant.black)),
                    subtitle: Text("30 min ago",
                        style: TextStyle(
                            fontSize: 12, color: ColorConstant.greytext)),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
