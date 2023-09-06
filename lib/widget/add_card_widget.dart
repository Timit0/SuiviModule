import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/card_state.dart';

class AddCardWidget extends StatelessWidget {
  AddCardWidget({super.key, this.dialog, required this.type});

  AlertDialog? dialog;
  CardState type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(context: context, builder: (conetext) => dialog ?? const AlertDialog(content: Center(child: Text('Hello World!')))),
      child: Card(
        elevation: 4,
        color: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const SizedBox(
              height: 230,
              width: 230,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                color: const Color.fromARGB(255, 201, 201, 201),
                child: const SizedBox(
                  width: 230,
                  height: 230,
                ),
              ),
            ),
            const Icon(
              Icons.add,
              size: 100,
              color: Colors.white,
            ),
          ],
        ),
      )
    );
  }
}