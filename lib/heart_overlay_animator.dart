import 'package:flutter/material.dart';

class HeartOverlayAnimator extends StatefulWidget {
  final Stream<void> triggerAnimationStream;

  HeartOverlayAnimator({@required this.triggerAnimationStream});

  @override
  _HeartOverlayAnimatorState createState() => _HeartOverlayAnimatorState();
}

class _HeartOverlayAnimatorState extends State<HeartOverlayAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _heartController;
  Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();
    final quick = const Duration(milliseconds: 500);
    final scaleTween = Tween(begin: 0.0, end: 1.0);
    _heartController = AnimationController(duration: quick, vsync: this);
    _heartAnimation = scaleTween.animate(
      CurvedAnimation(
        parent: _heartController,
        curve: Curves.elasticOut,
      ),
    );
    _heartController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _heartController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
      }
    });

    widget.triggerAnimationStream.listen((_) {
      _heartController
        ..reset()
        ..forward();
    });
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _heartAnimation,
      child: Icon(Icons.favorite, size: 80.0, color: Colors.white70),
    );
  }
}
