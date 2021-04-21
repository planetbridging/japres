import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'loadUser.dart';
import 'objsWeb.dart';
//https://pressback.space:8443/complete.html?#access_token=EAAGjnxwAnHABAGEWN2hyvATM3ce2uZAPA9qAi6W2UgGKAmfZAAMlHfJMd5ND5wmoj1CEZAOhXx4hjnfnjRb1VaeCWFktnvtMIPZB6iknRUkeBoTrbillc9TdmyVDaKOwGmk8wYYoGo6Fk7HFFX3a7QnnZC9xFhKVmTEFkZBnULIBWnXaR05vIinQ8yH33c5VkZD&data_access_expiration_time=1626674597&expires_in=5168598
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
  String name = "Welcome";
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


    _onStateChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String state) async {

      if (state.contains("https://pressback.space:8443/complete.html")) {
        tokenPassed = state;
        //print("YAYYY"+tokenPassed+"wht");


        try{
          oFB.processLink(tokenPassed);
          var foundtoken = await oFB.checkToken();
          if(foundtoken){
            var foundaccount = await oFB.getAccount();
            if(foundaccount){
              setSavedUserData(oFB.getCompressed());
              flutterWebviewPlugin.dispose();
              flutterWebviewPlugin.close();
              Navigator.pushNamed(context, '/login');
            }
          }
        }catch(e){
          print("unable to save login");
        }

        print("token:::" + oFB.token);
      }
      print("YAYYY"+tokenPassed+"wht");
      print(state);
    });
    oFB = new objoFacebook("https://pressback.space:8443/complete.html");
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
        loginPath = oFB.url;
      }
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
