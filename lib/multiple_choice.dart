import 'dart:math';

import 'package:flutter/material.dart';
import 'package:japres/main.dart';

import 'LstOfObjs.dart';


ObjPassQuiz passedQuizData;
List<ObjTwoSideCard> normalShuffled;
List<ObjTwoSideCard> random1Shuffled;
List<ObjTwoSideCard> random2Shuffled;
var totalScore = 0;
int questionNumber = 0;
String answerBtn = "";
String showQuestion = "";
List<String> lstanswers = new List<String>();
List<String> lstrandomanswers;
String btn1 = "";
String btn2 = "";
String btn3 = "";

void loadQuestion() {
    lstanswers = new List<String>();
    showQuestion = "assets/cards/" + normalShuffled[questionNumber].side1;
    answerBtn = "assets/cards/" + normalShuffled[questionNumber].side2;
    lstanswers.add("assets/cards/"  + normalShuffled[questionNumber].side2);
    lstanswers.add("assets/cards/"  + random1Shuffled[questionNumber].side2);
    lstanswers.add("assets/cards/"  + random2Shuffled[questionNumber].side2);
    lstrandomanswers = lstanswers.toList()..shuffle();
    print(lstrandomanswers[0]);
    //print("assets/cards/" + lstrandomanswers[0]);
    //btn1 = "assets/cards/" + normalShuffled[questionNumber].side2;

      //loadQuestion();
    btn1 = lstrandomanswers[0];
    btn2 = lstrandomanswers[1];
    btn3 = lstrandomanswers[2];
      //btn2 = "assets/cards/" + lstrandomanswers[1];
      //btn3 = "assets/cards/" + lstrandomanswers[2];
      

}

class ExtractQuizArgumentsScreen extends StatelessWidget {
  static const routeName = '/quiz';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ObjPassQuiz args = ModalRoute.of(context).settings.arguments;
    //print(args.normalCards.name);
    passedQuizData = args;

    normalShuffled = passedQuizData.normalCards.objlstcards.toList()..shuffle();
    random1Shuffled = passedQuizData.random1Cards.objlstcards.toList()..shuffle();
    random2Shuffled = passedQuizData.random2Cards.objlstcards.toList()..shuffle();
    loadQuestion();
    return Scaffold(
      /*appBar: AppBar(
        title: Text(args.title),
      ),*/
      body: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _QuizAppState();
  }
}
  
class _QuizAppState extends State<QuizApp> {
  

  

  void resetQuiz() {
    setState(() {
      
    });
  }

  void nextQuestion(){

  }

  
  @override
  Widget build(BuildContext context) {
    //it does work if its child of orginial final ObjPassQuiz t = ModalRoute.of(context).settings.arguments;
    //print(args.normalCards.groupnumber.toString() + "eiojfioejfio");

    
    
    //print(random2Shuffled.length.toString() + "obj count");
    //loadQuestion();
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Multiple choice - " + "Cards from " /*+ normalCards.from.toString() + " to " + normalCards.to.toString()*/),
        ),
         //Padding

         body: Center(


        child: GestureDetector(
  onTap: () {
    print("yay");
    //Navigator.pushNamed(context, '/second');
  }, // handle your image tap here
  child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/cards/card_bg.jpg"),
                            fit: BoxFit.cover
                          ),
                        ),
                        
                      child :Column (
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                            Expanded(
                              flex: 1,
                                child: Image(
                                image: AssetImage(showQuestion),
                              )  
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                              "Match the card - Question " + questionNumber.toString(),
                              style: new TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                              ),
                            ),),
                            Expanded(
                              flex: 1,
                                child: ElevatedButton(
                        onPressed: () {
                          nextQuestion();
                        },

                        child: FittedBox(
                            child: Image(
                              image: AssetImage(btn1),
                              height: (MediaQuery. of(context). size. height)/6,
                              width: MediaQuery. of(context). size. width,
                            ),
                            fit: BoxFit.fill,
                        )
                        ,
                      ) 
                            ),
                            Expanded(
                              flex: 1,
                                child: ElevatedButton(
                        onPressed: () {
                        },

                          child: FittedBox(
                              child: Image(
                                image: AssetImage(btn2),
                                height: (MediaQuery. of(context). size. height)/6,
                                width: MediaQuery. of(context). size. width,
                              ),
                              fit: BoxFit.fill,
                          )
                        ,
                      ) 
                            ),
                            Expanded(
                              flex: 1,
                                child: ElevatedButton(
                        onPressed: () {
                        },

                          child: FittedBox(
                              child: Image(
                                image: AssetImage(btn3),
                                height: (MediaQuery. of(context). size. height)/6,
                              width: MediaQuery. of(context). size. width,
                              ),
                              fit: BoxFit.fill,
                          )
                        ,
                      ) 
                            )
                      ],
                      )   
                  ),

                
                ]
                  //child: 
                

                
                ),
          )
        )
       //Scaffold

    ); //MaterialApp
  }
}
