
import 'package:flutter/material.dart';
import 'dart:math';

class Saturnloading extends StatefulWidget {
  Saturnloading({super.key});

  _SaturnloadingState _saturnloadingState = _SaturnloadingState();

  @override
  State<Saturnloading> createState() => _saturnloadingState;

  void start() {
    _saturnloadingState.start();
  }

  void stop() {
    _saturnloadingState.stop();
  }
}

class _SaturnloadingState extends State<Saturnloading> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween<double>(begin: 0, end: 2*pi).animate(_animationController!);
    _animationController!.repeat();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void start() {
    _animationController!.repeat();
  }

  void stop() {
    _animationController!.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              Image.asset('assets/images/circle.png', width: 100, height: 100,),
              Center(
                child: Image.asset('assets/images/sunny.png', width: 30, height: 30,),
              ),
              Padding(padding: EdgeInsets.all(5),
                child: Transform.rotate(
                  angle: _animation!.value,
                  origin: Offset(35, 35),
                  child: Image.asset('assets/images/saturn.png', width: 20, height: 20,),
                )
              )
            ],
          ),
        );
      }
    );
  }
}

