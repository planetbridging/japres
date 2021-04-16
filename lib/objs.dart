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


var characters = [
  ["a","あ","ア"],
  ["ka","か","カ"],
  ["sa","さ","サ"],
  ["ta","た","タ"],
  ["na","な","ナ"],
  ["ha","は","ハ"],
  ["ma","ま","マ"],
  ["ya","や","ヤ"],
  ["ra","ら","ラ"],
  ["wa","は","ハ"],
  ["n","ん","ン"],
  ["i","い","イ"],
  ["ki","き","キ"],
  ["shi","し","シ"],
  ["chi","ち","チ"],
  ["ni","に","ニ"],
  ["hi","ひ","ヒ"],
  ["mi","み","ミ"],
  ["ri","り","リ"],
  ["u","う","ウ"],
  ["ku","く","ク"],
  ["su","す","vス"],
  ["tsu","つ","ツ"],
  ["nu","ぬ","ヌ"],
  ["fu","ふ","フ"],
  ["mu","む","ム"],
  ["yu","ゆ","ユ"],
  ["ru","る","ル"],
  ["o","お","オ"],
  ["e","え","エ"],
  ["ke","け","ケ"],
  ["se","せ","セ"],
  ["te","て","テ"],
  ["ne","ね","ネ"],
  ["he","へ","ヘ"],
  ["me","め","メ"],
  ["re","れ","レ"],
  ["ko","こ","コ"],
  ["so","そ","ソ"],
  ["to","と","ト"],
  ["no","の","ノ"],
  ["ho","ほ","ホ"],
  ["mo","も","モ"],
  ["yo","よ","ヨ"],
  ["ro","ろ","ロ"],
  ["wo","を","ヲ"],//46

  //Handakuon 5 = 51
  ["pa","ぱ"],
  ["pi","ぴ"],
  ["pu","ぷ"],
  ["pe","ぺ"],
  ["po","ぽ"],

  //dakuon 20 = 71
  ["ga","が"],["gi","ぎ"],["gu","ぐ"],["ge","げ"],["go","ご"],
  ["za","ざ"],["ji","ぢ"],["zu","づ"],["ze","ぜ"],["zo","ぞ"],
  ["da","だ"],["ji","じ"],["zu","ず"],["de","で"],["do","ど"],
  ["ba","ば"],["bi","び"],["bu","ぶ"],["be","べ"],["bo","ぼ"],

  //yoon 33 = 104
  ["kya","きゃ"],["kyu","きゅ"],["kyo","きょ"],
  ["sha","しゃ"],["shu","しゅ"],["sho","しょ"],
  ["cha","ちゃ"],["chu","ちゅ"],["cho","ちょ"],
  ["nya","にゃ"],["nyu","にゅ"],["nyo","にょ"],
  ["hya","ひゃ"],["hyu","ひゅ"],["hyo","ひょ"],
  ["mya","みゃ"],["myu","みゅ"],["myo","みょ"],
  ["rya","りゃ"],["ryu","りゅ"],["ryo","りょ"],
  ["gya","ぎゃ"],["gyu","ぎゅ"],["gyo","ぎょ"],
  ["ja","じゃ"],["ju","じゅ"],["jo","じょ"],    // is in twice two different characters
  ["bya","びゃ"],["byu","びゅ"],["byo","びょ"],
  ["pya","ぴゃ"],["pyu","ぴゅ"],["pyo","ぴょ"],
  
];


class ObjQuizResults{
  final String title;
  final String results;
  ObjQuizResults(this.title,this.results);
}