import 'package:flutter/material.dart';



class DragAll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DragAll();
}

class _DragAll extends State<DragAll> with TickerProviderStateMixin {
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
      body: Stack(
        fit: StackFit.expand,

        children: <Widget>[
          Container(
            color: Colors.red,
            //width: ,
          )
        ]
      )
    );
  }
}