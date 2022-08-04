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

  late Animation _jumpAnimation;
  late bool _isJump = false;
  late Animation _leftrightAnimation;
  late int score = 0;
  int duration = 2500;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat(reverse: true);

    _animationControllers =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _animationControllers.addListener(() => setState(() {}));

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('Score: $score'),
              ),
            ),
            Column(
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
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _animationControllers.forward().whenComplete(
                                  () => _animationControllers.reverse());
                              _isJump = true;
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                _isJump = false;
                                score++;
                                if (score > 50) {
                                  setState(() {
                                    _animationController.repeat(
                                        reverse: true,
                                        period: Duration(milliseconds: 200));
                                  });
                                } else if (score > 30) {
                                  setState(() {
                                    _animationController.repeat(
                                        reverse: true,
                                        period: Duration(milliseconds: 1000));
                                  });
                                } else if (score > 20) {
                                  setState(() {
                                    _animationController.repeat(
                                        reverse: true,
                                        period: Duration(milliseconds: 1500));
                                  });
                                } else if (score > 10) {
                                  setState(() {
                                    _animationController.repeat(
                                        reverse: true,
                                        period: Duration(milliseconds: 2000));
                                  });
                                }
                              });
                            });
                          },
                          child: Text("JUMP")),
                      ElevatedButton(
                          onPressed: () {
                            score = 0;
                            _animationController.repeat(
                                reverse: true,
                                period: Duration(milliseconds: 2500));
                          },
                          child: Text('Restart'))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
