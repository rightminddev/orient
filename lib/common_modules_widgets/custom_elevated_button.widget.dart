import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

class CustomElevatedButton extends StatefulWidget {
  final Future<void> Function() onPressed;
  final String title;
  final ButtonStyle? buttonStyle;
  final Widget? titleWidget;
  final double? width;
  final double? titleSize;
  final double? radius;
  final Color? backgroundColor;
  final bool? isFuture;
  final bool? isPrimaryBackground;

  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.buttonStyle,
      this.titleWidget,
      this.titleSize,
      this.backgroundColor,
      this.radius,
      this.width,
      this.isFuture = true,
      this.isPrimaryBackground = true});

  @override
  CustomElevatedButtonState createState() => CustomElevatedButtonState();
}

class CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePressed() async {
    setState(() {
      _isLoading = true;
    });
    await _controller.forward();
    await widget.onPressed();
    await _controller.reverse();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isLoading ? AppSizes.s75 : widget.width ?? AppSizes.s200,
          height: AppSizes.s50,
          child: ElevatedButton(
            style: widget.buttonStyle ??
                ElevatedButton.styleFrom(
                  backgroundColor: widget.backgroundColor ??
                      (widget.isPrimaryBackground == true
                          ? null
                          : Theme.of(context).colorScheme.secondary),
                  foregroundColor: Colors.white, // Text color
                  disabledForegroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_isLoading
                        ? AppSizes.s26
                        : widget.radius ?? AppSizes.s28),
                  ),
                ),
            onPressed: widget.isFuture == true
                ? _isLoading
                    ? () {}
                    : _handlePressed
                : widget.onPressed,
            child: widget.isFuture == true && _isLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : widget.titleWidget ??
                    Text(
                      widget.title,
                      style: widget.titleSize == null
                          ? Theme.of(context).textTheme.headlineSmall
                          : Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: widget.titleSize),
                      textAlign: TextAlign.center,
                    ),
          ),
        );
      },
    );
  }
}
