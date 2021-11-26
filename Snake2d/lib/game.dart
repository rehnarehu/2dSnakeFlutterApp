import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake2d/piece.dart';

import 'control_panel.dart';
import 'direction.dart';


class GamePage extends StatefulWidget{

  @override
  _GamePageState createState()  => _GamePageState();





}


class _GamePageState extends State<GamePage>{

  List<Offset> positions = [];
  int length = 5;
  int step = 20;


  Direction direction = Direction.down;
  late double screenWidth;
  late double screenHeight;
  late int lowerBoundX, upperBoundX, lowerBoundY, upperBoundY;

  Timer? timer;
  double speed = 1;
  
  List<Piece> getPieces(){
    
    final pieces = <Piece>[];

    draw();
    for(var i =0 ; i<= length; ++i){

      if(i >= positions.length){
        continue;
      }
      pieces.add(
        Piece(
          posX: positions[i].dx.toInt(),
          posY: positions[i].dy.toInt(),
          // 4
          size: step,
          color: Colors.red,
        ),
      );
    }

    return pieces;
    
  }

  void draw() async{

    if(positions.isEmpty){
      positions.add(getRandomPositionWithinRange());
    }

    while(length > positions.length){
      positions.add(positions[positions.length - 1]);
    }
    for (var i = positions.length - 1; i > 0; i--) {
      positions[i] = positions[i - 1];
    }

    positions[0] = await getNextPosition(positions[0]);

  }
  Future<Offset> getNextPosition(Offset position) async {
    Offset nextPosition = const Offset(0, 0);

    if (direction == Direction.right) {
      nextPosition = Offset(position.dx + step, position.dy);
    } else if (direction == Direction.left) {
      nextPosition = Offset(position.dx - step, position.dy);
    } else if (direction == Direction.up) {
      nextPosition = Offset(position.dx, position.dy - step);
    } else if (direction == Direction.down) {
      nextPosition = Offset(position.dx, position.dy + step);
    }

    return nextPosition;
  }

  Offset getRandomPositionWithinRange() {
    int posX = Random().nextInt(upperBoundX) + lowerBoundX;
    int posY = Random().nextInt(upperBoundY) + lowerBoundY;
    return Offset(roundToNearestTens(posX).toDouble(), roundToNearestTens(posY).toDouble());
  }

  void changeSpeed() {
    if (timer != null && timer!.isActive) timer!.cancel();

    timer = Timer.periodic(Duration(milliseconds: 200 ~/ speed), (timer) {
      setState(() {});
    });
  }

  void restart() {
    changeSpeed();
  }

  @override
  void initState() {
    super.initState();

    restart();
  }


  int roundToNearestTens(int num) {
    int divisor = step;
    int output = (num ~/ divisor) * divisor;
    if (output == 0) {
      output += step;
    }
    return output;
  }

  Widget getControls(){
    return ControlPanel( // 1
      onTapped: (Direction newDirection) { // 2
        direction = newDirection; // 3
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    lowerBoundX = step;
    lowerBoundY = step;
    upperBoundX = roundToNearestTens(screenWidth.toInt() - step);
    upperBoundY = roundToNearestTens(screenHeight.toInt() - step);

    return Scaffold(

      body: Container(
        color: Color(0XFFF5BB00),
        child: Stack(
          children: [Stack(children: getPieces()),
            getControls()
          ]
        ),
      ),
    );
  }

}