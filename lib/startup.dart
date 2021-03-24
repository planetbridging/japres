//-----------------------------------------grab cards from assets
import 'dart:convert';

import 'package:flutter/services.dart';

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

List<String> LstCards;
List<ObjCardHat> LstCardCollection;

ObjCardHat selectedCards;


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
//-----------------------------------------generate app cards from resouces

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