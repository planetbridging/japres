import 'dart:math';
import  'package:explode_view/explode_view.dart'; 
import 'package:flutter/material.dart';
import 'package:japres/main.dart';

import 'LstOfObjs.dart';


ObjPassQuiz passedQuizData;
List<ObjTwoSideCard> normalShuffled;
List<ObjTwoSideCard> random1Shuffled;
List<ObjTwoSideCard> random2Shuffled;
int totalScore = 0;
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
    //print(lstrandomanswers[0]);
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

  void nextQuestion(String cardAnswer){
    if(questionNumber < normalShuffled.length){ 
      if(cardAnswer == answerBtn){
        totalScore+= 1;
      }
      
      print("Answered " + totalScore.toString() + " ");
      if(questionNumber >= (normalShuffled.length - 1)){
        print("Score " + totalScore.toString() + " ");
        
                          Navigator.pushNamed(context, '/finishedquiz',
                          );
      }else{
        questionNumber += 1;
        setState(() {
          loadQuestion();
        });
      }
      
      
    }
    
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
                              "Match the card - Question " + (questionNumber+1).toString(),
                              style: new TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                              ),
                            ),),
                            Expanded(
                              flex: 1,
                                child: ElevatedButton(
                        onPressed: () {
                          nextQuestion(btn1);
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
                            nextQuestion(btn2);
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
                          nextQuestion(btn3);
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


//------------------------------------finished screen

class FinishedQuizScreen extends StatefulWidget {
  FinishedQuizScreen({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _FinishedQuizScreenState createState() => _FinishedQuizScreenState();
}

class _FinishedQuizScreenState extends State<FinishedQuizScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(widget.title),
      ),*/
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
              children: <Widget>[
                Center(
                  /*child:Image(
                    image: AssetImage("assets/Logo.png"),
                  ),*/
                  child: Stack(
                    children: [ExplodeView(  
                    imagePath: "assets/Logo.png", 
                    imagePosFromLeft: 10, 
                    imagePosFromTop: 10,  // path where the image is stored 
                    //imagePosFromLeft: 	120.0, // set x-coordinate for image 
                    //imagePosFromRight: 300.0,  // set y-coordinate for image 
                      
                    )], 
                  )
                ),
                Center(
                  child:Image(
                    image: AssetImage("assets/Logo.png"),
                  ),
                ),
                Text(
                    "Finished!!! " + totalScore.toString(),
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/second');
                      },
                      child: Text("Main Menu"),
                    ),
                  )
                  ),
               
              ],
              )   
          ),

        
        ]
          //child: 
        

        
      ),
)
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}