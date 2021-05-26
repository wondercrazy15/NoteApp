import 'dart:async';
import 'package:flutter/material.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyWebView());
}

class MyWebView extends StatefulWidget {
  @override
  _MyWebView createState() => new _MyWebView();
}

class _MyWebView extends State<MyWebView> with AutomaticKeepAliveClientMixin<MyWebView>{


  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  Scaffold(
        appBar: AppBar(
          title: const Text('WebView '),
        ),
        body: Container(
            child: Column(children: <Widget>[

              Container(
                  padding: EdgeInsets.all(10.0),
                  child: progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : new Opacity(opacity: 0.0)),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5.0,right: 5.0),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
//                  child: InAppWebView(
//                    initialUrl: "http://natrixsoftware.com/",
//                    initialHeaders: {},
//                    initialOptions: InAppWebViewGroupOptions(
//                        crossPlatform: InAppWebViewOptions(
//                          debuggingEnabled: true,
//                        )
//                    ),
//                    onWebViewCreated: (InAppWebViewController controller) {
//                      webView = controller;
//                    },
//                    onLoadStart: (InAppWebViewController controller, String url) {
//                      setState(() {
//                        this.url = url;
//                      });
//                    },
//                    onLoadStop: (InAppWebViewController controller, String url) async {
//                      setState(() {
//                        this.url = url;
//                      });
//                    },
//                    onProgressChanged: (InAppWebViewController controller, int progress) {
//                      setState(() {
//                        this.progress = progress / 100;
//                      });
//                    },
//                  ),
                ),
              ),

            ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}