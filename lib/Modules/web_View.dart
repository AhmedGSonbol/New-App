import 'dart:async';
import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webVieww extends StatefulWidget {

  late String uu;

  webVieww(this.uu);

  @override
  State<webVieww> createState() => _webViewwState(uu);
}

class _webViewwState extends State<webVieww> {

  late String uuu;

  _webViewwState(this.uuu);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {

    final Completer<WebViewController> _controller =  Completer<WebViewController>();

    return  Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: uuu,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
      )
    );
  }
}






