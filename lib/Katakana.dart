import 'package:flutter/material.dart';

class KatakanaLearning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KatakanaLearning();
}

class _KatakanaLearning extends State<KatakanaLearning> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 1.75, end: 2);

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning katakana"),
      ),
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
                          image: AssetImage("assets/imgs/red_hair_boy_with_chest.png"),
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
                      "Learning katakana",
                      style: TextStyle(fontSize: 30),
                    )
                  )
                  
                ),


                Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                    //width: double.infinity / 2,
                    width: MediaQuery.of(context).size.width/ 2,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/katakanamutliplechoice');
                        //hiraganamutliplechoice
                      },
                      child: Text("Multiple choice"),
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