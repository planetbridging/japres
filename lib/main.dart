import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'Hiragana.dart';
import 'Katakana.dart';
import 'hiragana_multiple_choice.dart';
import 'katakana_multiple_choice.dart';
import 'Hiragana_quiz.dart';
import 'katakana_quiz.dart';
import 'quiz_done.dart';
import 'gallery.dart';
//import 'gallery_view.dart';
//import 'gallery_draw.dart';
import 'load_cards.dart';
import 'match_all.dart';
/*void main() => runApp(
  MaterialApp(home: Avatar()));*/


main() {

  runApp(MaterialApp(
    
    title: 'Japres',
    initialRoute: '/',
    routes: {
      HiraganaQuiz.routeName: (context) => HiraganaQuiz(),
      KatakanaQuiz.routeName: (context) => KatakanaQuiz(),
      QuizDone.routeName: (context) => QuizDone(),
      
      '/': (context) => Avatar(),
      '/mainmenu': (context) => MainMenu(),
      '/hiraganalearning': (context) => HiraganaLearning(),
      '/hiraganamutliplechoice': (context) => HiraganaMultipleChoiceLearning(),

      '/katakanalearning': (context) => KatakanaLearning(),
      '/katakanamutliplechoice': (context) => KatakanaMultipleChoiceLearning(),

      //'/gallery': (context) => Gallery(),
      //'/galleryview': (context) => GalleryView(),
      //'/gallerydraw': (context) => GalleryDraw(),
      
      '/training': (context) => PracticeWriting(),
      '/runtraining': (context) => FlipMainPage(),
      '/rundrawing': (context) => MyDrawingPage(),

      '/matchall': (context) => MatchAll(),
      //MatchAll
      //FlipMainPage
      //PracticeWriting
      
      //Gallery
      //katakanaMultipleChoiceLearning
    },
  ));
}

class Avatar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Avatar();
}

class _Avatar extends State<Avatar> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 1.25, end: 2);

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
      /*appBar: AppBar(
        title: Text(widget.title),
      ),*/
      body: Center(


        child: GestureDetector(
  onTap: () {
    Navigator.pushNamed(context, '/mainmenu');
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
                      //height: 100,
                      //width: 100,
                      //child: CircleAvatar(backgroundImage: AssetImage("assets/imgs/Logo.png")),
                      child: Center(
                        child:Image(
                          image: AssetImage("assets/imgs/Logo.png"),
                        ),
                      )
                    ),
                  ),

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