import 'package:flutter/material.dart';


class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Info();
}

class _Info extends State<Info> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.7, end: 0.9);

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

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;
    print(Uri.base);


    generateText(String txt){
      return Container(
        //height: 20,
        //margin: const EdgeInsets.only(top: 20.0),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                txt,
                style: TextStyle(
                  fontSize: multiplier * unitHeightValue,
                ),
              )));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Info"),
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
                            image: AssetImage("assets/imgs/blue_hair_girl.png"),
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
                                "How to master hiragana",
                                style: TextStyle(
                                  fontSize: multiplier * unitHeightValue,
                                ),
                              ))),
                    ),
                  ])),

              Flexible(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              generateText("Step 1 – Learn 10 characters at a time"),
                              generateText("Note: different fonts are intentionally used to show the slight variations fonts make to hiragana characters. In cases of significant variations (e.g. ki, sa, so, ri) both characters are provided to ensure you can recognise the characters regardless of the font used."),
                              generateText("Step 2 – Test your hiragana character knowledge by playing the multiple choice; drag quiz and match all games."),
                              generateText("Step 3 – Once you have learned all of the hiragana characters, practise reading and learning the vocabulary listed on each of the flashcards."),
                              generateText("Notes: Only hiragana and English are used for the Japanese vocabulary to encourage hiragana mastery."),
                              generateText("If you see a small/half-size ‘tsu’ っ when reading the hiragana vocabulary, it represents an additional consonant (e.g. きっぷ - kippu)."),
                              generateText("The ‘u’ う character becomes a long ‘o’ sound when it follows a character that ends in an ‘o’. (e.g. ありがとう - arigatoo/arigatõ)."),
                              generateText("Step 4 – Use the draw function to follow the stroke order diagrams on the back of each card to learn how to write each character.  Then copy the stroke order to write the characters on paper to master writing hiragana."),
                              generateText("For more information, fun ideas and FREE resources visit www.japres.com.au"),
                              generateText("HAVE FUN LEARNING HIRAGANA!"),
                            ])
                    ),
                ),
              ),

            ],
          ),
        ),

        /*persistentFooterButtons: [
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    child: Text('Info'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/info');
                    },
                  ),
                ),

              ],
            ),
          )
        ]*/

    );
  }
}
