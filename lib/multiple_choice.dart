import 'package:flutter/material.dart';
import 'package:japres/main.dart';

import 'LstOfObjs.dart';


ObjCardHat tmp;

class QuizApp extends StatefulWidget {

  QuizApp(ObjCardHat t){
    tmp = t;
    print(tmp.groupnumber);
  }

  @override
  State<StatefulWidget> createState() {
    return _QuizAppState();
  }
}
  
class _QuizAppState extends State<QuizApp> {
  
  var totalScore = 0;

  var shuffled = tmp.objlstcards.toList()..shuffle();

  String btn1 = "assets/Logo.png";
  
  void resetQuiz() {
    setState(() {
      
    });
  }

  void nextQuestion() {
    setState(() {
      btn1 = "assets/cards/card_bg.jpg";
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Multiple choice - " + "Cards from " + tmp.from.toString() + " to " + tmp.to.toString()),
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
                                image: AssetImage("assets/Logo.png"),
                              )  
                            ),
                            Expanded(
                              flex: 1,
                                child: ElevatedButton(
                        onPressed: () {
                          nextQuestion();
                        },

                        child: FittedBox(
                            child: Image(
                              image: AssetImage(btn1),
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
                                image: AssetImage("assets/Logo.png"),
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
                                image: AssetImage("assets/Logo.png"),
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
