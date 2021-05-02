import 'dart:async';
import 'dart:convert';
/*import 'dart:html';
import 'dart:js';*/
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'loadUser.dart';

class ObjRank {
  String name = "";
  int seconds = 0;
  int score = 0;
  int points = 0;
  ObjRank(String n, int s, int o, int p) {
    this.name = n;
    this.seconds = s;
    this.score = o;
    this.points = p;
  }
}


Timer interval(Duration duration, func) {
  Timer function() {
    Timer timer = new Timer(duration, function);

    func(timer);

    return timer;
  }

  return new Timer(duration, function);
}

var facebookToken = "";

Future<http.Response> getDynData(String link, String path,var parms){
  return http.get(Uri.https(link, path,parms));
}

Future<http.Response> fetchBoard() {
  return http.get(Uri.https('pressback.space:8443', '/leadboards'));
}

class Login extends StatefulWidget {
  static const routeName = '/login';
  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);
  String tokenPassed = "";
  String leaderTitle = "Welcome to leaderboards";
  String savedData = "";
  List<String> saveArr = ["","","","","",""];
  bool saveLoaded = false;
  bool notEmpty = false;
  bool notLoggedIn = true;
  List<ObjRank> lstRanks = new List<ObjRank>();
  List<ObjRank> lstUserRanks = new List<ObjRank>();

  loadCurrentUser() async {
    await loadSaveData();
    setCurrentUser(saveArr[0]);
  }

  loadSaveData() async {
    if(!saveLoaded){
      savedData = await getSavedUserData();
      if(savedData != ""){
        var sSplit = savedData.split(":::");
        //id,fn,ln,em,bd,tk
        for(int i = 0; i < sSplit.length;i++){
          saveArr[i] = sSplit[i];
        }
        notEmpty = true;
        notLoggedIn = false;
        setState(() {
          leaderTitle += ", " + saveArr[1] + " " + saveArr[2];
        });
      }
      saveLoaded = true;
    }
  }

  logUserOut(){
    notLoggedIn = true;
    setState(() {
      setSavedUserData("");

      saveLoaded = false;
      notEmpty = false;
      leaderTitle = "Welcome to leaderboards";
      lstUserRanks.clear();
    });
  }


  setLeadboards() async {
    var d = await fetchBoard();

    var j = jsonDecode(d.body);
    try{
      for(var v in j){
        ObjRank o = new ObjRank(v[0], v[1], v[2], v[3]);
        setState(() {
          lstRanks.add(o);
        });

      }
    }catch (e){
      print("unable to get leaderboards");
    }
  }

  setCurrentUser(String id) async{
    lstUserRanks.clear();
    final _authority = "pressback.space:8443";
    final _path = "/getrank";
    var queryParameters = {
      'id': id
    };
    var d = await getDynData(_authority,_path,queryParameters);

    if(d.body.contains("Not found")){
      print("couldn't find id");
    }else{
      var j = jsonDecode(d.body);
      try{
        ObjRank o = new ObjRank(j[0], j[1], j[2], j[3]);
        setState(() {
          lstUserRanks.add(o);
        });
      }catch (e){
        print("unable to get leaderboards");
      }
    }
    /**/
  }

  @override
  void initState() {
    super.initState();

    setLeadboards();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);

    loadCurrentUser();
    //checkFacebookToken();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  generateText(String txt){
    var c = Container(
      //height: 20,
      //margin: const EdgeInsets.only(top: 20.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              txt,
            )));
    return c;
  }

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;
    //loadSaveData();
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
                                leaderTitle,
                                style: TextStyle(
                                  fontSize: multiplier * unitHeightValue,
                                ),
                              ))),
                    ),
                  ])),

              Flexible(
                  flex: 1,
                  child: ListView(
                    children: [
                      if(lstUserRanks.length > 0)
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: generateText("Name"),
                          ),
                          Expanded(
                            child: generateText("Seconds"),
                          ),
                          Expanded(
                            child: generateText("Score"),
                          ),
                          Expanded(
                            child: generateText("Points"),
                          ),

                        ],
                      ),

                      for(var i =0; i< lstUserRanks.length;i++)
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: generateText(lstUserRanks[i].name),
                            ),
                            Expanded(
                              child: generateText(lstUserRanks[i].seconds.toString()),
                            ),
                            Expanded(
                              child: generateText(lstUserRanks[i].score.toString()),
                            ),
                            Expanded(
                              child: generateText(lstUserRanks[i].points.toString()),
                            ),
                          ],
                        ),

                    ],
                  )
              ),
              Flexible(
                flex: 3,
                child: ListView(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: generateText("#"),
                        ),
                        Expanded(
                          child: generateText("Name"),
                        ),
                        Expanded(
                          child: generateText("Seconds"),
                        ),
                        Expanded(
                          child: generateText("Score"),
                        ),
                        Expanded(
                          child: generateText("Points"),
                        ),

                      ],
                    ),
                    for(var i =0; i< lstRanks.length;i++)
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: generateText((i+1).toString()),
                          ),
                          Expanded(
                            child: generateText(lstRanks[i].name),
                          ),
                          Expanded(
                            child: generateText(lstRanks[i].seconds.toString()),
                          ),
                          Expanded(
                            child: generateText(lstRanks[i].score.toString()),
                          ),
                          Expanded(
                            child: generateText(lstRanks[i].points.toString()),
                          ),
                        ],
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
                      //setCurrentUser("123995826417993");
                    },
                  ),
                ),

                !notEmpty ? Expanded(
                    child: FlatButton(
                      child: Text('Login'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/showlogin',arguments: "facebook");
                      },
                    ),
                  ):



                 Expanded(
                    child: FlatButton(
                      child: Text('Logout'),
                      onPressed: () {
                        //Navigator.pushNamed(context, '/showlogin',arguments: "facebook");
                        logUserOut();
                      },
                    ),
                  ),


              ],
            ),
          )
        ]);
  }
}
