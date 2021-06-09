import 'package:flutter/material.dart';
import 'package:lab4/theme/colors.dart';
import 'package:lab4/models/story_model.dart';
import 'package:provider/provider.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation sizeAnimation;
  Animation offsetAnimation;
  Animation decorationAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    sizeAnimation = Tween<double>(begin: 100.0, end: 200.0).animate(controller);
    offsetAnimation =
        Tween<Offset>(begin: Offset(-1.5, -2.5), end: Offset(0.5, 1))
            .animate(controller);

    decorationAnimation = DecorationTween(
        begin: BoxDecoration(
          color: Colors.purple,
          shape: BoxShape.rectangle,
        ),
        end: BoxDecoration(
          color: Colors.pink,
          shape: BoxShape.circle,
        )).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: Center(
        child: SlideTransition(
          position: offsetAnimation,
          child: Container(
              height: sizeAnimation.value,
              width: sizeAnimation.value,
              decoration: decorationAnimation.value),
        ),
      ),
    );
  }
}
