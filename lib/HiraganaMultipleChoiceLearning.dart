import 'package:flutter/material.dart';
import 'objs.dart';


class HiraganaMultipleChoiceLearning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HiraganaMultipleChoiceLearning();
}

class _HiraganaMultipleChoiceLearning
    extends State<HiraganaMultipleChoiceLearning>
    with TickerProviderStateMixin {

  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);

  getRow(int i,int i2){
    return Flexible(
      flex: 1,
      child: Padding(
          padding: EdgeInsets.all(16.0),
          /*child: */

          child: Row(

              children: <Widget>[
                Expanded( child:SizedBox(
                  //width: double.infinity / 2,
                  //width: MediaQuery.of(context).size.width/3,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      ObjPassQuiz tmpobj = generateQuizHiragana("Hiragana multiple choice",((i + 1) + (i*10))-1,(((i + 1) + (i*10))+10)-1);
                      Navigator.pushNamed(context, '/hiraganaquiz',
                          arguments: tmpobj
                      );
                    },
                    child: Text(((i + 1) + (i*10)).toString() + " to " + (((i + 1) + (i*10))+10).toString()),
                  ),
                )),
                Expanded( child:SizedBox(
                  //width: double.infinity / 2,
                  //width: MediaQuery.of(context).size.width/3,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      ObjPassQuiz tmpobj = generateQuizHiragana("Hiragana multiple choice",((i2 + 1) + (i2*10))-1,(((i2 + 1) + (i2*10))+10)-1);
                      Navigator.pushNamed(context, '/hiraganaquiz',
                          arguments: tmpobj
                      );
                    },
                    child: Text(((i2 + 1) + (i2*10)).toString() + " to " + (((i2 + 1) + (i2*10))+10).toString()),
                  ),
                ))
              ])
      ),
    );
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
            getRow(0,1),
            getRow(2,3),
            getRow(4,5),
            getRow(6,7),
            Row(children: <Widget>[Expanded( child:SizedBox(
              //width: double.infinity / 2,
              //width: MediaQuery.of(context).size.width/3,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  ObjPassQuiz tmpobj = generateQuizHiragana("Hiragana multiple choice",88,characters.length-1);
                  Navigator.pushNamed(context, '/hiraganaquiz',
                      arguments: tmpobj
                  );
                },
                child: Text("89 to 104"),
              ),
            ))]),

          ],
        ),
      ),

    );
  }


    }