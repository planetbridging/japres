import 'package:flutter/material.dart';
import 'ObjLst.dart';

class QuizDone extends StatefulWidget {


  static const routeName = '/quizdone';

  @override
  State<StatefulWidget> createState() => _QuizDone();
}

class _QuizDone extends State<QuizDone> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 1.75, end: 2);

  String title = "hiragana 0 to 0";
  String results = "0/0";

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


    final ObjQuizResults args = ModalRoute.of(context).settings.arguments;
  

    if(args != null){
      //print(args.title);
      //print(args.results);
      title = args.title;
      results = args.results;
    }

    return Scaffold(
      /*appBar: AppBar(
        title: Text("Learning hiragana"),
      ),*/
      body: Center(


        child: GestureDetector(
  onTap: () {
    //Navigator.pushNamed(context, '/mainmenu');
  }, // handle your image tap here
  child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/imgs/card_bg.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
                
              child :Column (
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child:ScaleTransition(
                    scale: _tween.animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut)),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      //child: CircleAvatar(backgroundImage: AssetImage("assets/imgs/Logo.png")),
                      child: Center(
                        child:Image(
                          image: AssetImage("assets/imgs/anime_glasses_boy.png"),
                        ),
                      )
                    ),
                  ),

                ),
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
                      "Well done",
                      style: TextStyle(fontSize: 30),
                    )
                  )
                  
                ),
                  Container(
                     width: MediaQuery.of(context).size.width/ 2,
                     height: MediaQuery.of(context).size.height/ 2,
                    decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/imgs/Card-showing-fav-anime.jpg"),
                    //fit: BoxFit.cover
                  ),
                ),
                    child :Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 70.0),
                        child: Text(title ,style: TextStyle(fontSize: 30),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Text(results , style: TextStyle(fontSize: 30),),
                      )
                      
                      
                    ]
                  )
                      )
                ,Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                    //width: double.infinity / 2,
                    width: MediaQuery.of(context).size.width/ 2,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/mainmenu');
                        //hiraganamutliplechoice
                      },
                      child: Text("Main menu"),
                    ),
                  )
                  ),
              ],
              
              )   
          ),

        
        ]
          //child: 
        

        
      ),
)
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}