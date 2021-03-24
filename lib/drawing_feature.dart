import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:core';

//--------------------------------------------drawing feature
List<Offset> paints = new List<Offset>();

class Sketcher extends CustomPainter {
  final List<Offset> points;

  Sketcher(this.points);

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    //print(points.length);
    paints = points;
    return oldDelegate.points != points;
  }



  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);

      }
    }
  }
}


class MyDrawingPage extends StatefulWidget {
  @override
  _MyDrawingState createState() => _MyDrawingState();
}

class _MyDrawingState extends State<MyDrawingPage> {
  List<Offset> points = <Offset>[];

  String bg = "assets/cards/card_bg.jpg";
  int LstCardsCount = 0;

  @override
  Widget build(BuildContext context) {
    final Container sketchArea = Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(bg),
        ),
      ),

      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      //color: Colors.blueGrey[50],
      child: CustomPaint(
        painter: Sketcher(points),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Sketcher'),
      ),
      /*body: GestureDetector(
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
        child: sketchArea,
      ),*/
        body: Stack(
          children: <Widget>[
            /*Image(
              image: AssetImage("cards/card_bg.jpg"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),*/
            GestureDetector(

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
              child: sketchArea,
            ),
           /* new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("cards/card_bg.jpg"), fit: BoxFit.cover,),
              ),

              child: GestureDetector(
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
                child: sketchArea,
              ),
            ),*/


          ],
        ),
      persistentFooterButtons: [
        RaisedButton(
          onPressed: () async{

          },
          child: const Text('Next Image', style: TextStyle(fontSize: 30)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
        RaisedButton(
          onPressed: () {
          },
          child: const Text('Compare', style: TextStyle(fontSize: 30)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
        RaisedButton(
          onPressed: (){
           
          },
          child: const Text('Save 1', style: TextStyle(fontSize: 30)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
        RaisedButton(
          onPressed: (){
  
          },
          child: const Text('Save 2', style: TextStyle(fontSize: 30)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
      ],
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