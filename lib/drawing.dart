import 'package:flutter/material.dart';

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

//---------------drawing

class MyDrawingPage extends StatefulWidget {
  static const routeName = '/drawing';
  /*final String urlFront;
  const MyDrawingPage({
    @required this.urlFront,
    Key key,
  }) : super(key: key);*/

  @override
  _MyDrawingState createState() => _MyDrawingState();
}

class _MyDrawingState extends State<MyDrawingPage> {
  List<Offset> points = <Offset>[];
  bool isLoaded = false;
  String bg = "assets/imgs/card_bg.jpg";
  int LstCardsCount = 0;

  String urlFront = "";

  /*_MyDrawingState(String ufront) {
    urlFront = ufront;
    print(urlFront);
    //print(selectedChallengeDrawing + "yay");
    if (urlFront == "") {
      urlFront = "Card_2_a_Hiragana_O_s2.png";
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final Container sketchArea = Container(
      //constraints: BoxConstraints.expand(),

      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      //padding: EdgeInsets.all(50),
      child: Container(
          constraints: BoxConstraints.expand(),
          decoration: new BoxDecoration(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: Sketcher(points),
              ),
            ],
          )),
      //color: Colors.blueGrey[50],
    );
    final String args = ModalRoute.of(context).settings.arguments;
    if(args != null){
      urlFront = args;
    }
    
    if (urlFront == null) {
      urlFront = "";
    }
    if (urlFront != "") {
      isLoaded = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/imgs/card_bg.jpg"),
              fit: BoxFit.cover),
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
          child: Stack(
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
                          color: Colors.white),
                      //decoration: new BoxDecoration(color: Colors.white),
                      child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: isLoaded
                              ? Image.asset("assets/cards/" + urlFront)
                              : Center(
                                  child: CircularProgressIndicator(),
                                ))),
                ),
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
