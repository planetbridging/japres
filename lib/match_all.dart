import 'dart:async';

import 'package:flutter/material.dart';
import 'ObjLst.dart';

class MatchAll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MatchAll();
}

class _MatchAll extends State<MatchAll> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 1.75, end: 2);
  Timer _timer;
  String timerCount = "";
  int counter = 1;
  int itemsLoaded = 0;

  List duplicateChar = [
    ["a", "あ", "ア"],
    ["ka", "か", "カ"],
    ["sa", "さ", "サ"],
    ["ta", "た", "タ"],
    ["na", "な", "ナ"],
    ["ha", "は", "ハ"],
    ["ma", "ま", "マ"],
    ["ya", "や", "ヤ"],
    ["ra", "ら", "ラ"],
    ["wa", "は", "ハ"],
    ["n", "ん", "ン"],
    ["i", "い", "イ"],
    ["ki", "き", "キ"],
    ["shi", "し", "シ"],
    ["chi", "ち", "チ"],
    ["ni", "に", "ニ"],
    ["hi", "ひ", "ヒ"],
    ["mi", "み", "ミ"],
    ["ri", "り", "リ"],
    ["u", "う", "ウ"],
    ["ku", "く", "ク"],
    ["su", "す", "vス"],
    ["tsu", "つ", "ツ"],
    ["nu", "ぬ", "ヌ"],
    ["fu", "ふ", "フ"],
    ["mu", "む", "ム"],
    ["yu", "ゆ", "ユ"],
    ["ru", "る", "ル"],
    ["o", "お", "オ"],
    ["e", "え", "エ"],
    ["ke", "け", "ケ"],
    ["se", "せ", "セ"],
    ["te", "て", "テ"],
    ["ne", "ね", "ネ"],
    ["he", "へ", "ヘ"],
    ["me", "め", "メ"],
    ["re", "れ", "レ"],
    ["ko", "こ", "コ"],
    ["so", "そ", "ソ"],
    ["to", "と", "ト"],
    ["no", "の", "ノ"],
    ["ho", "ほ", "ホ"],
    ["mo", "も", "モ"],
    ["yo", "よ", "ヨ"],
    ["ro", "ろ", "ロ"],
    ["wo", "を", "ヲ"], //46

    //Handakuon 5 = 51
    ["pa", "ぱ"],
    ["pi", "ぴ"],
    ["pu", "ぷ"],
    ["pe", "ぺ"],
    ["po", "ぽ"],

    //dakuon 20 = 71
    ["ga", "が"], ["gi", "ぎ"], ["gu", "ぐ"], ["ge", "げ"], ["go", "ご"],
    ["za", "ざ"], ["ji", "ぢ"], ["zu", "づ"], ["ze", "ぜ"], ["zo", "ぞ"],
    ["da", "だ"], ["ji", "じ"], ["zu", "ず"], ["de", "で"], ["do", "ど"],
    ["ba", "ば"], ["bi", "び"], ["bu", "ぶ"], ["be", "べ"], ["bo", "ぼ"],

    //yoon 33 = 104
    ["kya", "きゃ"], ["kyu", "きゅ"], ["kyo", "きょ"],
    ["sha", "しゃ"], ["shu", "しゅ"], ["sho", "しょ"],
    ["cha", "ちゃ"], ["chu", "ちゅ"], ["cho", "ちょ"],
    ["nya", "にゃ"], ["nyu", "にゅ"], ["nyo", "にょ"],
    ["hya", "ひゃ"], ["hyu", "ひゅ"], ["hyo", "ひょ"],
    ["mya", "みゃ"], ["myu", "みゅ"], ["myo", "みょ"],
    ["rya", "りゃ"], ["ryu", "りゅ"], ["ryo", "りょ"],
    ["gya", "ぎゃ"], ["gyu", "ぎゅ"], ["gyo", "ぎょ"],
    ["ja", "じゃ"], ["ju", "じゅ"],
    ["jo", "じょ"], // is in twice two different characters
    ["bya", "びゃ"], ["byu", "びゅ"], ["byo", "びょ"],
    ["pya", "ぴゃ"], ["pyu", "ぴゅ"], ["pyo", "ぴょ"],
  ];

  List gridCharacters = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""],
    ["", "", ""],
  ];

  var gridPressed = [
    [false, false, false],
    [false, false, false],
    [false, false, false],
    [false, false, false],
  ];

  String pushIntoGrid(int n, String item) {
    int cnum = 0;
    bool stop = false;
    for (int i = 0; i < 4; i++) {
      for (int r = 0; r < 3; r++) {
        print(gridCharacters[i][r]);
        print(cnum.toString() + ",,," + n.toString());
        if (cnum == n) {
          gridCharacters[i][r] = item;
          return "";
        }
        /*
        if (cnum == n) {
          gridCharacters[i][r] = item;
          stop = true;
          break;
        }
        if (stop) {
          break;
        }
        */
        cnum += 1;
      }
    }
    print(cnum);
  }

  void firstLoadGrid() {
    //int tmpCount = 0;
    List<int> tmplst = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    List<int> tmplstshuffle = tmplst.toList()..shuffle();

    //pushIntoGrid(tmplstshuffle[0], duplicateChar[itemsLoaded][0]);
    for (int i = 0; i < 12; i += 2) {
      print(
          tmplstshuffle[i].toString() + "," + tmplstshuffle[i + 1].toString());
      pushIntoGrid(tmplstshuffle[i], duplicateChar[itemsLoaded][0]);
      pushIntoGrid(tmplstshuffle[i + 1], duplicateChar[itemsLoaded][1]);
      itemsLoaded += 1;
    }
  }

  void timerLoop() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timerCount = "Timer: " + counter.toString();
        counter += 1;
      });
    });
  }

  List<int> checkBtnPressed() {
    for (int i = 0; i < 4; i++) {
      for (int r = 0; r < 3; r++) {
        if (gridPressed[i][r]) {
          return [i, r];
        }
      }
    }
    return [-1, -1];
  }

  bool checkIfRight(String item1, String item2) {
    for (int i = 0; i < characters.length; i++) {
      if (item1 == characters[i][0] && item2 == characters[i][1] ||
          item2 == characters[i][0] && item1 == characters[i][1]) {
        return true;
      }
    }
    return false;
  }

  void btnPressed(int i, int r) {
    List<int> secPressed = checkBtnPressed();

    if (secPressed[0] != -1) {
      print("item1: " + gridCharacters[secPressed[0]][secPressed[1]]);
      print("item2: " + gridCharacters[i][r]);
      bool found = checkIfRight(
          gridCharacters[secPressed[0]][secPressed[1]], gridCharacters[i][r]);
      print("results: " + found.toString());
      gridPressed[i][r] = false;
      gridPressed[secPressed[0]][secPressed[1]] = false;
      if (found) {
        itemsLoaded += 1;
        if (itemsLoaded >= characters.length) {
          //if (itemsLoaded >= 7) {
          print("ya done");
          ObjQuizResults tmpobj = new ObjQuizResults(
            "You matched " + itemsLoaded.toString() + "/104"," in " + counter.toString() + " seconds");
      Navigator.pushNamed(context, '/quizdone',
        arguments: tmpobj
      );
        }
        gridCharacters[secPressed[0]][secPressed[1]] =
            duplicateChar[itemsLoaded][0];
        gridCharacters[i][r] = duplicateChar[itemsLoaded][1];
        gridCharacters = gridCharacters.toList()..shuffle();
      }
    } else {
      gridPressed[i][r] = true;
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);
    firstLoadGrid();
    timerLoop();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match all"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
//color: Colors.green,
              child: Column(children: [
                Center(
                  child: Text(
                    itemsLoaded.toString() + "/" + characters.length.toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Center(
                  child: Text(
                    timerCount,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                for (int i = 0; i < 4; i++)
                  Center(
                    child: Row(children: [
                      for (int r = 0; r < 3; r++)
                        SizedBox(
                          //width: double.infinity / 2,

                          width: MediaQuery.of(context).size.width / 3,
                          height: 100.0,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color:
                                gridPressed[i][r] ? Colors.green : Colors.blue,
                            onPressed: () {
                              setState(() {
                                btnPressed(i, r);
                              });
                            },
                            child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  gridCharacters[i][r],
                                  style: TextStyle(fontSize: 30),
                                )),
                          ),
                        ),
                    ]),
                  )
              ])),
        ],
      ),
    );
  }
}
