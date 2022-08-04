import 'dart:math';

import 'package:flutter/material.dart';

class SimpleScaleAnimation extends StatefulWidget {
  const SimpleScaleAnimation({Key? key}) : super(key: key);

  @override
  State<SimpleScaleAnimation> createState() => _SimpleScaleAnimationState();
}

class _SimpleScaleAnimationState extends State<SimpleScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late Animation _scaleAnimation;
  late Animation _rotateAnimation;
  late Animation _jumpAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat(reverse: true);

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _scaleAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _rotateAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);
    _jumpAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -200.0))
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.bounceIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation 101"),
      ),
      body: Center(
        child: Transform.rotate(
          angle: 0,
          child: Transform.scale(
              scale: 1,
              child: Transform.translate(
                offset: _jumpAnimation.value,
                child: Container(
                  color: Colors.deepOrangeAccent,
                  width: 100,
                  height: 100,
                ),
              )),
        ),
      ),
    );
  }
}
