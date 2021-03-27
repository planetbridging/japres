//-----------------------------------------grab cards from assets
import 'dart:convert';

import 'package:flutter/services.dart';

import 'LstOfObjs.dart';

List<String> LstCards;
List<ObjCardHat> LstCardCollection;

ObjCardHat selectedCards;
ObjCardHat randomCards1;
ObjCardHat randomCards2;


Future<String> getFileData(String path) async {
  return await rootBundle.loadString(path);
}

Future<List<String>> getCards() async {
  String data = await getFileData('assets/cards.txt');
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


List<ObjCardHat> removeDuplicateCards(List<ObjCardHat> lst,ObjCardHat ignore){
  List<ObjCardHat> lsttmp = new List<ObjCardHat>();

  for(int i = 0; i < lst.length; i++){
    if(ignore.groupnumber != lst[i].groupnumber){
      lsttmp.add(lst[i]);
    }
  }
  return lsttmp;
}

void generateRandomCards(){
  List<ObjCardHat> randomgen1 = removeDuplicateCards(LstCardCollection,selectedCards).toList()..shuffle();
  //print(LstCardCollection.length);
  randomCards1 = randomgen1[0];
  //print("generated random cards");
  List<ObjCardHat> randomgen2 = removeDuplicateCards(randomgen1,randomCards1).toList()..shuffle();
  randomCards2 = randomgen2[0];
  //print("generated random cards");
}