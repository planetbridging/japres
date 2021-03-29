
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'ObjLst.dart';
//import 'Hiragana_quiz.dart';
//import 'katakana_quiz.dart';
class GalleryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GalleryView();
}

class _GalleryView extends State<GalleryView> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 1.25, end: 2);
  
  int itemView = 0;
  int charSelect = 1;
  int hiOrKat = 1;
  bool showAnswer = false;
  String titleItem = "Hiragana";
  String statusItem = "1/46";

  

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(milliseconds: 5000), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
dispose() {
  _controller.dispose(); // you need this
  super.dispose();
}

  @override
  Widget build(BuildContext context) {

    statusItem = (itemView + 1).toString() + "/" + (46).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Training view"),
      ),
      body: Container(
        decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/imgs/card_bg.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
               /*Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Expanded(
                      child: ElevatedButton(
                        child:Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Hiragana'),
                         ),
                        onPressed: (){
                          setState(() {
                               hiOrKat = 1;
                               charSelect = 1;
                               statusItem = (itemView + 1).toString() + "/" + (46).toString();
                               titleItem = "Hiragana";
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(

                        child:Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Katakana'),
                         ),
                        onPressed: (){
                          setState(() {
                               hiOrKat = 2;
                               charSelect = 2;
                               statusItem = (itemView + 1).toString() + "/" + (46).toString();
                               titleItem = "Katakana";
                          });
                        },
                      ),
                    ),
            ],),
          ),*/
          
              GestureDetector(
  onTap: () {
    //Navigator.pushNamed(context, '/mainmenu');
    setState(() {
        if(showAnswer){
          showAnswer = false;
          charSelect = hiOrKat;
        }else{
          showAnswer = true;
          charSelect = 0;
        }
      });
    
  }, // handle your image tap here
  child: Container(
            height: MediaQuery.of(context).copyWith().size.height,
                
                
              child :Column (
                mainAxisAlignment: MainAxisAlignment.center,
                
              children: <Widget>[
                Container(
                  //height: 20,
                  margin: const EdgeInsets.only(top: 40.0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                      titleItem,
                      style: TextStyle(fontSize: 20),
                    )
                  )
                  
                ),
                Container(
                  //height: 20,
                  margin: const EdgeInsets.only(top: 40.0,bottom: 40.0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                      statusItem,
                      style: TextStyle(fontSize: 15),
                    )
                  )
                  
                ),
                Center(
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
                      child: Text(
                        characters[itemView][charSelect],
                        style: TextStyle(fontSize: 200),
                      )
                    )
                  )
                ),               
              ],
              )   
          ),
)
            ]
          )
         
  
       
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).copyWith().size.width,
          child: Row(
            children: [
              Expanded(
                child: FlatButton(
                  child: Text('Previous'),
                  onPressed: (){
                    setState(() {
                               charSelect = hiOrKat;
                               if(itemView > 0){
                                 itemView -= 1;
                               }
                          });
                  },
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Text('Draw'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/gallerydraw');
                  },
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Text('Next'),
                  onPressed: (){
                    setState(() {
                               charSelect = hiOrKat;
                               if(itemView < characters.length - 1){
                                 itemView += 1;
                               }
                          });
                  },
                ),
              )
            ],
          ),
        )
      ],
      
      /*floatingActionButton: FloatingActionButton(
        tooltip: 'Sound',
        backgroundColor: Colors.red,
        child: Icon(IconData(58825, fontFamily: 'MaterialIcons')),
        onPressed: () async{
          AudioPlayer advancedPlayer = AudioPlayer();
          AudioCache audioCache = AudioCache();
          await audioCache.play('assets/mp3/yo.mp3',
                    mode: PlayerMode.LOW_LATENCY);
        },
      ),*/
    );
  }
}