import 'package:flutter/material.dart';

class CustomSwitchButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Duration animationDuration;
  final double width;
  final double height;
  final double padding;
  final double circleSize;

  const CustomSwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = const Color(0xff3AC0E5),
    this.inactiveColor = Colors.grey,
    this.animationDuration = const Duration(milliseconds: 300),
    this.width = 45.0,
    this.height = 28.0,
    this.circleSize = 20.0,
    this.padding = 2.0,
  });

  @override
  CustomSwitchButtonState createState() => CustomSwitchButtonState();
}

class CustomSwitchButtonState extends State<CustomSwitchButton>
    with SingleTickerProviderStateMixin {
  late Animation<Alignment> _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerLeft : Alignment.centerRight,
      end: widget.value ? Alignment.centerRight : Alignment.centerLeft,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomSwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.onChanged(!widget.value);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? widget.inactiveColor
                  : widget.activeColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(widget.padding),
              child: Align(
                alignment: _circleAnimation.value,
                child: Container(
                  width: widget.circleSize,
                  height: widget.circleSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
