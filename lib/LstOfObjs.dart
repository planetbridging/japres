

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
  List<String> cardNames;
  ObjCardHat(String n, int f, int t, int g){
    this.groupnumber = g;
    this.cardNames = new List<String>();
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
      this.cardNames.add("Card " + number.toString());
    }
  }
}