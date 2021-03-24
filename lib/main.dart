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
  int cardnumber = 0;
  ObjTwoSideCard(String s1, String s2){
    this.side1 = s1;
    this.side2 = s2;
  }
}

class ObjTmpCardSort{
  String name = "";
  int cardnumber = 0;
  ObjTmpCardSort(String n, int c){
    this.name = n;
    this.cardnumber = c;
  }
}

class ObjCardHat{
  String name = "";
  int groupnumber = 0;
  int from = 0;
  int to = 0;
  List<ObjTwoSideCard> objlstcards;
  List<int> cardFound;
  ObjCardHat(String n, int f, int t, int g){
    this.groupnumber = g;
    this.objlstcards = new List<ObjTwoSideCard>();
    this.cardFound = new List<int>();
    this.from = f;
    this.to = t;
    this.name = n;
  }

  void sortNewCard(String name, int number){
    if(this.cardFound.contains(number)){
      for(int i = 0; i < this.objlstcards.length; i++){
        if(this.objlstcards[i].cardnumber == number){
          if(name.endsWith("s1.png")){
            this.objlstcards[i].side1 = name;
          }else if(name.endsWith("s2.png")){
            this.objlstcards[i].side2 = name;
          }
          break;
        }
      }
    }else{
      ObjTwoSideCard newcard = ObjTwoSideCard("","");
      newcard.cardnumber = number;
      if(name.endsWith("s1.png")){
        newcard.side1 = name;
      }else if(name.endsWith("s2.png")){
        newcard.side2 = name;
      }
      this.objlstcards.add(newcard);
      this.cardFound.add(number);
    }
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
    print("Creating group: " + from.toString() + " " + to.toString());
    ObjCardHat tmp = ObjCardHat("Group_" + i.toString(),from,to, i);
    LstCardCollection.add(tmp);
  }

  LstCardCollection[9].to = 110;

  for(int i = 0; i < LstCards.length; i++){
    //print(LstCards[i]);
    String cname = "Card_";
    if(LstCards[i].startsWith(cname)){
      String cardsplit1 = LstCards[i].split("Card_")[1];
      String cardsplit2 = cardsplit1.split("_")[0];
      var cardnumber = int.parse(cardsplit2);
      for(int l = 0; l < LstCardCollection.length; l++){
        if(cardnumber >= LstCardCollection[l].from && cardnumber <= LstCardCollection[l].to){
          LstCardCollection[l].sortNewCard(LstCards[i],cardnumber);
          break;
        }
      }
    }
  }
  //printCardGroups();
}

void printCardGroups(){
  for(int i = 0; i < LstCardCollection.length; i++){
    print(LstCardCollection[i].name);
    for(int l = 0; l < LstCardCollection[i].objlstcards.length; l++){
      var cardnumber = LstCardCollection[i].objlstcards[l].cardnumber;
      var cards1 = LstCardCollection[i].objlstcards[l].side1;
      var cards2 = LstCardCollection[i].objlstcards[l].side2;
      print("Card " + cardnumber.toString() + " s1 " + cards1 + " s2 " + cards2);
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