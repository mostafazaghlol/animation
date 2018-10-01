import 'dart:math';

import 'package:flutter/material.dart';

import '../Widgets/cat.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation,BoxAnimation,BoxAnimation2;
  AnimationController catAnimationController,BoxAnimationController,BoxAnimationController2;

  initState() {
    super.initState();

    catAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    BoxAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    BoxAnimationController2 = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    BoxAnimationController.forward();
    BoxAnimationController2.forward();
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: catAnimationController, curve: Curves.easeIn);
    catAnimation = Tween(begin: -35.0, end: -85.0).animate(curvedAnimation);
    CurvedAnimation curvedAnimationBox =
        CurvedAnimation(parent: BoxAnimationController, curve: Curves.linear);
    BoxAnimation = Tween(begin: pi*0.65, end: pi*0.6).animate(curvedAnimationBox);
    BoxAnimation2 = Tween(begin: pi*-0.65, end: pi*-0.6).animate(curvedAnimationBox);
    //catAnimationController.forward();
    BoxAnimation.addStatusListener((Status){
      if (Status == AnimationStatus.completed) {
        BoxAnimationController.reverse();
      } else if (Status == AnimationStatus.dismissed) {
        BoxAnimationController.forward();
      }
    });
    BoxAnimation2.addStatusListener((Status){
      if (Status == AnimationStatus.completed) {
        BoxAnimationController2.reverse();
      } else if (Status == AnimationStatus.dismissed) {
        BoxAnimationController2.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation'),
        ),
        body: GestureDetector(
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[buildAnimation(), Box(), flab(),flab2()],
            ),
          ),
          onTap: onTap,
        ));
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: cat(),
    );
  }

  void onTap() {
    if (catAnimationController.status == AnimationStatus.completed) {
      BoxAnimationController.forward();
      BoxAnimationController2.forward();
      catAnimationController.reverse();
    } else if (catAnimationController.status == AnimationStatus.dismissed) {
      catAnimationController.forward();
      BoxAnimationController.stop();
      BoxAnimationController2.stop();
    }
  }

  Widget Box() {
    return Container(
      width: 200.0,
      height: 200.0,
      color: Colors.deepPurple,
    );
  }

  Widget flab() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: BoxAnimation,
        builder: (context,child){
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle:BoxAnimation.value,
          );
        },
        child: Container(
          height: 10.0,
          width: 125.0,
          color:Colors.deepPurple,
        ),
      ),
    );
  }
  Widget flab2() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: BoxAnimation2,
        builder: (context,child){
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle:BoxAnimation2.value,
          );
        },
        child: Container(
          height: 10.0,
          width: 125.0,
          color:Colors.deepPurple,
        ),
      ),
    );
  }
}
