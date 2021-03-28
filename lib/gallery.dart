import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'ObjLst.dart';


class Gallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Gallery();
}

class _Gallery extends State<Gallery> with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 1.25, end: 2);
 

      final List<Color> circleColors = [
          Colors.red,
          Colors.yellow,
          Colors.pink,
          Colors.green,
          Colors.purple,
          Colors.orange,
          Colors.blue,          
        ];

      Color randomGenerator() {
        return circleColors[new Random().nextInt(circleColors.length)];
      }
  
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
      return  Scaffold(
          appBar: AppBar(
            title: Text("Gallery"),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      "Hiragana",
                      style: TextStyle(fontSize: 50),
                      textAlign: TextAlign.center,
                    )
                  )
                ),
                expandedHeight: 100,
                //floating: true,
              ),
              SliverGrid.count(
                crossAxisCount: 4,
                children: [
                  for(int i = 0; i < characters.length;i++)

                  new Padding(
                      padding: EdgeInsets.all(5.0),
                      child: SizedBox(
                    //width: double.infinity / 2,
                    width: MediaQuery.of(context).size.width/ 2,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        
                        Navigator.pushNamed(context, '/galleryview');
                      },
                      //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                      color: randomGenerator(),
                      child: Text(
                          characters[i][1],
                          style: TextStyle(fontSize: 50),
                        )
                    )
                    /*child: ElevatedButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, '/hiraganamutliplechoice');
                        //hiraganamutliplechoice
                      },
                      child: Text(
                          characters[i][1],
                          style: TextStyle(fontSize: 50),
                        ),
                        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)
                    ),*/
                  )
                  ),
                ],
              ),

              SliverAppBar(
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      "Katakana",
                      style: TextStyle(fontSize: 50),
                      textAlign: TextAlign.center,
                    )
                  )
                ),
                expandedHeight: 100,
                //floating: true,
              ),

              SliverGrid.count(
                crossAxisCount: 4,
                children: [
                  for(int i = 0; i < characters.length;i++)

                  new Padding(
                      padding: EdgeInsets.all(5.0),
                      child: SizedBox(
                    //width: double.infinity / 2,
                    width: MediaQuery.of(context).size.width/ 2,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        print("yay");
                      },
                      color: randomGenerator(),
                      child: Text(
                          characters[i][2],
                          style: TextStyle(fontSize: 50),
                        )
                    )

                  )
                  ),
                ],
              ),
            ],
          ),
      );
    }
}