import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:core';
import 'moving_card_widget.dart';
import 'drawing_feature.dart';
import 'startup.dart';
/*void main() {
  runApp(MyApp());
}*/


//-----------------------------------------main app starting
Future<void> main() async {
  LstCardCollection = new List<ObjCardHat>();
  runApp(MaterialApp(
    title: 'Japres',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => MyApp(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondScreen(),
      '/training': (context) => TrainingScreen(),
      '/runtraining': (context) => FlipMainPage(),
      '/rundrawing': (context) => MyDrawingPage(),
    },
  ));
  await getCards();
  sortingCards();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
    Navigator.pushNamed(context, '/second');
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
                  child:Image(
                    image: AssetImage("assets/Logo.png"),
                  ),
                ),
                Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),
                  
                )
               
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


//----------------------second page

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                Text(
                  'Main Menu',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),
                  
                ),
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Home Screen"),
                    ),
                  )
                  ),

                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/training');
                        },
                        child: Text("Training"),
                      ),
                    )
                  ),  

                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                         // Navigator.pop(context);
                         
                          
                        },
                        child: Text("Challenges"),
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
    );
  }
}

class ScreenArguments {
  final ObjCardHat objcards;
  ScreenArguments(this.objcards);
}


class TrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Training"),
      ),
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
                //loading from List<ObjCardHat> LstCardCollection;
              children: LstCardCollection.map((ObjCardHat data) {
              /*return RaisedButton(
                child: Text("Challenge " + data.groupnumber.toString()),
                onPressed: () {
                  print(data);
                },
              );*/
              return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/training');
                          selectedCards = data;
                          Navigator.pushNamed(context, '/runtraining'
                          /*,arguments: ScreenArguments(
                            data
                          )*/
                          );
                        },
                        child: Text("Challenge " + data.groupnumber.toString()),
                      ),
                    )
                  );
            }).toList(),
              )   
          ),

        
        ]
          //child: 
        

        
      ),
)
      )
    );
  }
}


class RunTrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
              ],
              )   
          ),

        
        ]
          //child: 
        

        
      ),
)
      )
    );
  }
}


class FlipMainPage extends StatefulWidget {
    final ObjCardHat selectedgroup;

  const FlipMainPage({
    Key key,
    @required this.selectedgroup,
  }) : super(key: key);

  @override
  _FlipMainPageState createState() => _FlipMainPageState();
}

class _MainPageState extends State<FlipMainPage> {

  

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Training"),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: MovingCardWidget(
              urlFront: 'assets/cards/Card_1_Intro_Hiragana_O_s1.png',
              urlBack: 'assets/cards/Card_1_Intro_Hiragana_O_s2.png',
            ),
          ),
        ),
      );
}

List<Offset> points = <Offset>[];
String bg = "assets/cards/card_bg.jpg";
class _FlipMainPageState extends State<FlipMainPage> {
  
  List<String> targetOptions = ['No target', '1', '2', '3', '4']; 
  String dropdownValue = 'One';
  int viewingItem = 0;
  ObjTwoSideCard twoSideCard;

  _FlipMainPageState(){
    twoSideCard = selectedCards.objlstcards[viewingItem];
  }

  Container sketchArea = Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(bg),
        ),
      ),

      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      //color: Colors.blueGrey[50],
      child: CustomPaint(
        painter: Sketcher(points),
      ),
    );

  @override
  Widget build(BuildContext context) => Scaffold(


    

        appBar: AppBar(
          title: Text("Training"),
        ),

         /*body: Stack(
          children: <Widget>[
            GestureDetector(

              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox box = context.findRenderObject();
                  Offset point = box.globalToLocal(details.globalPosition);
                  point = point.translate(0.0, -(AppBar().preferredSize.height));

                  points = List.from(points)..add(point);
                });
              },
              onPanEnd: (DragEndDetails details) {
                points.add(null);
              },
              child: sketchArea,
            )
          ]
         ),*/
        body: Container(
          decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/cards/card_bg.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
          padding: EdgeInsets.all(16),
          child: Center(
            child: MovingCardWidget(
              urlFront: "assets/cards/" + twoSideCard.side1,
              urlBack: "assets/cards/" + twoSideCard.side2,
            ),
          ),
        ),
/*
          child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("cards/card_bg.jpg"),
                          fit: BoxFit.cover
                        ),
                      ),
                      
                    child :Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       CustomPaint(
                        painter: Sketcher(points),
                      )
                    ],
                    )   
                ),

              
              ]
                //child: 
              

              
            )
        ),*/
        bottomNavigationBar: new Container(
          decoration: new BoxDecoration(color: Colors.blue),
    padding: EdgeInsets.all(0.0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[

        Expanded(
          flex: 1,
          child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/training');
                          Navigator.pushNamed(context, '/rundrawing');
                          
                        },
                        child: Text("Start" ),
                      )
        ),
         
        /*Expanded(child: DropdownButton<String>(
            value: dropdownValue,
            
                 
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            
            items: targetOptions//selectedCards.cardNames
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),*/

          Expanded(
          flex: 1,
          child: ElevatedButton(
                        onPressed: () {
                          //on pressing next change card viewing
                          setState(() {
                            if(viewingItem < selectedCards.objlstcards.length - 1){
                              viewingItem += 1;
                              twoSideCard = selectedCards.objlstcards[viewingItem];
                            }
                          });
                          //Navigator.pushNamed(context, '/training');
                          //Navigator.pushNamed(context, '/runtraining');
                          //print(selectedCard.name);
                          
                        },
                        child: Text("Next "),
                      )
        ),
        
      ],
    ),
        )
      );
}

//----------------------