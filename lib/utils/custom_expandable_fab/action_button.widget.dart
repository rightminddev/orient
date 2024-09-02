import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({super.key, required this.onPressed, required this.icon});

  final Future<void> Function() onPressed;
  final Icon icon;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isLoading = false;
  void _handlePressed() async {
    setState(() {
      _isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: _isLoading ? () {} : _handlePressed,
        icon: widget.icon,
      ),
    );
  }
}
