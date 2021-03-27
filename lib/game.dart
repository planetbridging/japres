import 'dart:async';

import 'package:flutter/material.dart';
class MyDrawingGamePage extends StatefulWidget {


  final String urlFront;

  const MyDrawingGamePage({
    @required this.urlFront,
    Key key,
  }) : super(key: key);

  @override
  _MyDrawingGameState createState() => _MyDrawingGameState(urlFront);
}

class _MyDrawingGameState extends State<MyDrawingGamePage> {
  List<Offset> points = <Offset>[];

  String bg = "assets/cards/card_bg.jpg";
  int LstCardsCount = 0;

  String urlFront = "";

  _MyDrawingGameState(String ufront){
    urlFront = ufront;
    //print(selectedChallengeDrawing + "yay");
  }

  @override
  Widget build(BuildContext context) {
    final Container sketchArea = Container(
      //constraints: BoxConstraints.expand(),
          

      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      //padding: EdgeInsets.all(50),
      child: Container(
 
        constraints: BoxConstraints.expand(),

          child: CustomPaint(
          painter: SketcherGame(points),
        ),
      ),
      //color: Colors.blueGrey[50],
      
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Writing'),
      ),

        body: Container(
          constraints: BoxConstraints.expand(),
          child: GestureDetector(
            
            behavior: HitTestBehavior.translucent,
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox box = context.findRenderObject();
                  Offset point = box.globalToLocal(details.globalPosition);
                  point = point.translate(0.0, -(AppBar().preferredSize.height));

                  points = List.from(points)..add(point);
                });
              },
              onPanEnd: (DragEndDetails details) {
                points.add(null);
              },
              //child: sketchArea,
              child: App()
            ),
        ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'clear Screen',
        backgroundColor: Colors.red,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() => points.clear());
        },
      ),
    );
  }
}

class SketcherGame extends CustomPainter {
  final List<Offset> points;

  SketcherGame(this.points);

  @override
  bool shouldRepaint(SketcherGame oldDelegate) {
    //print(points.length);
    //paints = points;
    return oldDelegate.points != points;
  }



  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);

      }
    }


    canvas.drawLine(new Offset(50, 140), new Offset(20, 40), paint);
  }
}





class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  Column someColumn = Column(
      children: [],
    );
  
    /*AppState(){
      
       Timer(Duration(seconds: 3), () {
          Timer.periodic(Duration(seconds: 1), (timer) {
            setState(() {
someColumn.children.add(DragBox(Offset(0.0, 0.0), 'Box 45', Colors.blueAccent));
});
            
            
            print(DateTime.now());
        });
      });
    }*/

  Color caughtColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        someColumn,
        DragBox(Offset(0.0, 0.0), 'Box One', Colors.blueAccent),
        DragBox(Offset(200.0, 0.0), 'Box Two', Colors.orange),
        DragBox(Offset(300.0, 0.0), 'Box Three', Colors.lightGreen),
        Positioned(
          left: 100.0,
          bottom: 0.0,
          child: DragTarget(
            onAccept: (Color color) {
              caughtColor = color;
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                ),
                child: Center(
                  child: Text("Drag Here!"),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;

  DragBox(this.initPos, this.label, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          data: widget.itemColor,
          child: Container(
            width: 100.0,
            height: 100.0,
            color: widget.itemColor,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },
          feedback: Container(
            width: 120.0,
            height: 120.0,
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ));
  }
}
