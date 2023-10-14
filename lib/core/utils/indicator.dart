import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nob/core/utils/styles.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Center(
        child: LoadingAnimationWidget.discreteCircle(
            color: Colors.grey[300]!,
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

class ContactIndicator extends StatelessWidget {
  const ContactIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body:Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: Colors.blue,
        rightDotColor: Colors.red,
        size: 20,
      ),
    ),
    );
  }
}