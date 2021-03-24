import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:core';
//import 'moving_card_widget.dart';
//import 'drawing_feature.dart';
import 'startup.dart';

/*void main() {
  runApp(MyApp());
}*/


//-----------------------------------------main app starting

String selectedChallengeDrawing = "";
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
      '/practicewriting': (context) => PracticeWriting(),
      
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
                          Navigator.pushNamed(context, '/practicewriting');
                        },
                        child: Text("Practice writing"),
                      ),
                    )
                  ), 
                  /*Padding(
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
                  ), */ 

                  /*Padding(
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
                  ), */          
               
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

class DrawingScreenArguments {
  final String objcards1;
  DrawingScreenArguments(this.objcards1);
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
                        child: Text("Training " + data.groupnumber.toString()),
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
            
          ),
        ),
        
      );
}

List<Offset> points = <Offset>[];
String bg = "assets/cards/card_bg.jpg";
int viewingItem = 0;


class _FlipMainPageState extends State<FlipMainPage> {
  
  List<String> targetOptions = ['No target', '1', '2', '3', '4']; 
  String dropdownValue = 'One';
  
  bool isFront = true;



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
          constraints: BoxConstraints.expand(),
          decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/cards/card_bg.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
          padding: EdgeInsets.all(50),
          child: Container(
              //margin: const EdgeInsets.all(50.0),
              //padding: EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.white),
            /*child: MovingCardWidget(
              urlFront: "assets/cards/" + twoSideCard.side1,
              urlBack: "assets/cards/" + twoSideCard.side2,
            ),*/
            child: GestureDetector(
              onTap: () {
                setState(() {
                    if(!isFront){
                    isFront = true;
                    }else{
                      isFront = false;
                    }
                });
              

                print(isFront);
              },
              child: Container(
                child: isFront
                    ? Image.asset("assets/cards/" + twoSideCard.side1)
                    : Image.asset("assets/cards/" + twoSideCard.side2)    
              )
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Start drawing',
          backgroundColor: Colors.red,
          child: Text("Start!!!"),
          onPressed: () {
            Navigator.pushNamed(context, '/rundrawing',
                          arguments: DrawingScreenArguments(
                              "assets/cards/" + twoSideCard.side2
                            )
                          );
          },
        ),

        /*bottomNavigationBar: new Container(
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
                          selectedChallengeDrawing = "assets/cards/" + twoSideCard.side2;
                          Navigator.pushNamed(context, '/rundrawing',
                          
                          arguments: DrawingScreenArguments(
                              "assets/cards/" + twoSideCard.side2
                            )
                          );
                          
                        },
                        child: Text("Start" ),
                      )
        ),

          Expanded(
          flex: 1,
          child: ElevatedButton(
                        onPressed: () {
                          //on pressing next change card viewing
                          
                          setState(() {
                            if(viewingItem < selectedCards.objlstcards.length - 1){
                              viewingItem += 1;
                              twoSideCard = selectedCards.objlstcards[viewingItem];
                              isFront = true;
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
        )*/
      );
}

//----------------------


//--------------------------------------------drawing feature
List<Offset> paints = new List<Offset>();

class Sketcher extends CustomPainter {
  final List<Offset> points;

  Sketcher(this.points);

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    //print(points.length);
    paints = points;
    return oldDelegate.points != points;
  }



  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);

      }
    }
  }
}


class MyDrawingPage extends StatefulWidget {


  final String urlFront;

  const MyDrawingPage({
    @required this.urlFront,
    Key key,
  }) : super(key: key);

  @override
  _MyDrawingState createState() => _MyDrawingState(urlFront);
}

class _MyDrawingState extends State<MyDrawingPage> {
  List<Offset> points = <Offset>[];

  String bg = "assets/cards/card_bg.jpg";
  int LstCardsCount = 0;

  String urlFront = "";

  _MyDrawingState(String ufront){
    urlFront = ufront;
    //print(selectedChallengeDrawing + "yay");
  }

  @override
  Widget build(BuildContext context) {
    final Container sketchArea = Container(
      //constraints: BoxConstraints.expand(),
          

      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      //padding: EdgeInsets.all(50),
      child: Container(
 
        constraints: BoxConstraints.expand(),
        decoration: new BoxDecoration(
          //color: Colors.white,
                  image: new DecorationImage(
                    image: new AssetImage("assets/cards/" + twoSideCard.side2),
                    //fit: BoxFit.cover
                  ),
                ),
          child: CustomPaint(
          painter: Sketcher(points),
        ),
      ),
      //color: Colors.blueGrey[50],
      
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Writing'),
      ),
      /*body: GestureDetector(
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
      ),*/


        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/cards/card_bg.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
          child: GestureDetector(
            
            behavior: HitTestBehavior.translucent,
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
            ),
        ),
       // body: Stack(
          
         // children: <Widget>[
            /*Image(
              image: AssetImage("cards/card_bg.jpg"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),*/
            
           /* new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("cards/card_bg.jpg"), fit: BoxFit.cover,),
              ),

              child: GestureDetector(
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
              ),
            ),*/


