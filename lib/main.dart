import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:core';

/*void main() {
  runApp(MyApp());
}*/


class ObjTwoSideCard{
  String side1 = "";
  String side2 = "";
  ObjTwoSideCard(String s1, String s2){
    this.side1 = s1;
    this.side2 = s2;
  }
}

class ObjCardHat{
  String name = "";
  int from = 0;
  int to = 0;
  List<ObjTwoSideCard> lstcards;
  ObjCardHat(String n, int f, int t){
    lstcards = new List<ObjTwoSideCard>();
    this.from = f;
    this.to = t;
    this.name = n;
  }
}

List<String> LstCards;
List<ObjCardHat> LstCardCollection;


Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}

Future<List<String>> getCards() async {
  String data = await getFileData('cards.txt');
  LineSplitter ls = new LineSplitter();
  List<String> lines = ls.convert(data);
  LstCards = lines;
  /*print("---Result---");
  for (var i = 0; i < lines.length; i++) {
    print('Line $i: ${lines[i]}');
  }*/
  return lines;
}

void sortingCards(){

  for(int i = 1; i < 11; i++){
    int from = 1 * (i*10) - 10 + 1;
    int to = 1 * (i*10);
    print("Loading: " + from.toString() + " " + to.toString());
    ObjCardHat tmp = ObjCardHat("Group_" + i.toString(),from,to);
    LstCardCollection.add(tmp);
  }

  LstCardCollection[9].to = 110;

  for(int i = 0; i < LstCards.length; i++){
    //print(LstCards[i]);
    String cname = "Card_";
    if(LstCards[i].startsWith(cname)){
      String cardsplit1 = LstCards[i].split("Card_")[1];
      String cardsplit2 = cardsplit1.split("_")[0];
      print(cardsplit2);
      for(int l = 0; l < LstCardCollection.length; l++){
        if(i >= LstCardCollection[l].from && i <= LstCardCollection[l].to){
          print(cname);
        }
      }
    }
  }
}

Future<void> main() async {
  LstCardCollection = new List<ObjCardHat>();
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => MyApp(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondScreen(),
      '/training': (context) => TrainingScreen(),
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
                    image: new AssetImage("cards/card_bg.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
                
              child :Column (
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child:Image(
                    image: AssetImage("Logo.png"),
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
                    image: new AssetImage("cards/card_bg.jpg"),
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
                          Navigator.pop(context);
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
                    image: new AssetImage("cards/card_bg.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
                
              child :Column (
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '',
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
                          Navigator.pop(context);
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
                          Navigator.pop(context);
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