import 'package:flutter/material.dart';


class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainMenu();
}

class _MainMenu extends State<MainMenu> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);

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

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;
    print(Uri.base);
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
                            "Welcome, What would you like to learn to day?",
                            style: TextStyle(
                              fontSize: multiplier * unitHeightValue,
                            ),
                          ))),
                ),
              ])),
          Flexible(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  //width: double.infinity / 2,
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamed(context, '/training');
                      Navigator.pushNamed(context, '/training');
                      //runtraining
                      //hiraganamutliplechoice
                    },
                    child: Text("Training"),
                  ),
                )),
          ),
          Flexible(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  //width: double.infinity / 2,
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/showquiz');
                    },
                    child: Text("Multiple choice"),
                  ),
                )),
          ),
          Flexible(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  //width: double.infinity / 2,
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/matchall');
                    },
                    child: Text("Match all"),
                  ),
                )),
          ),
          Flexible(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  //width: double.infinity / 2,
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("Leaderboards"),
                  ),
                )),
          ),
        ],
      ),
    ),
    
    /*persistentFooterButtons: [
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
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
                /*Expanded(
                  child: FlatButton(
                    child: Text('Share'),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                )*/
              ],
            ),
          )
        ]*/
    
    );
  }
}
