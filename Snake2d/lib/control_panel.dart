

import 'package:flutter/material.dart';
import 'package:snake2d/control_button.dart';

import 'direction.dart';

class ControlPanel extends StatelessWidget{

  final void Function(Direction) onTapped;

  const ControlPanel({Key? key, required this.onTapped}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Positioned(
     left: 0.0,
     right: 0.0,
     bottom: 50.0,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
       Expanded(child: Row(children: [
         Expanded(child: Container()),
         ControlButton(onPressed: (){onTapped(Direction.left);}, icon:const Icon(Icons.arrow_left) )
       ])),
         Expanded(child: Column(children: [
           ControlButton(onPressed: (){onTapped(Direction.up);}, icon: const Icon(Icons.arrow_drop_up_sharp)),
           const SizedBox(height: 75.0,),
           ControlButton(onPressed: (){onTapped(Direction.down);}, icon: const Icon(Icons.arrow_drop_down_sharp))

         ])),
         Expanded(child: Row(children: [
           ControlButton(onPressed: (){onTapped(Direction.right);}, icon: Icon(Icons.arrow_right)),
           Expanded(child: Container())
         ]))
     ])
   );
  }


}