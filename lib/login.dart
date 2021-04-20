import 'dart:async';
import 'dart:convert';
/*import 'dart:html';
import 'dart:js';*/
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';





Timer interval(Duration duration, func) {
  Timer function() {
    Timer timer = new Timer(duration, function);

    func(timer);

    return timer;
  }

  return new Timer(duration, function);
}

var facebookToken = "";



class Login extends StatefulWidget {
  static const routeName = '/login';
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);
  String tokenPassed = "";
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);
    //checkFacebookToken();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  /*loginFacebook() async {
    context.callMethod(
        'loginUniversal', ["facebook", Uri.base]);
    interval(new Duration(seconds: 1), (timer) {
      //print(i++);
      var getFacebook = context.callMethod('getFacebook');
      if (getFacebook != null) {
        print(getFacebook);
        tokenPassed = getFacebook;
        timer.cancel();
      }
      //if (i > 5) timer.cancel();
    });
  }

  checkFacebookToken() {
    var getFacebook = context.callMethod('getFacebook');
    if(getFacebook != null){
      tokenPassed = getFacebook;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;

    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/imgs/card_bg.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Flexible(
                  flex: 2,
                  child: Column(children: [
                    Flexible(
                      child: ScaleTransition(
                          scale: _tween.animate(CurvedAnimation(
                              parent: _controller, curve: Curves.elasticOut)),
                          child: Image(
                            height: MediaQuery.of(context).size.height/3,
                            image: AssetImage("assets/imgs/blue_hair_girl.png"),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 0,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Container(
                          //height: 20,
                          //margin: const EdgeInsets.only(top: 20.0),
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(16.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Choose your platform" + tokenPassed,
                                style: TextStyle(
                                  fontSize: multiplier * unitHeightValue,
                                ),
                              ))),
                    ),
                  ])),

              Flexible(
                flex: 2,
                child: ListView(
                  children: [
                    for(var i =0; i< 10;i++)
                      FlatButton(
                        child: Text('Main menu'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/mainmenu');
                        },
                      ),
                  ],
                )
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text('Main menu'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/mainmenu');
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/showlogin',arguments: "facebook");
                    },
                  ),
                ),
              ],
            ),
          )
        ]);
  }
}
