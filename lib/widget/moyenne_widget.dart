import 'package:flutter/material.dart';

class MoyenneWidget extends StatelessWidget {
  MoyenneWidget({super.key, this.border = 7});

  double border;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}