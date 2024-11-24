import 'package:flutter/material.dart';

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  const FadeInAnimation(
      {super.key,
      required this.child,
      required this.duration,
      this.delay = Duration.zero});
  @override
  _FadeInAnimationState createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.delay > Duration.zero) {
      Future.delayed(widget.delay, () {
        _controller.forward();
      });
    } else {
      _controller.forward();
    }

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

class SlideAndFadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  const SlideAndFadeAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.delay = Duration.zero,
  });
  @override
  _SlideAndFadeAnimationState createState() => _SlideAndFadeAnimationState();
}

class _SlideAndFadeAnimationState extends State<SlideAndFadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.delay > Duration.zero) {
      Future.delayed(widget.delay, () {
        _controller.forward();
      });
    } else {
      _controller.forward();
    }

    _slideAnimation = Tween<double>(begin: -25, end: 0).animate(_controller);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(_slideAnimation.value, 0),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class RevealAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  const RevealAnimation(
      {super.key,
      required this.child,
      required this.duration,
      this.delay = Duration.zero});
  @override
  _RevealAnimationState createState() => _RevealAnimationState();
}

class _RevealAnimationState extends State<RevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.delay > Duration.zero) {
      Future.delayed(widget.delay, () {
        _controller.forward();
      });
    } else {
      _controller.forward();
    }

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Align(
            alignment: Alignment.center,
            widthFactor: _animation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
