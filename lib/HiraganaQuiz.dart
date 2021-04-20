import 'package:flutter/material.dart';
import 'objs.dart';

class HiraganaQuiz extends StatefulWidget {
  static const routeName = '/hiraganaquiz';

  @override
  State<StatefulWidget> createState() => _HiraganaQuiz();
}

class _HiraganaQuiz extends State<HiraganaQuiz> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);

  ObjPassQuiz importedargs;
  int itemView = 0;
  List<List<String>> lstquestion = new List<List<String>>();
  String answer = "";
  int marks = 0;



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

  void loadQuestion() {
    List<List<String>> tmplstquestion = new List<List<String>>();
    tmplstquestion.add(importedargs.normal[itemView]);
    tmplstquestion.add(importedargs.random1[itemView]);
    tmplstquestion.add(importedargs.random2[itemView]);
    lstquestion = tmplstquestion.toList()..shuffle();
    answer = importedargs.normal[itemView][0];
  }

  void nextQuestion(String a) {
    if (a == answer) {
      marks += 1;
    }

    if (itemView < importedargs.normal.length - 1) {
      itemView += 1;
      print(itemView);
      loadQuestion();
    } else {
      //print("marks " + marks.toString());
      String results =
          marks.toString() + "/" + (importedargs.normal.length).toString();
      ObjQuizResults tmpobj =
      new ObjQuizResults("Hiragana " + importedargs.group, results);
      Navigator.pushNamed(context, '/quizdone', arguments: tmpobj);
    }
  }

  @override
  Widget build(BuildContext context) {

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;
    final ObjPassQuiz args = ModalRoute.of(context).settings.arguments;
    importedargs = args;

    if (importedargs == null) {
      ObjPassQuiz tmpobj = generateQuizHiragana("Hiragana multiple choice",
          ((0 + 1) + (0 * 10)) - 1, (((0 + 1) + (0 * 10)) + 10) - 1);
      importedargs = tmpobj;
    }
    //importedargs.group = importedargs.
    loadQuestion();
    return Scaffold(
        appBar: AppBar(
          title: Text("Multiple choice"),
        ),
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
                            image: AssetImage("assets/imgs/anime_glasses_boy.png"),
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
                                  importedargs.title,
                                style: TextStyle(
                                  fontSize: multiplier * unitHeightValue,
                                ),
                              ))),
                    ),
                  ])),
              Flexible(
                flex: 1,
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
                          "Question " + (itemView + 1).toString(),
                          style: TextStyle(
                            fontSize: multiplier * unitHeightValue,
                          ),
                        ))),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(16.0), child: Container(
                  //height: 20,
                  //margin: const EdgeInsets.only(top: 20.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          importedargs.normal[itemView][1],
                          style: TextStyle(
                            fontSize: (multiplier + 2) * unitHeightValue,
                          ),
                        )))),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    /*child: */

                    child: Row(

                        children: <Widget>[
                          for (int i = 0; i < lstquestion.length; i++)
                            new Expanded( child:SizedBox(
                                  //width: double.infinity / 2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  //height: 50.0,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          nextQuestion(lstquestion[i][0]);
                                          //loadQuestion();
                                        });
                                        //Navigator.pushNamed(context, '/hiraganamutliplechoice');
                                        //hiraganamutliplechoice
                                      },
                                      child: Text(
                                        lstquestion[i][0],
                                        style: TextStyle(
                                          fontSize: (multiplier + 2) * unitHeightValue,
                                        ),
                                      )),
                                )),
                        ])
                ),
              )
            ],
          ),
        )


      /*Center(
            child: GestureDetector(
              onTap: () {
                //Navigator.pushNamed(context, '/mainmenu');
              }, // handle your image tap here
              child: Column(children: [
                Container(//anime_glasses_boy
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage("assets/imgs/card_bg.jpg"),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: ScaleTransition(
                            scale: _tween.animate(CurvedAnimation(
                                parent: _controller, curve: Curves.elasticOut)),
                            child: SizedBox(
                                height: 100,
                                width: 100,
                                //child: CircleAvatar(backgroundImage: AssetImage("assets/imgs/Logo.png")),
                                child: Center(
                                  child: Image(
                                    image: AssetImage(
                                        "assets/imgs/anime_glasses_boy.png"),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          //height: 20,
                            margin: const EdgeInsets.only(top: 40.0),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(16.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  importedargs.title,
                                  style: TextStyle(fontSize: 30),
                                ))),
                        Container(
                          //height: 20,
                            margin: const EdgeInsets.only(top: 40.0),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(16.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Question " + (itemView + 1).toString(),
                                  style: TextStyle(fontSize: 30),
                                ))),
                        Container(
                          //height: 20,
                            margin: const EdgeInsets.only(top: 40.0),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(16.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  importedargs.normal[itemView][1],
                                  style: TextStyle(fontSize: 100),
                                ))),
                        for (int i = 0; i < lstquestion.length; i++)
                          new Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SizedBox(
                                //width: double.infinity / 2,
                                width: MediaQuery.of(context).size.width / 2,
                                //height: 50.0,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        nextQuestion(lstquestion[i][0]);
                                        //loadQuestion();
                                      });
                                      //Navigator.pushNamed(context, '/hiraganamutliplechoice');
                                      //hiraganamutliplechoice
                                    },
                                    child: Text(
                                      lstquestion[i][0],
                                      style: TextStyle(fontSize: 100),
                                    )),
                              )),
                      ],
                    )),
              ]
                //child:

              ),
            ))*/
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}