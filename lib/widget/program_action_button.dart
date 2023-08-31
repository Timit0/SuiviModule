import 'package:flutter/material.dart';

class ProgramActionButton extends StatefulWidget {
  ProgramActionButton({super.key, required this.func, required this.icon});

  @override
  State<ProgramActionButton> createState() => _ProgramActionButtonState();

  void Function()? func;
  IconData icon;
}

class _ProgramActionButtonState extends State<ProgramActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
        onPressed: widget.func,
        elevation: 2,
        backgroundColor: Colors.blue,
        child: Icon(widget.icon),
      );
  }
}