import 'dart:math';

import 'package:flutter/material.dart';

class SimpleScaleAnimation extends StatefulWidget {
  const SimpleScaleAnimation({Key? key}) : super(key: key);

  @override
  State<SimpleScaleAnimation> createState() => _SimpleScaleAnimationState();
}

class _SimpleScaleAnimationState extends State<SimpleScaleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationControllers;
  late Animation _animation;
  late Animation _scaleAnimation;
  late Animation _rotateAnimation;
  late Animation _jumpAnimation;
  late bool _isJump = false;
  late Animation _leftrightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 10));

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat(reverse: true);

    _animationControllers =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _animationControllers.addListener(() => setState(() {}));

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _scaleAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _rotateAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);
    _jumpAnimation = Tween<Offset>(begin: Offset(0.0, 00), end: Offset(0, -400))
        .animate(CurvedAnimation(
            parent: _animationControllers, curve: Curves.decelerate));
    _leftrightAnimation =
        Tween<Offset>(begin: Offset(-200, -50), end: Offset(200, -50)).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.linear));
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Transform.translate(
                offset: _jumpAnimation.value,
                child: _isJump
                    ? Image.asset(
                        'assets/jump.png',
                        height: 100,
                      )
                    : Image.asset(
                        'assets/stay.png',
                        height: 100,
                      ),
              ),
            ),
            Center(
              child: Transform.translate(
                offset: _leftrightAnimation.value,
                child: Image.asset(
                  'assets/stone.png',
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _animationControllers
                          .forward()
                          .whenComplete(() => _animationControllers.reverse());
                      _isJump = true;
                      Future.delayed(const Duration(milliseconds: 500), () {
                        _isJump = false;
                      });
                    });
                  },
                  child: Text("JUMP")),
            )
          ],
        ),
      ),
    );
  }
}
