// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BumpButton extends StatefulWidget {
  const BumpButton({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  State<BumpButton> createState() => _BumpButtonState();
}

class _BumpButtonState extends State<BumpButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1, end: 1.2).animate(_controller)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _controller.forward().then(
            (value) => _controller.reverse().then((value) => widget.onTap()));
      },
      icon: Transform.scale(
        scale: _animation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
