import 'package:flutter/material.dart';

class MoyenneWidget extends StatelessWidget {
  MoyenneWidget({super.key, this.border = 7, this.note = 1});

  double border;
  var note;

  Color noteColor()
  {
    if (note < 4) { return Colors.red; }
    else if (note >= 4 && note < 5.5) { return Colors.orange; }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Container( decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 3)),
      child: Column(children: [
        Container(decoration: BoxDecoration(color: noteColor()), child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Text('Moyenne', style: TextStyle(fontSize: 30)),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0),
          child: Text(note.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 70)),
        )
      ]),
    ); /*Padding(
      padding: const EdgeInsets.only(top: 75),
      child: Container(
        alignment: Alignment.center,
        height: 180,
        width: 100,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: border,
            ),
            bottom: BorderSide(
              color: Colors.black,
              width: border,
            ),
          )
        ),

        child: const Text(
          "6",
          style: TextStyle(
            fontSize: 115
          ),
        ),
      ),
    );*/
  }
}