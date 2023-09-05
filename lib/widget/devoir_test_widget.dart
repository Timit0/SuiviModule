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

    return Column(children: [
      const Text('Devoirs', textAlign: TextAlign.left),
      ListOfWidget(
        widget: CardWidget(type: CardState.Devoir), 
        controller: controllerDevoir, 
        varDebug: 8, 
        paddingList: 50
      ),
      const Text('Tests', textAlign: TextAlign.left),
      ListOfWidget(
        widget: CardWidget(type: CardState.Test), 
        controller: controllerDevoir, 
        varDebug: 8, 
        paddingList: 50
      )
    ]);
  }
}