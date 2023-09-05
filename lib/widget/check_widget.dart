import 'package:flutter/material.dart';

class CheckWidget extends StatefulWidget {
  CheckWidget({super.key, this.checkState = false});

  @override
  State<CheckWidget> createState() => _CheckWidgetState();

  bool checkState;

  
}

class _CheckWidgetState extends State<CheckWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.checkState){
          widget.checkState = false;
        }else{
          widget.checkState = true;
        }
        print("Clik : "+ widget.checkState.toString());
        setState(() {
          
        });
      },
      child: SizedBox(
        height: 40,
        width: 40,
        child: Center(
          child: isChecked(widget.checkState)
        ),
      ),
    );
  }
}

Widget? isChecked(bool b){
  if(b){
    return const Icon(
      Icons.check,
      size: 40,
    );
  }else{
    return const ClipOval(
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.access_time_filled_outlined,
          color: Color.fromARGB(0, 255, 255, 255),
        ),
      ),
    );
  }
}