         // ],
       // ),
      /*persistentFooterButtons: [
        RaisedButton(
          onPressed: () async{

          },
          child: const Text('Next Image', style: TextStyle(fontSize: 30)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
        RaisedButton(
          onPressed: () {
          },
          child: const Text('Compare', style: TextStyle(fontSize: 30)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
        RaisedButton(
          onPressed: (){
           
          },
          child: const Text('Save 1', style: TextStyle(fontSize: 30)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
        RaisedButton(
          onPressed: (){
  
          },
          child: const Text('Save 2', style: TextStyle(fontSize: 30)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
      ],*/
      floatingActionButton: FloatingActionButton(
        tooltip: 'clear Screen',
        backgroundColor: Colors.red,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() => points.clear());
        },
      ),
    );
  }
}


    /*LstCardCollection.map((ObjCardHat data) {
              List<ObjTwoSideCard> allcards = data.objlstcards;
              print("yyay");
              return Widget(
                    children: allcards.map((ObjTwoSideCard cardSides) {
                      return Image(image: AssetImage('assets/cards/' + cardSides.side1));
                      }).toList()
                  );
                  
                  
                  /**/
            }).toList()  */
ObjTwoSideCard findCards(int number){
  int count = 1;
  ObjTwoSideCard found = LstCardCollection[0].objlstcards[0];
  for(int i = 0; i < LstCardCollection.length; i++){
    for(int l = 0; l < LstCardCollection[i].objlstcards.length; l++){
      var cardnumber = LstCardCollection[i].objlstcards[l].cardnumber;
      if(number == count){
        found = LstCardCollection[i].objlstcards[l];
        //print(LstCardCollection[i].objlstcards[l].side1);
        return found;
        
      }
      count +=1;
      //print("Card " + cardnumber.toString() + " s1 " + cards1 + " s2 " + cards2);
    }
  }
  return found;
}

                /*child: GestureDetector(
                  onTap: () {
                      //selectedCards = data;
                          Navigator.pushNamed(context, '/runtraining'
                          /*,arguments: ScreenArguments(
                            data
                          )*/
                          );
                    },
                  child: Image.asset("assets/cards/" + findCards(countUsed).side1)*/

/*return SingleChildScrollView( child: Column(
      children: <Widget>[
        for (int i = 1;i <= 104;i++) GestureDetector(
                  onTap: () {
                      //selectedCards = data;
                          Navigator.pushNamed(context, '/runtraining'
                          /*,arguments: ScreenArguments(
                            data
                          )*/
                          );
                    },
                  child: Image.asset("assets/cards/" + findCards(i).side1)),
      ],
    ));*/
ObjTwoSideCard twoSideCard;
    List _buildList(BuildContext context,int count) {  
      
  List<Widget> listItems = List();  
  for (int i = 1; i < count; i++) {
    ObjTwoSideCard tmp = findCards(i);  
    listItems.add(
         Container(
           //height: 150.0,
          padding: EdgeInsets.all(50),
          decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/cards/card_bg.jpg"),
                    //fit: BoxFit.cover
                  ),
                ),
          child: GestureDetector(
            onTap: () {
                twoSideCard = tmp;
                Navigator.pushNamed(context, '/runtraining');
            
            },
            child: Image.asset("assets/cards/" + tmp.side1)
          )
        )  
    );  
    twoSideCard = tmp;
  }  
  return listItems;  
}  

class PracticeWriting extends StatelessWidget {


  Widget method1(BuildContext context) {
    List<List<String>> tmpcards = new List<List<String>>();
    for (int i = 1;i < 104;i++) {
      List<String> tmplst = new List<String>();
      tmplst.add(findCards(i).side1);
      if(i + 1 <= 104){
        tmplst.add(findCards(i + 1).side1);
        print("wtf" + findCards(i + 1).side1);
      }
      tmpcards.add(tmplst);
      i += 1;
      //print(i);
    }
    //print("");

    return SingleChildScrollView( child: Column(
      children: <Widget>[
        for (int i = 0;i < tmpcards.length;i++)
        Row(
          children: [
            GestureDetector(
                  onTap: () {
                      //selectedCards = data;
                          Navigator.pushNamed(context, '/runtraining'
                          /*,arguments: ScreenArguments(
                            data
                          )*/
                          );
                    },
                  child: Image.asset("assets/cards/" + tmpcards[i][0])),
                  GestureDetector(
                    
                  onTap: () {
                      //selectedCards = data;
                          Navigator.pushNamed(context, '/rundrawing'
                          /*,arguments: ScreenArguments(
                            data
                          )*/
                          );
                    },
                  child: Image.asset("assets/cards/" + tmpcards[i][1]))
          ],
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
body: CustomScrollView(
        slivers: <Widget>[
          /*SliverList(
            delegate: new SliverChildListDelegate(_buildList(104)),  
          )*/
          SliverGrid.count(
            crossAxisCount: 2,
            children: _buildList(context,104)
          )
        ]
)
      /*body:
            Container(
              constraints: BoxConstraints.expand(),
              child: ListView(
          children: [
              for (int i = 1;i <= 104;i++) GestureDetector(
                  onTap: () {
                      //selectedCards = data;
                          Navigator.pushNamed(context, '/runtraining'
                          /*,arguments: ScreenArguments(
                            data
                          )*/
                          );
                    },
                  child: Container(
                    
                    decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/cards/card_bg.jpg"),
                    //fit: BoxFit.cover
                  ),
                ),
                     padding: EdgeInsets.all(50),
                    child: Image.asset("assets/cards/" + findCards(i).side1
                    /*,width: 260,
              height: 434*/
                    ,fit: BoxFit.cover,
                  )

                  )),
            ],
            
          )
            )*/
          
        
        
    );
  }
}