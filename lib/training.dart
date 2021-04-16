import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'objs.dart';

class TrainingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrainingPage();
}



class _TrainingPage extends State<TrainingPage> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);
  bool isFront = true;
  bool showLoading = true;
  ObjCardHat deck = new ObjCardHat();
  int selectedDeck = 0;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);
    loadCardDeck();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  Future loadCardDeck() async {
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
      showLoading = false;
    });

    print("deck " + deck.objlstcards.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            decoration: BoxDecoration(color: Colors.white),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (!isFront) {
                      isFront = true;
                    } else {
                      isFront = false;
                    }
                  });
                },
                child: Container(
                    child: showLoading
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                child: isFront
                                    ? Image.asset("assets/cards/" +
                                        deck.objlstcards[selectedDeck].side1)
                                    : Image.asset("assets/cards/" +
                                        deck.objlstcards[selectedDeck].side2)),
                          ))),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Start drawing',
          backgroundColor: Colors.red,
          child: Text("Draw"),
          onPressed: () {
            if (!showLoading) {
              Navigator.pushNamed(context, '/drawing',
              arguments: deck.objlstcards[selectedDeck].side2);
            }
          },
        ),
        persistentFooterButtons: [
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text('Previous'),
                    onPressed: () {
                      setState(() {
                        if (selectedDeck >= 1) {
                          selectedDeck -= 1;
                        }
                      });
                    },
                  ),
                ),
                /*Expanded(
                  child: FlatButton(
                    child: Text('Say'),
                    onPressed: () {
                      setState(() {
                        AssetsAudioPlayer.newPlayer().open(
                          Audio("assets/mp3/yo.mp3"),
                          autoStart: true,
                        );
                      });
                    },
                  ),
                ),*/
                Expanded(
                  child: FlatButton(
                    child: Text('Next'),
                    onPressed: () {
                      setState(() {
                        if (selectedDeck < deck.objlstcards.length - 1) {
                          selectedDeck += 1;
                          isFront = true;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
