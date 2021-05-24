import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'training.dart';
import 'drawing.dart';
import 'match_all.dart';
import 'quiz_done.dart';
import 'objs.dart';
import 'login.dart';
import 'showweb.dart';
import 'objsWeb.dart';
import 'HiraganaMultipleChoiceLearning.dart';
import 'HiraganaQuiz.dart';
import 'minigame.dart';
import 'info.dart';

objoFacebook oFacebook = null;

void main() {
  runApp(MaterialApp(
    title: 'Japres',
    initialRoute: '/',
    routes: {
      MyDrawingPage.routeName: (context) => MyDrawingPage(),
      QuizDone.routeName: (context) => QuizDone(),
      ShowWeb.routeName: (context) => ShowWeb(),
      Login.routeName: (context) => Login(),
      HiraganaQuiz.routeName: (context) =>HiraganaQuiz(),
      '/': (context) => SplashScreen(),
      '/mainmenu': (context) => MainMenu(),
      '/training': (context) => TrainingPage(),
      '/matchall': (context) => MatchAll(),
      '/showquiz': (context) => HiraganaMultipleChoiceLearning(),
      '/p5game': (context) => MiniGame(),
      '/info': (context) => Info(),

      //p5game

      //'/login': (context) => Login(),
      //MatchAll
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.8, end: 0.9);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
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
      child: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/imgs/card_bg.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: ScaleTransition(
                  scale: _tween.animate(CurvedAnimation(
                      parent: _controller, curve: Curves.elasticOut)),
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/imgs/Logo.png"),
                    ),
                  )),
            )),
      ]),
    )));
  }
}
