import 'dart:ui';

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

  void sortCards(){
    List<ObjTwoSideCard> tmpobjlstcards = new List<ObjTwoSideCard>();
    for(int i = 0; i < this.objlstcards.length; i++) {
      var cn = this.objlstcards[i].side1;
      if(cn.contains("_")){
        if(cn.contains("Info")){
          tmpobjlstcards.add(this.objlstcards[i]);
          break;
        }
      }
    }
    for(int i = 0; i < this.objlstcards.length; i++){

      for(int s = 0; s < this.objlstcards.length; s++) {
        var cn = this.objlstcards[s].side1;
        if(cn.contains("_")){
          int cnum = int.parse(cn.split("_")[1]);
          if(cnum == (i+1)){
            print(this.objlstcards[s].cardnumber);

            if(!cn.contains("Info")){
              tmpobjlstcards.add(this.objlstcards[s]);
            }
            //print((i+1).toString() + "/" + this.objlstcards[s].cardnumber.toString());
            break;
          }
        }else{
          print(cn);
        }
        /*


        */
      }

      //print(this.objlstcards[i].cardnumber);
    }
    print(tmpobjlstcards.length.toString() + "/" + this.objlstcards.length.toString());
    this.objlstcards = tmpobjlstcards;
  }
}


var characters = [
  ["a","???","???"],
  ["ka","???","???"],
  ["sa","???","???"],
  ["ta","???","???"],
  ["na","???","???"],
  ["ha","???","???"],
  ["ma","???","???"],
  ["ya","???","???"],
  ["ra","???","???"],
  ["wa","???","???"],
  ["n","???","???"],
  ["i","???","???"],
  ["ki","???","???"],
  ["shi","???","???"],
  ["chi","???","???"],
  ["ni","???","???"],
  ["hi","???","???"],
  ["mi","???","???"],
  ["ri","???","???"],
  ["u","???","???"],
  ["ku","???","???"],
  ["su","???","v???"],
  ["tsu","???","???"],
  ["nu","???","???"],
  ["fu","???","???"],
  ["mu","???","???"],
  ["yu","???","???"],
  ["ru","???","???"],
  ["o","???","???"],
  ["e","???","???"],
  ["ke","???","???"],
  ["se","???","???"],
  ["te","???","???"],
  ["ne","???","???"],
  ["he","???","???"],
  ["me","???","???"],
  ["re","???","???"],
  ["ko","???","???"],
  ["so","???","???"],
  ["to","???","???"],
  ["no","???","???"],
  ["ho","???","???"],
  ["mo","???","???"],
  ["yo","???","???"],
  ["ro","???","???"],
  ["wo/o","???","???"],//46

  //Handakuon 5 = 51
  ["pa","???"],
  ["pi","???"],
  ["pu","???"],
  ["pe","???"],
  ["po","???"],

  //dakuon 20 = 71
  ["ga","???"],["gi","???"],["gu","???"],["ge","???"],["go","???"],
  ["za","???"],/*["ji","???"],["zu","???"],*/["ze","???"],["zo","???"],
  ["da","???"],["ji","???"],["zu","???"],["de","???"],["do","???"],
  ["ba","???"],["bi","???"],["bu","???"],["be","???"],["bo","???"],

  //yoon 33 = 104
  ["kya","??????"],["kyu","??????"],["kyo","??????"],
  ["sha","??????"],["shu","??????"],["sho","??????"],
  ["cha","??????"],["chu","??????"],["cho","??????"],
  ["nya","??????"],["nyu","??????"],["nyo","??????"],
  ["hya","??????"],["hyu","??????"],["hyo","??????"],
  ["mya","??????"],["myu","??????"],["myo","??????"],
  ["rya","??????"],["ryu","??????"],["ryo","??????"],
  ["gya","??????"],["gyu","??????"],["gyo","??????"],
  ["ja","??????"],["ju","??????"],["jo","??????"],    // is in twice two different characters
  ["bya","??????"],["byu","??????"],["byo","??????"],
  ["pya","??????"],["pyu","??????"],["pyo","??????"],
  
];


class ObjQuizResults{
  final String title;
  final String results;
  ObjQuizResults(this.title,this.results);
}

class ObjPassQuiz{
  final String title;
  final String group;
  final List<List<String>> normal;
  final List<List<String>> random1;
  final List<List<String>> random2;
  ObjPassQuiz(this.title,this.normal,this.random1,this.random2,this.group);
}

class ObjColorAnswers{
  final String name;
  final Color color;
  double X;
  double Y;
  ObjColorAnswers(this.name,this.color,this.X,this.Y);
}

List<List<String>> getCharacterGroup(int from,int to){
  List<List<String>> lst = new List<List<String>>();
  for(int i = from;i <= to;i++){
    lst.add(characters[i]);
  }
  return lst;
}

List<List<String>> generateRandom(int from,int to, int count){
  print("count " + count.toString());
  List<List<String>> random = new List<List<String>>();
  for(int i = 0; i< characters.length;i++){
    if(i >= from && i <= to){

    }else{
      random.add(characters[i]);
    }
  }
  List<List<String>> shuff = random.toList()..shuffle();
  List<List<String>> generated = new List<List<String>>();
  for(int g = 0; g< count;g++){
    generated.add(shuff[g]);
  }
  return generated;
}

ObjPassQuiz generateQuizHiragana(String title,int from,int to){
  List<List<String>> normal = getCharacterGroup(from,to);
  List<List<String>> random1= generateRandom(from,to,normal.length);
  List<List<String>> random2= generateRandom(from,to,normal.length);
  String group = (from + 1).toString() + " to " + (to + 1).toString();
  ObjPassQuiz tmp = new ObjPassQuiz(title,normal,random1,random2, group );
  return tmp;
}

