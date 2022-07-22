import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';


class Webview extends StatefulWidget {
  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {

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

    // Do some stuff.
    return true;
  }
  InAppWebViewController? webView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
                SingleChildScrollView(
                  child: Column(
                    children: [
                      InAppWebView(
                        initialUrlRequest: URLRequest(url:Uri.parse("https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf")),
                        initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                              useOnDownloadStart: true
                          ),
                        ),
                        onWebViewCreated: (InAppWebViewController controller) {
                          webView = controller;
                        },
                        onLoadStart: (InAppWebViewController controller, Uri? url) {

                        },
                        onLoadStop: (InAppWebViewController controller,  Uri? url) {

                        },
                        onDownloadStart: (controller, url) async {
                          print("onDownloadStart $url");
                          final taskId = await FlutterDownloader.enqueue(
                            url: url.toString(),
                            savedDir: (await getExternalStorageDirectory())!.path,
                            showNotification: true, // show download progress in status bar (for Android)
                            openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                          );
                        },
                      ),
                    ],
                  ),
                ));


  }
}
