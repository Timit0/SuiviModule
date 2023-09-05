import 'package:flutter/material.dart';

class AppButtonWidget extends StatefulWidget {
  AppButtonWidget({super.key, required this.func, this.text});

  void Function() func;
  String? text;

  @override
  State<AppButtonWidget> createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 189, 189, 189), 
      elevation: 1, 
      child: TextButton(onPressed: () {widget.func.call();}, child: Text(widget.text ?? '', style: const TextStyle(color: Colors.white)))
    );
  }
}