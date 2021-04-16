import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'objsWeb.dart';

class ShowWeb extends StatefulWidget {
  static const routeName = '/showlogin';
  @override
  State<StatefulWidget> createState() => _ShowWeb();
}

class _ShowWeb extends State<ShowWeb> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);
  String tokenPassed = "";
  String loginPath = "";

  objoFacebook oFB;

  StreamSubscription<String> _onStateChanged;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  //TextEditingController controller = TextEditingController();

  launchUrl() {
    setState(() {
      //loginPath = controller.text;
      flutterWebviewPlugin.reloadUrl(loginPath);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);
    //checkFacebookToken();
    setState(() {});

    _onStateChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String state) async {
      if (state.contains("lotyouraddress")) {
        // do whatever you want
        tokenPassed = state;
      }
      print(state);
    });
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  String loginType = "";
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;
    final String args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      loginType = args;
    }

    if (loginType == null) {
      loginType = "";
    }
    if (loginType != "") {
      if (loginType == "facebook") {
        oFB = new objoFacebook("https://lotyouraddress.com/");
        loginPath = oFB.url;
      }
    } else {
      loginPath = "https://google.com";
    }
    return //Scaffold( body:

        WebviewScaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () => launchUrl(),
          )
        ],
      ),
      url: loginPath,
      withZoom: false,
    );

  }
}
