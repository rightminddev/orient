import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouterTransitions {
  /// Fade Transition :- A fade transition changes the opacity of the screen.
  static Page<dynamic> fadeTransition({
    required LocalKey key,
    required Widget child,
    required Animation<double> animation,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  ///Slide Transition :- A slide transition moves the screen in from one of the edges.
  static Page<dynamic> slideTransition({
    required LocalKey key,
    required Widget child,
    required Animation<double> animation,
    Offset begin = const Offset(1.0, 0.0),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  ///Scale Transition :- A scale transition changes the size of the screen.
  static Page<dynamic> scaleTransition({
    required LocalKey key,
    required Widget child,
    required Animation<double> animation,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  ///Rotation Transition :- A rotation transition rotates the screen.
  static Page<dynamic> rotationTransition({
    required LocalKey key,
    required Widget child,
    required Animation<double> animation,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  /// Size Transition :- A size transition changes the size of the screen along a specific axis.
  static Page<dynamic> sizeTransition({
    required LocalKey key,
    required Widget child,
    required Animation<double> animation,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SizeTransition(
          sizeFactor: CurveTween(curve: Curves.easeInOut).animate(animation),
          axisAlignment: 0.0,
          child: child,
        );
      },
    );
  }

  ///Positioned Transition :- A positioned transition animates the position of the screen using a RelativeRect.
  static Page<dynamic> positionedTransition({
    required LocalKey key,
    required Widget child,
    required Animation<double> animation,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return PositionedTransition(
          rect: RelativeRectTween(
            begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 1.0),
            end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  ///Slide Transition with Multiple Directions :- A slide transition can be customized to slide in from any direction.
  static Page<dynamic> slideTransitionWithMultipleDirections({
    required LocalKey key,
    required Widget child,
    required Animation<double> animation,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Slide from bottom to top
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  ///Combined Transitions :- You can combine multiple transitions for a more complex effect.
  static Page<dynamic> combinedTransition({
    required LocalKey key,
    required Widget child,
    required Animation<double> animation,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Slide from right to left
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}
