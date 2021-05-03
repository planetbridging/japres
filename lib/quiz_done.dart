import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'objs.dart';
import 'package:share/share.dart';
import 'loadUser.dart';

class QuizDone extends StatefulWidget {
  static const routeName = '/quizdone';

  @override
  State<StatefulWidget> createState() => _QuizDone();
}

class _QuizDone extends State<QuizDone> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);

  String title = "hiragana 0 to 0";
  String results = "0/0";

  Future<http.Response> getDynData(String link, String path,var parms){
    return http.get(Uri.https(link, path,parms));
  }

  _onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    String txtshare = title + " " + results + " check out our app on https://pressback.space:8443";
    await Share.share(txtshare,
        subject: txtshare,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  Future<void> uploadResultes() async {
    try{
      if(title.contains("matched")){
        var score = title.split("matched")[1].split("/")[0];
        var sec = results.split(" ")[2];
        print(sec);
        var info = await getSavedUserData();
        if(info.contains(":")){
          print("can upload");
          var id = info.split(":::")[0];
          final _authority = "pressback.space:8443";
          final _path = "/setrank";
          var queryParameters = {
            'id': id,
            'seconds': sec,
            'score': score
          };
          var d = await getDynData(_authority,_path,queryParameters);
          print("---------" +d.body+"---------");
        }else{
          print("not logged in");
        }
      }
    }catch(e){
      print("failed to upload results");
    }

  }

  @override
  Widget build(BuildContext context) {
    final ObjQuizResults args = ModalRoute.of(context).settings.arguments;

    if (args != null) {
      //print(args.title);
      //print(args.results);
      title = args.title;
      results = args.results;
    }
    uploadResultes();
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
                            image: AssetImage("assets/imgs/Logo.png"),
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
                                title,
                              ))),
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
                                results,
                              ))),
                    ),
                  ])),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 1,
                            child: ScaleTransition(
                                scale: _tween.animate(CurvedAnimation(
                                    parent: _controller,
                                    curve: Curves.elasticOut)),
                                child: Image(
                                  image: AssetImage(
                                      "assets/imgs/purple_hair_squint.png"),
                                ))),
                        //Expanded(child: SizedBox()),
                        //Expanded(child: SizedBox()),
                        Expanded(
                            child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Padding(
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
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      "Well done",
                                      textAlign: TextAlign.center,
                                    ))),
                          ),
                        )),
                        //Expanded(child: SizedBox()),
                        Flexible(
                            flex: 1,
                            child: ScaleTransition(
                                scale: _tween.animate(CurvedAnimation(
                                    parent: _controller,
                                    curve: Curves.elasticOut)),
                                child: Image(
                                  image: AssetImage(
                                      "assets/imgs/blue_anime_boy.png"),
                                ))),
                      ],
                    )),
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
                /*Expanded(
                  child: FlatButton(
                    child: Text('Say'),
                    onPressed: () {
                      setState(() {
                        AssetsAudioPlayer.newPlayer().open(
                          Audio("assets/mp3/yo.mp3"),
                          autoStart: true,
                        );
                      });
                    },
                  ),
                ),*/
                Expanded(
                  child: FlatButton(
                    child: Text('Share'),
                    onPressed: () {
                      _onShare(context);
                    },
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
