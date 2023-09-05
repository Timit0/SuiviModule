import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/card_state.dart';
import 'package:suivi_de_module/widget/list_of_widget.dart';
import 'package:suivi_de_module/widget/add_card_widget.dart';
import 'package:suivi_de_module/widget/widget_card.dart';

class DevoirTestWidget extends StatefulWidget {
  const DevoirTestWidget({super.key});

  @override
  State<DevoirTestWidget> createState() => _DevoirTestWidgetState();
}

class _DevoirTestWidgetState extends State<DevoirTestWidget> {
  @override
  Widget build(BuildContext context) {

    final ScrollController controllerDevoir = ScrollController();
    final ScrollController controllerTest = ScrollController();

    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 80, bottom: 100),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(left: 45),
          child: Text('Devoirs', textAlign: TextAlign.left, style: TextStyle(fontSize: 40)),
        ),
        ListOfWidget(
          widget: CardWidget(type: CardState.Devoir), 
          controller: controllerDevoir, 
          varDebug: 8, 
          paddingList: 50
        ),
        const Padding(
          padding: EdgeInsets.only(left: 45),
          child: Text('Tests', textAlign: TextAlign.left, style: TextStyle(fontSize: 40)),
        ),
        ListOfWidget(
          widget: CardWidget(type: CardState.Test), 
          controller: controllerTest, 
          varDebug: 8, 
          paddingList: 50
        )
      ]),
    );
  }
}