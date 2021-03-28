//Romaji,Hiragana,Katakana
import 'package:flutter/material.dart';

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
  ["wo","を","ヲ"]
];


class ObjPassQuiz{
  final String title;
  final List<List<String>> normal;
  final List<List<String>> random1;
  final List<List<String>> random2;
  ObjPassQuiz(this.title,this.normal,this.random1,this.random2);
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

  ObjPassQuiz tmp = new ObjPassQuiz(title,normal,random1,random2);
  return tmp;
}