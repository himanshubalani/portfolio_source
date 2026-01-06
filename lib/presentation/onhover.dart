import 'package:flutter/material.dart';
class OnHover extends StatefulWidget {

  final Widget Function(bool isHovered) builder;


  const OnHover({super.key, required this.builder});

  @override
  OnHoverState createState() => OnHoverState();
}

class OnHoverState extends State<OnHover> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {

    final hovered = Matrix4.identity()..translateByDouble(0,-10,0, 0);
    final transform = isHovered ? hovered : Matrix4.identity();

    return MouseRegion(
      onEnter: (_)=> onEntered(true),
      onExit: (_)=> onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: transform,
        child: widget.builder(isHovered),
      ),
    );
  }

  void onEntered(bool isHovered){
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
