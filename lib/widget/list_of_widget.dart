import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/devoir.dart';
import 'package:suivi_de_module/models/test.dart';
import 'add_card_widget.dart';
import 'widget_card.dart';
import '../models/card_state.dart';

class ListOfWidget extends StatelessWidget {
  ListOfWidget({super.key, required this.objects});

  //List<CardWidget> cards;
  List<Object> objects;
  late ScrollController contorller;

  @override
  Widget build(BuildContext context) {
    contorller = ScrollController();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Scrollbar(
          controller: contorller,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              controller: contorller,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: objects.length,
              itemBuilder: ((context, index) {
                if (objects[index] is Devoir) { return CardWidget(type: CardState.Devoir, name: (objects[index] as Devoir).nom); }
                else if (objects[index] is Test) { return CardWidget(type: CardState.Test, name: (objects[index] as Test).nom); }
                
                return null;
              })
            ),
          ),
        ),
      ),
    );
  }
}