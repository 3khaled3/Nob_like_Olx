import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: LoadingAnimationWidget.discreteCircle(
            color: Colors.white,
            size: 70,
            secondRingColor: Colors.green,
            thirdRingColor: Colors.purple),
      ),
    );
  }
}

buildCircleIndicator() {
  return
      // ignore: avoid_unnecessary_containers
      Container(
    child: Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: Colors.blue,
        rightDotColor: Colors.red,
        size: 20,
      ),
    ),
  );
}
