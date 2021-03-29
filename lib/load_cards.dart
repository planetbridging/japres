import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ObjTwoSideCard {
  String side1 = "";
  String side2 = "";
  int cardnumber = 0;
  ObjTwoSideCard(String s1, String s2) {
    this.side1 = s1;
    this.side2 = s2;
  }
}

class ObjCardHat {
  String name = "";
  int groupnumber = 0;
  int from = 0;
  int to = 0;
  List<ObjTwoSideCard> objlstcards;
  List<int> cardFound;
  List<String> cardNames;
  ObjCardHat(/*String n, int f, int t, int g*/) {
    //this.groupnumber = g;
    this.cardNames = new List<String>();
    this.objlstcards = new List<ObjTwoSideCard>();
    this.cardFound = new List<int>();
    /*this.from = f;
    this.to = t;
    this.name = n;*/
  }

  void sortNewCard(String name, int number) {
    if (this.cardFound.contains(number)) {
      for (int i = 0; i < this.objlstcards.length; i++) {
        if (this.objlstcards[i].cardnumber == number) {
          if (name.endsWith("s1.png")) {
            this.objlstcards[i].side1 = name;
          } else if (name.endsWith("s2.png")) {
            this.objlstcards[i].side2 = name;
          }
          break;
        }
      }
    } else {
      ObjTwoSideCard newcard = ObjTwoSideCard("", "");
      newcard.cardnumber = number;
      if (name.endsWith("s1.png")) {
        newcard.side1 = name;
      } else if (name.endsWith("s2.png")) {
        newcard.side2 = name;
      }
      this.objlstcards.add(newcard);
      this.cardFound.add(number);
      this.cardNames.add("Card " + number.toString());
    }
  }
}

ObjCardHat deck = new ObjCardHat();
int selectedDeck = 0;

class PracticeWriting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PracticeWriting();
}

class _PracticeWriting extends State<PracticeWriting>
    with TickerProviderStateMixin {
  // initializer list

  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 1.25, end: 2);

  final List<Color> circleColors = [
    Colors.red,
    Colors.yellow,
    Colors.pink,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.blue,
  ];

  Color randomGenerator() {
    return circleColors[new Random().nextInt(circleColors.length)];
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/cards/'))
        .toList();
    setState(() {
      for (int i = 0; i < imagePaths.length; i++) {
        //print(imagePaths[i]);
        //LstCardPaths.add(imagePaths[i]);
        var clean = imagePaths[i].split("assets/cards/");
        String cname = "Card_";
        if (clean[1].startsWith(cname)) {
          String cardsplit1 = clean[1].split("Card_")[1];
          String cardsplit2 = cardsplit1.split("_")[0];
          var cardnumber = int.parse(cardsplit2);
          deck.sortNewCard(clean[1], cardnumber);
        }
      }
    });

    print("deck " + deck.objlstcards.length.toString());
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);
    _initImages();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Training"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          /*SliverAppBar(
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      "Hiragana",
                      style: TextStyle(fontSize: 50),
                      textAlign: TextAlign.center,
                    )
                  )
                ),
                expandedHeight: 100,
                //floating: true,
              ),*/
          SliverGrid.count(
            crossAxisCount: 4,
            children: [
              for (int i = 0; i < deck.objlstcards.length; i++)
                new Padding(
                    padding: EdgeInsets.all(5.0),
                    child: SizedBox(
                        //width: double.infinity / 2,
                        width: MediaQuery.of(context).size.width / 2,
                        height: 100.0,
                        child: Container(
                            //height: 150.0,
                            padding: EdgeInsets.all(50),
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image:
                                    new AssetImage("assets/cards/card_bg.jpg"),
                                //fit: BoxFit.cover
                              ),
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  //twoSideCard = tmp;
                                  selectedDeck = i;
                                  Navigator.pushNamed(context, '/runtraining');
                                },
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset("assets/cards/" +
                                    deck.objlstcards[i].side1)
                                ))
                                    
                                    )))),
            ],
          ),
        ],
      ),
    );
  }
}

List<Offset> points = <Offset>[];

class FlipMainPage extends StatefulWidget {
  final ObjCardHat selectedgroup;

  const FlipMainPage({
    Key key,
    @required this.selectedgroup,
  }) : super(key: key);

  @override
  _FlipMainPageState createState() => _FlipMainPageState();
}

class _FlipMainPageState extends State<FlipMainPage> {
  List<String> targetOptions = ['No target', '1', '2', '3', '4'];
  String dropdownValue = 'One';

  bool isFront = true;

  Container sketchArea = Container(
    decoration: new BoxDecoration(),

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
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/cards/card_bg.jpg"),
                fit: BoxFit.cover),
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
                    if (!isFront) {
                      isFront = true;
                    } else {
                      isFront = false;
                    }
                  });

                  print(isFront);
                },
                child: Container(
                    child: isFront
                        ? Image.asset("assets/cards/" +
                            deck.objlstcards[selectedDeck].side1)
                        : Image.asset("assets/cards/" +
                            deck.objlstcards[selectedDeck].side2))),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Start drawing',
          backgroundColor: Colors.red,
          child: Text("Draw"),
          onPressed: () {
            Navigator.pushNamed(context,
                '/rundrawing' 
                );
          },
        ),
      );
}

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


//---------------drawing

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
                  /*image: new DecorationImage(
                    image: new AssetImage("assets/cards/" + deck.objlstcards[selectedDeck].side2),
                    //fit: BoxFit.cover
                  ),*/
                ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
          painter: Sketcher(points),
        ),

        /*Container(
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset("assets/cards/" +
                                    deck.objlstcards[selectedDeck].side2)
                                ))*/
            ],
          )
      ),
      //color: Colors.blueGrey[50],
      
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Writing'),
      ),


        /*body: Container(
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
        ),*/

        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/imgs/card_bg.jpg"),
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
              child:  Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                    ),
                    //decoration: new BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Image.asset("assets/cards/" +
                                    deck.objlstcards[selectedDeck].side2)
                    )
                  )
                  ,),
              ),
              CustomPaint(
          painter: Sketcher(points),
        ),
              
            ],
          ),
            ),
        ),

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