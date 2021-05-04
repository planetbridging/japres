
import 'dart:math';

import 'package:flutter/material.dart';
import 'objs.dart';

class MiniGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MiniGame();
}

class _MiniGame extends State<MiniGame> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.8, end: 0.9);
  Color caught1Color = Colors.grey;
  Color caught2Color = Colors.grey;
  Color answerColor = Colors.lightGreen;
  String topAnswer = "";
  String bottomAnswer = "";
  int TopOrBottomRightAnswer = 0;
  int count = 0;
  int correctCount = 0;

  List<ObjColorAnswers> LstAnswers = new List<ObjColorAnswers>();

  /*String answer1 = "a";
  String answer2 = "b";
  String answer3 = "c";
  Color answer1Color = Colors.blueAccent;
  Color answer2Color = Colors.orange;
  Color answer3Color = Colors.lightGreen;*/
  List<ObjPassQuiz> LstQuizs = new List<ObjPassQuiz>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);

    loadQuiz();
  }

  generateRange(var i){
    var from = ((i + 1) + (i*10))-1;
    var to = (((i + 1) + (i*10))+10)-1;
    print("f: " + from.toString() + " - to: " + to.toString());
    var range = [from,to];
    return range;
  }

  loadQuiz(){
    for(var i = 0; i< 8;i++){
      var r = generateRange(i);
      ObjPassQuiz opass = generateQuizHiragana("Hiragana multiple choice",r[0],r[1]);
      LstQuizs.add(opass);
    }
    ObjPassQuiz opass = generateQuizHiragana("Hiragana multiple choice",88,characters.length-1);
    LstQuizs.add(opass);
    List<ObjPassQuiz> shuff = LstQuizs.toList()..shuffle();
    LstQuizs = shuff;
    loadQuestion();
  }

  generateRandomColors(){
    List<Color> randomColors = List<Color>();
    randomColors.add(Colors.blueAccent);
    randomColors.add(Colors.orange);
    randomColors.add(Colors.lightGreen);
    List<Color> shuff = randomColors.toList()..shuffle();
    randomColors = shuff;
    return randomColors;
  }


  loadQuestion(){
    if(count < LstQuizs[0].normal.length){
      List<Color> lst_r_coors = generateRandomColors();
      List<ObjColorAnswers> tmplst = new List<ObjColorAnswers>();
      //tmplst.add(new ObjColorAnswers(0,MediaQuery.of(context).size.height/3));
      List<int> answers = [0,1,2];
      answers = answers.toList()..shuffle();
      //this.name,this.color,this.X,this.Y
      print(LstQuizs[0].normal[0].length);
      print(LstQuizs[0].normal[count]);
      answerColor = lst_r_coors[0];
      tmplst.add(new ObjColorAnswers(LstQuizs[0].normal[count][1],lst_r_coors[0],0.0,0.0));
      tmplst.add(new ObjColorAnswers(LstQuizs[0].random1[count][1],lst_r_coors[1],0.0,0.0));
      tmplst.add(new ObjColorAnswers(LstQuizs[0].random2[count][1],lst_r_coors[2],0.0,0.0));
      Random random = new Random();
      int randomNumber = random.nextInt(2) + 0;
      TopOrBottomRightAnswer = randomNumber;
      if(TopOrBottomRightAnswer == 0){
        topAnswer = LstQuizs[0].normal[count][0];
        bottomAnswer = LstQuizs[0].random1[count][0];
      }else{
        bottomAnswer = LstQuizs[0].normal[count][0];
        topAnswer = LstQuizs[0].random2[count][0];
      }
      tmplst = tmplst.toList()..shuffle();
      setState(() {
        LstAnswers = tmplst;
      });

      //LstAnswers.add(tmplst[0]);
    }else{
      print("done");
      String results =
          correctCount.toString() + "/" + (LstQuizs[0].normal.length).toString();
      ObjQuizResults tmpobj =
      new ObjQuizResults("Drag Hiragana " + LstQuizs[0].group, results);
      Navigator.pushNamed(context, '/quizdone', arguments: tmpobj);
    }

    print(count.toString() + " - " + LstQuizs[0].normal.length.toString());
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  checkAnswer(int updown, Color answer){
    if(updown == TopOrBottomRightAnswer){
      if(answerColor == answer){
        setState(() {
          correctCount += 1;
        });

        print("yay");
      }else{
        print("wrong color");
      }
    }else{
      print("wrong up or down");
    }
    count+= 1;
    loadQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag quiz " + LstQuizs[0].group),
      ),
        body: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/imgs/card_bg.jpg"),
                  fit: BoxFit.cover),
            ),

            child: Center(
            child: GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, '/mainmenu');
              }, // handle your image tap here
              child: Stack(

                children: <Widget>[
                  if(LstAnswers.length > 2)
                    DragBox(Offset(0, MediaQuery.of(context).size.height/3), LstAnswers[0].name, LstAnswers[0].color),

                  if(LstAnswers.length > 2)
                    DragBox(Offset(MediaQuery.of(context).size.width/3, MediaQuery.of(context).size.height/3), LstAnswers[1].name, LstAnswers[1].color),
                  if(LstAnswers.length > 2)
                    DragBox(Offset((MediaQuery.of(context).size.width/3)*2, MediaQuery.of(context).size.height/3), LstAnswers[2].name, LstAnswers[2].color),
                 // for(var i = 0; i< LstAnswers.length;i++)
                   // DragBox(Offset(100, 100), LstAnswers[i].name, LstAnswers[i].color),
                  //DragBox(Offset(0, MediaQuery.of(context).size.height/3), answer1, answer1Color),
                  //DragBox(Offset(MediaQuery.of(context).size.width/3, MediaQuery.of(context).size.height/3), answer2, answer2Color),
                  //DragBox(Offset((MediaQuery.of(context).size.width/3)*2, MediaQuery.of(context).size.height/3), answer3, answer3Color),
                  Positioned(
                    left: 0,
                    bottom: 0.0,
                    child: DragTarget(
                      onAccept: (Color color) {
                        caught2Color = color;
                        checkAnswer(1,color);
                      },
                      builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                          ) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: accepted.isEmpty ? caught2Color : Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Text(bottomAnswer,
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 20.0,
                              ),),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0.0,
                    child: DragTarget(
                      onAccept: (Color color) {
                        caught1Color = color;
                        checkAnswer(0,color);
                      },
                      builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                          ) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: accepted.isEmpty ? caught1Color : Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Text(topAnswer,
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ))),

        persistentFooterButtons: [
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text(correctCount.toString() + "/" + LstQuizs[0].normal.length.toString()),
                    onPressed: () {
                      //Navigator.pushNamed(context, '/');
                      //setCurrentUser("123995826417993");
                    },
                  ),
                ),
              ],
            ),
          )
        ]
    );
  }
}


class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(this.initPos, this.label, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);
  var leftPos = 0.0;
  var topPos = 0.0;
  @override
  void initState() {
    super.initState();
    position = widget.initPos;
    leftPos = position.dx;
    topPos = position.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: leftPos,
        top: topPos,
        child: Draggable(
          data: widget.itemColor,
          child: Container(
            width: MediaQuery.of(context).size.width/3,
            height: 100.0,
            color: widget.itemColor,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          feedback: Container(
            width: 120.0,
            height: 120.0,
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ));
  }
}