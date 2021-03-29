
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'ObjLst.dart';


class GalleryDraw extends StatefulWidget {


  final String urlFront;

  const GalleryDraw({
    @required this.urlFront,
    Key key,
  }) : super(key: key);

  @override
  _GalleryDraw createState() => _GalleryDraw(urlFront);
}

class _GalleryDraw extends State<GalleryDraw> {
  List<Offset> points = <Offset>[];

  String bg = "assets/cards/card_bg.jpg";
  int LstCardsCount = 0;

  String urlFront = "";

  _GalleryDraw(String ufront){
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
        decoration: new BoxDecoration(
          //color: Colors.white,
                  
                ),
          child: CustomPaint(
          painter: Sketcher(points),
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
          decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/imgs/card_bg.jpg"),
                    fit: BoxFit.cover
                  ),
                ),
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
              child:  Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Center(
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
                        characters[0][1],
                        style: TextStyle(fontSize: 250),
                      )
                    )
                  )
                  ,),
              ),
              CustomPaint(
          painter: Sketcher(points),
        ),
              
            ],
          ),
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
      ..strokeWidth = 10.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);

      }
    }
  }
}